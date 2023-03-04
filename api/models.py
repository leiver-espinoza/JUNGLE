from pydantic import BaseModel
from typing import Optional

class Defaults:
    ADMIN_USERNAME = "admin"
    ADMIN_PASSWORD = "admin"
    ADMIN_TOKEN = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    SERVICE_ACCOUNT = "remote_client"
    SERVICE_API_KEY = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    SERVICE_SECRET_KEY = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    SERVICE_TOKEN = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    
# %%
# INICIO - Login y validación de permisos 

class Request_UserLogin(BaseModel):
    username: str = Defaults.ADMIN_USERNAME
    password: str = Defaults.ADMIN_PASSWORD

class Request_ServiceLogin(BaseModel):
    username: str = Defaults.SERVICE_ACCOUNT
    api_key: str = Defaults.SERVICE_API_KEY
    secret_key: str = Defaults.SERVICE_SECRET_KEY

class Request_ValidateToken(BaseModel):
    token: str = Defaults.ADMIN_TOKEN

class Request_HasPermissionsToken(BaseModel):
    username: str = Defaults.ADMIN_USERNAME
    token_value: str = Defaults.ADMIN_TOKEN
    guard_name: str

class Request_HasPermissionsUser(BaseModel):
    username: str = Defaults.ADMIN_USERNAME
    guard_name: str

# FIN - Login y validación de permisos 

# %%
# INICIO - Usuarios

class Request_UsersAdd(BaseModel):
    token_owner: str = Defaults.ADMIN_USERNAME
    token_value: str = Defaults.ADMIN_TOKEN
    name_first: str = ""
    name_last: str = ""
    email: str = ""
    username: str = ""
    password: str = ""
    enabled: bool

class Request_UsersRead(BaseModel):
    token_owner: str = Defaults.ADMIN_USERNAME
    token_value: str  = Defaults.ADMIN_TOKEN
    id: int

class Request_UsersReadAll(BaseModel):
    token_owner: str = Defaults.ADMIN_USERNAME
    token_value: str = Defaults.ADMIN_TOKEN
    name_first: Optional[str] = ""
    name_last: Optional[str] = ""
    email: Optional[str] = ""
    username: Optional[str] = ""
    enabled: Optional[bool] = True

class Request_UsersUpdate(BaseModel):
    token_owner: str = Defaults.ADMIN_USERNAME
    token_value: str = Defaults.ADMIN_TOKEN
    id: int = 2
    name_first: Optional[str] = ""
    name_last: Optional[str] = ""
    email: Optional[str] = ""
    username: Optional[str] = ""
    enabled: Optional[bool] = True

class Request_UsersDelete(BaseModel):
    token_owner: str = Defaults.ADMIN_USERNAME
    token_value: str  = Defaults.ADMIN_TOKEN
    id: int

# FIN - Usuarios