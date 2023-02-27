# https://fastapi.tiangolo.com/tutorial/testing/
#
# Comando para levantar el servicio del API
# uvicorn main:app --reload --host=192.168.100.108 --port=9000

from fastapi import FastAPI, Query, HTTPException
from pydantic import BaseModel
from typing import Optional
from uuid import uuid4

import json
import os

from db import connection
os.system('clear')


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
        "name" : "/users/login",
        "description" : """Provee la manera de validar un usuario y una contraseña, retornando un token relacionado a la sesión iniciada en caso de que las credenciales sean las correctas.<br><br>
        En caso de que las credenciales sean incorrectas, devuelve una notificación de fallo en inicio de sesión, indicando que el usuario o la contraseña son incorrectos.<br><br>
        El usuario y contraseña predeterminados para pruebas es <strong>admin</strong> / <strong>admin</strong> , retornando el token <strong>f27a729e-2489-41da-bcd0-20c487dfd4da</strong>"""
    },
    {
        "name" : "/users/validateToken",
        "description": "Valida si un token proveido por la interfaz es válido o no. El token para pruebas es <strong>f27a729e-2489-41da-bcd0-20c487dfd4da</strong>"
    }
]
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

@app.post("/users/login", tags=["/users/login"])
def users_login(username: str, password: str):
    if username == "admin" and password == "admin":
        # rand_token = uuid4()
        return {
            "status_code" : 201,
            "status" : "OK",
            "token" : "f27a729e-2489-41da-bcd0-20c487dfd4da",
            "message" : "Inicio de sesion registrado"
        }
    else:
        return {
            "status_code" : 401,
            "status" : "ERROR",
            "token" : None,
            "message" : "Credenciales invalidas"
            }

@app.post("/users/validateToken", tags=["/users/validateToken"])
def users_validate_token(token: str):
    if token == "f27a729e-2489-41da-bcd0-20c487dfd4da":
        return {
            "status_code" : 200
            }
    else:
        return {
            "status_code" : 401
        }

# parametrosDesdeFrontEnd =[{
#     "nombre": 'a',
#     "edad": 35,
#     }]

# conn = connection()
# results = conn.runSP('sp_personas_get_all',parametrosDesdeFrontEnd)
# print(results)
# del conn

