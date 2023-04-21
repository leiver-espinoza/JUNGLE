from pydantic import BaseModel
from typing import Optional

class Defaults:
    ADMIN_USERNAME      = "administrator"
    ADMIN_PASSWORD      = "administrator"
    ADMIN_TOKEN         = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    SERVICE_ACCOUNT     = "remote_client"
    SERVICE_API_KEY     = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    SERVICE_SECRET_KEY  = "remote_client"
    SERVICE_TOKEN       = "f27a729e-2489-41da-bcd0-20c487dfd4da"
    
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
    token: str = ""

class Request_HasPermissionsToken(BaseModel):
    username: str = ""
    token_value: str = ""
    guard_name: str

class Request_HasPermissionsUser(BaseModel):
    username: str = ""
    guard_name: str

# FIN - Login y validación de permisos 

# %%
# INICIO - Usuarios

class Request_UsersAdd(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    name_first: str = ""
    name_last: str = ""
    email: str = ""
    username: str = ""
    password: str = ""
    enabled: bool

class Request_UsersRead(BaseModel):
    token_owner: str = ""
    token_value: str  = ""
    id: int

class Request_UsersReadAll(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    name_first: Optional[str] = ""
    name_last: Optional[str] = ""
    email: Optional[str] = ""
    username: Optional[str] = ""
    enabled: Optional[bool] = True

class Request_UsersUpdate(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    id: int = 2
    name_first: Optional[str] = ""
    name_last: Optional[str] = ""
    email: Optional[str] = ""
    username: Optional[str] = ""
    enabled: Optional[bool] = True

class Request_UsersDelete(BaseModel):
    token_owner: str = ""
    token_value: str  = ""
    id: int

class Request_StatsCreate(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    client_mac_address : str = ""
    indicator_key : str = ""
    ipaddress : str = ""
    value : str = ""
    reported_datetime : str = ""
# FIN - Usuarios

class Request_ClientSettings(BaseModel):
    client_mac_address: str = ""