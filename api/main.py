# https://fastapi.tiangolo.com/tutorial/testing/
# 
# HTTP response status codes
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#successful_responses
#
# CERTIFICATE ISSUE WITH ZSCALER - TO BE FIXED IN FUTURE RELEASES
# https://levelup.gitconnected.com/solve-the-dreadful-certificate-issues-in-python-requests-module-2020d922c72f
#
# Comando para levantar el servicio del API
# uvicorn main:app --reload --host=192.168.100.108 --port=9000 --app-dir=/home/ubuntu/JUNGLE/api/

# %% Imports
from fastapi import FastAPI, Query, HTTPException, status, Request
from fastapi.middleware.cors import CORSMiddleware

from pydantic import BaseModel
from typing import Optional
from uuid import uuid4

import json
import os
import re

import models
import text_labels as LABELS

from db import connection

# %% Setup parameters 

os.system('clear')

origins = [
    '*'
]

description = """
<strong>JungleAPI</strong> sirve como interface al sistema Jungle para el monitoreo de recursos en la red.

El proposito es brindar servicios para los modulos de:
- Clientes
- Indicadores
- Permisos
- Roles
- Estadisticas
- Usuarios
- Y otros
"""

tags_metadata = [
    {
        "name" : "Control de cuentas y accesos",
        "description" : ""
    },
    {
        "name" : "Usuarios",
        "description" : ""
    },
    {
        "name" : "Indicadores",
        "description" : ""
    }
]

# %% FastAPI Configuration

app = FastAPI(
    title="JungleAPI",
    description=description,
    version="0.0.1",
    #terms_of_service="URL",
    contact={
        "name": "Leiver Espinoza",
        "email": "leiver@toolsformyjob.com",
    },
    # license_info={
    #     "name": "Apache 2.0",
    #     "url": "https://www.apache.org/licenses/LICENSE-2.0.html",
    # },
    openapi_tags=tags_metadata,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# %% Entry Points

@app.post("/users/login", tags=["Control de cuentas y accesos"])
def users_login(request_user_login: models.Request_UserLogin, request: Request, status_code=200):
    username = request_user_login.username
    if validate_permissions_by_user(username, 'login_web'):
        conn = connection()
        results = conn.runSP('sp_users_login',request_user_login.json())
        return return_api_result(results, status.HTTP_401_UNAUTHORIZED)

@app.post("/service/login", tags=["Control de cuentas y accesos"])
def service_login(request_service_login: models.Request_ServiceLogin, status_code=200):
    username = request_service_login.username
    if validate_permissions_by_user(username, 'login_service'):
        conn = connection()
        results = conn.runSP('sp_clients_login',request_service_login.json(),True)
        return return_api_result(results, status.HTTP_401_UNAUTHORIZED)

# @app.post("/users/validateToken", tags=["Validar Token"], status_code=200)
# def users_validate_token(request_validate_token: models.Request_ValidateToken, status_code=200):
#     if request_validate_token.token == models.Defaults.ADMIN_TOKEN:
#         results = {"token_status" : "OK"}
#         return return_api_result(results)
#     else:
#         return_api_result(None,status.HTTP_401_UNAUTHORIZED,LABELS.ERRORS.CATALOG.get("invalid_token"))

@app.post("/permissions/validate/user", tags=["Control de cuentas y accesos"], status_code=200)
def permissions_validate_user(request_has_permissions_user: models.Request_HasPermissionsUser):
    conn = connection()
    results = conn.runSP('[dbo].[sp_validate_has_permission_user]',request_has_permissions_user.json())
    return return_api_result(results)

@app.post("/permissions/validate/token", tags=["Control de cuentas y accesos"], status_code=200)
def permissions_validate_token(request_has_permissions_token: models.Request_HasPermissionsToken):
    conn = connection()
    results = conn.runSP('[dbo].[sp_validate_has_permission_token]',request_has_permissions_token.json())
    return return_api_result(results)

@app.post("/users/logout", tags=["Control de cuentas y accesos"])
def users_logout(request_user_logout: models.Request_Logout, request: Request, status_code=200):
    conn = connection()
    results = conn.runSP('[dbo].[sp_users_logout]',request_user_logout.json(),True)
    print(results)
    return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.UPDATE)


@app.post("/users/create", tags=["Usuarios"], status_code=201)
def create_user(request_users_add: models.Request_UsersAdd):
    if validate_permissions_by_token(request_users_add, 'users_create'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_users_create]',request_users_add.json(),True,True)
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.CREATE)

@app.get("/users/read", tags=["Usuarios"], status_code=200)
def read_one_user(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_id=Query(
            0, 
            title="id", 
            description=LABELS.TEXTS.CATALOG.get("user_id_read"))
    ):
    try:
        request_users_read= models.Request_UsersRead(
            token_owner= param_token_owner,
            token_value= param_token_value,
            id=param_id
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))
    if validate_permissions_by_token(request_users_read, 'users_read'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_users_read]',request_users_read.json())
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.get("/users/read_all", tags=["Usuarios"], status_code=200)
def read_all_users(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_name_first=Query(
            "", 
            title="name_first", 
            description=LABELS.TEXTS.CATALOG.get("user_read_name_first")),
        param_name_last=Query(
            "", 
            title="name_last", 
            description=LABELS.TEXTS.CATALOG.get("user_read_name_last")),
        param_email=Query(
            "", 
            title="name_email", 
            description=LABELS.TEXTS.CATALOG.get("user_read_name_email")),
        param_username=Query(
            "", 
            title="name_username", 
            description=LABELS.TEXTS.CATALOG.get("user_read_name_username")),
        param_enabled=Query(
            True, 
            title="enabled", 
            description=LABELS.TEXTS.CATALOG.get("user_read_enabled")),
    ):
    try:
        request_users_read_all = models.Request_UsersReadAll(
            token_owner = param_token_owner,
            token_value = param_token_value,
            name_first = param_name_first,
            name_last = param_name_last,
            email = param_email,
            username = param_username,
            enabled = param_enabled
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))

    if validate_permissions_by_token(request_users_read_all, 'users_read_all'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_users_read_all]',request_users_read_all.json())
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.put("/users/update", tags=["Usuarios"], status_code=200)
def update_user(request_users_update: models.Request_UsersUpdate):
    if validate_permissions_by_token(request_users_update, 'users_update'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_users_update]',request_users_update.json(),True)
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.UPDATE)

@app.delete("/users/delete", tags=["Usuarios"], status_code=202)
def delete_user(
        param_token_owner= Query(models.Defaults.ADMIN_USERNAME, 
                                 title="token_owner", 
                                 description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(models.Defaults.ADMIN_TOKEN, 
                                 title="token_value", 
                                 description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_id=Query(0, title="id", description=LABELS.TEXTS.CATALOG.get("user_delete_id"))
    ):
    try:
        request_users_delete= models.Request_UsersDelete(
            token_owner= param_token_owner,
            token_value= param_token_value,
            id=param_id
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))
    if validate_permissions_by_token(request_users_delete, 'users_delete'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_users_delete]',request_users_delete.json(),True,False)
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.DELETE,True)


@app.post("/stats/create", tags=["Indicadores"], status_code=201)
def create_stats(request_stats_add: models.Request_StatsCreate):
    if validate_permissions_by_token(request_stats_add, 'stats_create'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_stats_create]',request_stats_add.json(),True)
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.CREATE)

@app.get("/dashboard/header", tags=["Indicadores"], status_code=200)
def get_dashboard_header(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value"))
    ):
    try:
        request_dashboard_header = models.Request_Get_DashboardHeader(
            token_owner = param_token_owner,
            token_value = param_token_value
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))

    if validate_permissions_by_token(request_dashboard_header, 'stats_read'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_dashboard_top_panel]')
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.get("/dashboard/sidepanel", tags=["Indicadores"], status_code=200)
def get_dashboard_sidepanel(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value"))
    ):
    try:
        request_dashboard_sidepanel = models.Request_Get_DashboardSidepanel(
            token_owner = param_token_owner,
            token_value = param_token_value
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))

    if validate_permissions_by_token(request_dashboard_sidepanel, 'stats_read'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_dashboard_side_panel]')
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.get("/dashboard/DashboardCBOS", tags=["Indicadores"], status_code=200)
def get_dashboard_CBOS(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_client_id= Query(
            0, 
            title="client_id", 
            description=LABELS.TEXTS.CATALOG.get("client_id"))
    ):
    try:
        request_dashboard_CBOS = models.Request_Get_DashboardCBOS(
            token_owner = param_token_owner,
            token_value = param_token_value,
            client_id = param_client_id
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))

    if validate_permissions_by_token(request_dashboard_CBOS, 'stats_read'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_dashboard_details_cbos]',request_dashboard_CBOS.json())
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.get("/dashboard/DashboardDetails", tags=["Indicadores"], status_code=200)
def get_dashboard_Details(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_client_id= Query(
            0, 
            title="client_id", 
            description=LABELS.TEXTS.CATALOG.get("client_id")),
        param_indicator_key= Query(
            "", 
            title="indicator_key", 
            description=LABELS.TEXTS.CATALOG.get("indicator_key")),
        param_records= Query(
            0, 
            title="records", 
            description=LABELS.TEXTS.CATALOG.get("records"))
    ):
    try:
        request_dashboard_details = models.Request_Get_DashboardDetails(
            token_owner = param_token_owner,
            token_value = param_token_value,
            client_id = param_client_id,
            indicator_key = param_indicator_key,
            records = param_records
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))

    if validate_permissions_by_token(request_dashboard_details, 'stats_read'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_dashboard_details_values]',request_dashboard_details.json())
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.get("/dashboard/DashboardDetailsAll", tags=["Indicadores"], status_code=200)
def get_dashboard_details_all(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_client_id= Query(
            0, 
            title="client_id", 
            description=LABELS.TEXTS.CATALOG.get("client_id"))
    ):
    try:
        request_dashboard_CBOS = models.Request_Get_DashboardCBOS(
            token_owner = param_token_owner,
            token_value = param_token_value,
            client_id = param_client_id
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))

    if validate_permissions_by_token(request_dashboard_CBOS, 'stats_read'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_dashboard_details_all]',request_dashboard_CBOS.json())
        return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.get("/clients/get_clients", tags=["Clientes"], status_code=200)
def read_client(
        param_token_owner= Query(
            models.Defaults.ADMIN_USERNAME, 
            title="token_owner", 
            description=LABELS.TEXTS.CATALOG.get("token_owner")),
        param_token_value= Query(
            models.Defaults.ADMIN_TOKEN, 
            title="token_value", 
            description=LABELS.TEXTS.CATALOG.get("token_value")),
        param_mac_address= Query(
            "", 
            title="client_mac_address", 
            description=LABELS.TEXTS.CATALOG.get("client_mac_address")),
        param_friendly_name= Query(
            "", 
            title="friendly_name", 
            description=LABELS.TEXTS.CATALOG.get("friendly_name")),
        param_netbios_name= Query(
            "", 
            title="netbios_name", 
            description=LABELS.TEXTS.CATALOG.get("netbios_name"))
    ):
    try:
        request_client = models.Request_Get_DashboardDetails(
            token_owner = param_token_owner,
            token_value = param_token_value,
            mac_address = param_mac_address,
            netbios_name = param_netbios_name,
            friendly_name = param_friendly_name
        )
    except:
        return return_api_result(None,status.HTTP_400_BAD_REQUEST,LABELS.ERRORS.CATALOG.get("invalid_parameters"))
    conn = connection()
    results = conn.runSP('[dbo].[sp_clients_read_all]',request_client.json())
    return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.post("/clients/get_settings", tags=["Clientes"], status_code=200)
def read_client_settings(request_client_settings: models.Request_ClientSettings):
    conn = connection()
    results = conn.runSP('[dbo].[sp_indicators_client_config_push_settings]',request_client_settings.json())
    update_conn = connection()
    update_conn.runSP('[dbo].[sp_clients_switch_push]',request_client_settings.json(),True,False)
    return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)

@app.post("/clients/update_settings", tags=["Clientes"], status_code=200)
def update_client_settings(request_client_settings: models.Request_Post_ClientSettings):
    conn = connection()
    print(request_client_settings)
    results = conn.runSP('[dbo].[sp_indicators_client_config_update]',request_client_settings.json(),True,True)
    return return_api_result(results,status.HTTP_400_BAD_REQUEST, LABELS.ERRORS.CRUD.READ,True)
# %% Methods for API usage without Entry Points

def validate_permissions_by_token(request: models.Request_HasPermissionsToken, guard_name: str):
    auth_request = models.Request_HasPermissionsToken(
        token_owner=request.token_owner,
        token_value=request.token_value,
        guard_name=guard_name
    )
    guard_results = permissions_validate_token(auth_request)
    if guard_results["data"][0]["authorized"]:
        return guard_results["data"][0]["authorized"]
    else:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=LABELS.ERRORS.CATALOG.get("invalid_authorization")
        )

def validate_permissions_by_user(username: str, guard_name: str):
    auth_request = models.Request_HasPermissionsUser(
        username=username,
        guard_name=guard_name
    )
    guard_results = permissions_validate_user(auth_request)
    if guard_results["data"][0]["authorized"]:
        return guard_results["data"][0]["authorized"]
    else:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Transacción denegada o no autorizada."
        )

def return_api_result(
        data: str, 
        http_exception: status = status.HTTP_400_BAD_REQUEST, 
        expection_detail: str = None, 
        allow_empty_data: bool = False):
    if data or allow_empty_data:
        if allow_empty_data and not(data):
            return {
                    "data" : None
                }
        elif "error" in data:
            raise HTTPException(
                status_code=http_exception,
                detail=data["detail"]
            )
        elif data:
            return {
                "data" : data
            }
    else:
        raise HTTPException(
            status_code=http_exception,
            detail=expection_detail
        )
