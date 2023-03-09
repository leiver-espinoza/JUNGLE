# https://fastapi.tiangolo.com/tutorial/testing/
# 
# HTTP response status codes
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#successful_responses
#
# Comando para levantar el servicio del API
# uvicorn main:app --reload --host=192.168.100.108 --port=9000 --app-dir=/home/ubuntu/JUNGLE/api/

# %% Imports
from fastapi import FastAPI, Query, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware

from pydantic import BaseModel
from typing import Optional
from uuid import uuid4

import json
import os

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
        "name" : "Inicio de sesión (Usuarios)",
        "description" : f"""Provee la manera de validar un usuario y una contraseña, retornando un token relacionado a la sesión iniciada en caso de que las credenciales sean las correctas.<br><br>
        En caso de que las credenciales sean incorrectas, devuelve una notificación de fallo en inicio de sesión, indicando que el usuario o la contraseña son incorrectos.<br><br>
        El usuario y contraseña predeterminados para pruebas a nivel administrador es <strong>{models.Defaults.ADMIN_USERNAME}</strong> / <strong>{models.Defaults.ADMIN_PASSWORD}</strong>"""
    },
    {
        "name" : "Inicio de sesión (Servicios)",
        "description" : f"""***DESCRIPICON PENDIENTE DE COLOCAR***"""
    },
    {
        "name" : "Validar Permisos por Usuario",
        "description": """Retorna True en caso de que el usuario cuente con los permisos para ejecutar una accion,
        basado en las tablas de asignación de roles y permisos, o False en caso contrario."""
    },
    {
        "name" : "Usuarios",
        "description" : """<h3>Acciones específicas dedicadas a la tabla de usuarios</h3><br>
        <table style="border: 1px solid">
            <tr><td><strong>Crear un usuario (/users/create):</strong> Permite agregar un nuevo usuario a la base de datos</td></tr>
            <tr><td><strong>Leer un Usuario (/users/read):</strong> Retorna los datos de un usuario con base al ID de usuario proveído</td></tr>
            <tr><td><strong>Leer Múltiples Usuarios (/users/read_all):</strong> Retorna la lista completa de usuarios que cumplan con los parámetros especificados</td></tr>
            <tr><td><strong>Actualizar un Usuario (/users/update):</strong> Actualiza un registro de la tabla de usuarios con base a la información contenida en el parámetro de tipo JSON</td></tr>
            <tr><td><strong>Eliminar un Usuario (/users/delete):</strong> Elimina el registro de un usuario con base al ID de usuario proveído</td></tr>
        </table>
        """
    },
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

@app.post("/users/login", tags=["Inicio de sesión (Usuarios)"])
def users_login(request_user_login: models.Request_UserLogin, status_code=200):
    username = request_user_login.username
    if validate_permissions_by_user(username, 'login_web'):
        # password = request_user_login.password
        conn = connection()
        results = conn.runSP('sp_users_login',request_user_login.json())
        return return_api_result(results)
        # if username == models.Defaults.ADMIN_USERNAME and password == models.Defaults.ADMIN_PASSWORD:
        #     results = {"token" : models.Defaults.ADMIN_TOKEN}
        #     return return_api_result(results)
        # else:
        #     results = None
        #     return_api_result(None,status.HTTP_401_UNAUTHORIZED,LABELS.ERRORS.CATALOG.get("invalid_credentials"))

@app.post("/service/login", tags=["Inicio de sesión (Servicios)"])
def service_login(request_service_login: models.Request_ServiceLogin, status_code=200):
    username = request_service_login.username
    if validate_permissions_by_user(username, 'login_service'):
        api_key = request_service_login.api_key
        secret_key = request_service_login.secret_key
        if (username == models.Defaults.SERVICE_ACCOUNT and
            api_key == models.Defaults.SERVICE_API_KEY and
            secret_key == models.Defaults.SERVICE_SECRET_KEY):
            results = {"token" : models.Defaults.SERVICE_TOKEN}
            return return_api_result(results)
        else:
            results = None
            return_api_result(None,status.HTTP_401_UNAUTHORIZED,LABELS.ERRORS.CATALOG.get("invalid_service_account"))

# @app.post("/users/validateToken", tags=["Validar Token"], status_code=200)
# def users_validate_token(request_validate_token: models.Request_ValidateToken, status_code=200):
#     if request_validate_token.token == models.Defaults.ADMIN_TOKEN:
#         results = {"token_status" : "OK"}
#         return return_api_result(results)
#     else:
#         return_api_result(None,status.HTTP_401_UNAUTHORIZED,LABELS.ERRORS.CATALOG.get("invalid_token"))

@app.post("/permissions/validate/user", tags=["Validar Permisos por Usuario"], status_code=200)
def permissions_validate_user(request_has_permissions_user: models.Request_HasPermissionsUser):
    conn = connection()
    results = conn.runSP('[dbo].[sp_validate_has_permission_user]',request_has_permissions_user.json())
    return return_api_result(results)

@app.post("/users/create", tags=["Usuarios"], status_code=201)
def create_user(request_users_add: models.Request_UsersAdd):
    if validate_permissions_by_token(request_users_add, 'users_create'):
        conn = connection()
        results = conn.runSP('[dbo].[sp_users_create]',request_users_add.json(),True)
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

# %% Methods for API usage without Entry Points

#@app.post("/permissions/validate/token", tags=["Validar Permisos por Token"], status_code=200)
def permissions_validate_token(request_has_permissions_token: models.Request_HasPermissionsToken):
    conn = connection()
    results = conn.runSP('[dbo].[sp_validate_has_permission_token]',request_has_permissions_token.json())
    return return_api_result(results)

def validate_permissions_by_token(request: models.Request_HasPermissionsToken, guard_name: str):
    auth_request = models.Request_HasPermissionsToken(
        username=request.token_owner,
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
    print(guard_results)
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
        elif data:
            return {
                "data" : data
            }
        elif "error" in data:
            raise HTTPException(
                status_code=http_exception,
                detail=data["detail"]
            )
    else:
        raise HTTPException(
            status_code=http_exception,
            detail=expection_detail
        )

# %% Manual Tests

# request_users_add =  models.Request_UsersAdd(
#   token_owner= "admin",
#   token_value= "f27a729e-2489-41da-bcd0-20c487dfd4da",
#   name_first = "string",
#   name_last = "string",
#   email = "string",
#   username = "string",
#   password = "string",
#   enabled = True
# )
# users_create(request_users_add)

# request_users_read = models.Request_UsersRead(
#     token_owner="adminx",
#     token_value="f27a729e-2489-41da-bcd0-20c487dfd4da",
#     user_id=3
# )
# users_read(request_users_read)

# request_user_update = models.Request_UsersUpdate(
#   token_owner= "admin",
#   token_value= "f27a729e-2489-41da-bcd0-20c487dfd4da",
#   id= 2,
#   name_first= "leiver",
#   name_last= "espinoza",
#   email= "leiver@leiver.com",
#   username= "lespinoza",
#   enabled= True
# )

# users_update(request_user_update)