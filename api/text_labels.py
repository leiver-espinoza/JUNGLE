class ERRORS:
    class CRUD:
        CREATE          = "No se puede crear el usuario nuevo. Por favor revise la información suministrada. Si el problema persiste, contacte al administrador."
        READ            = "No se puede leer registros de usuarios desde la base de datos en este momento. Intente más tarde. Si el problema persiste, contacte al administrador."
        UPDATE          = "No se puede actualizar el . Por favor revise la información suministrada. Si el problema persiste, contacte al administrador."
        DELETE          = "No se puede eliminar el registro. Por favor revise la información suministrada. Si el problema persiste, contacte al administrador."
        GENERAL_NUMBER  = "El error que se ha presentado es desconocido. Por favor repórtelo al administrador. Código de error: "
    
    CATALOG = {
        "unknown_error"             : "El error que se ha presentado es desconocido. Por favor repórtelo al administrador. Código de error: ",
        "invalid_parameters"        : "Parámetros inválidos. Por favor revise los valores proveídos y trate de nuevo",
        "invalid_credentials"       : "Nombre de usuario o contraseña son incorrectos",
        "invalid_service_account"   : "Acceso denegado a la cuenta de servicio",
        "invalid_token"             : "Token inválido o expirado",
        "invalid_authorization"     : "Transacción denegada o no autorizada",

        "00000" : "unknown_error",
        "60001" : "No se puede crear el usuario nuevo. Por favor revise la información suministrada. Si el problema persiste, contacte al administrador.",
        "60002" : "No se puede leer usuarios de la base de datos en este momento. Intente más tarde. Si el problema persiste, contacte al administrador.",
        "60003" : "No se puede actualizar el usuario. Por favor revise la información suministrada. Si el problema persiste, contacte al administrador.",
        "60004" : "No se puede eliminar el usuario."
    }

class TEXTS:
    CATALOG = {
        "token_owner"                : "Cuenta de usuario autenticado en el sistema",
        "token_value"                : "Token de seguridad asignado al usuario ya previamente autenticado",
        "user_read_id"               : "ID del registro que se desea consultar",
        "user_read_name_first"       : "Nombre del usuario (en su totalidad o una parte de)",
        "user_read_name_last"        : "Apellido del usuario (en su totalidad o una parte de)",
        "user_read_name_email"       : "Email del usuario (en su totalidad o una parte de)",
        "user_read_name_username"    : "Cuenta de usuario (en su totalidad o una parte de)",
        "user_read_enabled"          : "Estatus del usuario, sea Activo o Inactivo",
        "user_delete_id"             : "ID del registro que se desea eliminar"
    }