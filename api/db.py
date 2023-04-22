# sudo apt install pyodbc
import pyodbc as db
import json
import text_labels as LABELS

class connection:
    DRIVER_NAME = 'ODBC Driver 18 for SQL Server'

    SERVER_NAME = 'srv-sql-01'
    DATABASE_NAME = 'JUNGLE'
    USERNAME = 'JungleAPI'
    PASSWORD = 'JungleAPI'

    connection_string = f"""
        DRIVER={{{DRIVER_NAME}}};
        SERVER={SERVER_NAME};
        DATABASE={DATABASE_NAME};
        Trust_Connection=yes;
        TrustServerCertificate=yes;
        UID={USERNAME};
        PWD={PASSWORD};
    """

    tmpConnection = None

    def __init__(self) -> None:
        try:
            self.tmpConnection = db.connect(self.connection_string)
            self.tmpConnection.setdecoding(db.SQL_CHAR, encoding='latin1')
            self.tmpConnection.setencoding('latin1')
        except Exception as ex:
            print(ex)

    def execute(self,tmpSql:str):
        cursor = self.tmpConnection.cursor()
        cursor.execute(tmpSql)
        rows = cursor.fetchall()
        return rows

    def runSP(self, spName:str, spParams:str='', forceCommit:bool=False, forceResults:bool=True):
        try:
            sql = F"{spName}"
            if spParams != '':
                sql = sql + ' @json = ?'
            cursor = self.tmpConnection.cursor()
            if spParams != '':
                cursor.execute(sql, spParams)
            else:
                cursor.execute(sql)
            if forceResults:
                rows = cursor.fetchall()
            if forceCommit:
                cursor.commit()
            json_data=[]
            if forceResults:
                row_headers=[x[0] for x in cursor.description]
                for result in rows:
                    json_data.append(dict(zip(row_headers,result)))
            if len(json_data) > 0:
                return json_data
            else:
                return None
        except db.Error as ex:
            if len(ex.args) > 1:
                return {
                    "error" : get_exception_code(ex.args[1]),
                    "detail" : get_exception_detail(ex.args[1])
                }
            else:
                return {
                    "error" : "00000",
                    "detail" : LABELS.ERRORS.CATALOG.get(
                                    LABELS.ERRORS.CATALOG.get("00000"))
                }

def get_exception_code(errorCode : str = None):
    position = errorCode.find('{"code":"',0,len(errorCode))+9
    errorCode = errorCode[position:position+5]
    return errorCode


def get_exception_detail(errorCode : str = None):
    errorCode = get_exception_code(errorCode)
    if LABELS.ERRORS.CATALOG.get(errorCode):
        return LABELS.ERRORS.CATALOG.get(errorCode)
    else:
        return LABELS.ERRORS.CATALOG.get('00000') + ''