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
    token_owner: str = ""
    token_value: str = ""
    guard_name: str

class Request_HasPermissionsUser(BaseModel):
    username: str = ""
    guard_name: str

class Request_Logout(BaseModel):
    token_owner: str = ""
    token_value: str = ""

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

class Request_Clients(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    mac_address: Optional[str] = ""
    netbios_name: Optional[str] = ""
    friendly_name: Optional[str] = ""

class Request_Get_DashboardHeader(BaseModel):
    token_owner: str = ""
    token_value: str = ""

class Request_Get_DashboardSidepanel(BaseModel):
    token_owner: str = ""
    token_value: str = ""

class Request_Get_DashboardCBOS(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    client_id: int = 0

class Request_Get_DashboardDetails(BaseModel):
    token_owner: str = ""
    token_value: str = ""
    client_id: int = 0
    indicator_key: str = ""
    records: int = 100

class Request_Post_ClientSettings(BaseModel):
    id: int = 0
    interval_seconds: Optional[int] = None
    enabled: Optional[bool] = True
    threshold_l4: Optional[int] = None
    threshold_l3: Optional[int] = None
    threshold_l2: Optional[int] = None
    threshold_l1: Optional[int] = None
