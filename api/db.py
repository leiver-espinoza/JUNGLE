# sudo apt install pyodbc
import pyodbc as db
import json

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

    def __del__(self):
        try:
            db.disconnect()
        except Exception as ex:
            return ex

    def execute(self,tmpSql:str):
        cursor = self.tmpConnection.cursor()
        cursor.execute(tmpSql)
        rows = cursor.fetchall()
        return rows

    def runSP(self, spName:str, spParams:object):
        sql = F"EXEC [JUNGLE].[dbo].[{spName}]"
        fullCommand = sql + ' ' + json.dumps(spParams)

        cursor = self.tmpConnection.cursor()
        cursor.execute(fullCommand)
        row_headers=[x[0] for x in cursor.description]
        rows = cursor.fetchall()

        json_data=[]
        for result in rows:
                json_data.append(dict(zip(row_headers,result)))
        return json.dumps(json_data)
