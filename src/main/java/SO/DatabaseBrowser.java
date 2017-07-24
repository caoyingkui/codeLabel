package SO;
import mySql.SqlConnector;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * Created by oliver on 2017/7/20.
 */
public class DatabaseBrowser {

    private SqlConnector conn;
    private String sqlUrl = "";
    private String sqlUser = "";
    private String sqlPassword = "";
    private String sqlDriverName = "";
    private String sqlDatabaseName = "";
    private String sqlTableName = "";

    private String sqlGetTablesInfo = "select TABLE_NAME from INFORMATION_SCHEMA.TABLES where table_schema='DATABASENAME' and table_type='base table'";
    private String sqlGetTableColumnInfo = "select COLUMN_NAME , DATA_TYPE from INFORMATION_SCHEMA.COLUMNS where table_name='TABLENAME'";

    private boolean dataBaseConditon;

    //region setter
    public void setSqlUrl(String value){
        sqlUrl = value;
    }

    public void setSqlUser(String value){
        sqlUser = value;
    }

    public void setSqlPassword(String value){
        sqlPassword = value;
    }

    public void setSqlDriverName(String value){
        sqlDriverName = value;
    }

    public void setSqlDatabaseName(String value){
        sqlDatabaseName = value;
    }

    public void setSqlTableName(String value){
        sqlTableName = value;
    }
    //endregion

    public static void main(String[] args){
        DatabaseBrowser test = new DatabaseBrowser("jdbc:mysql://127.0.0.1:3306/stackoverflow" ,
                "root" ,
                "woxnsk" ,
                "com.mysql.jdbc.Driver");
        test.setSqlDatabaseName("stackoverflow");
        test.setSqlTableName("lin_data");
        test.start();
        test.getTableColumnInfos();
    }

    public DatabaseBrowser(String sqlUrl , String sqlUser , String sqlPassword , String sqlDriverName){
        this.sqlUrl = sqlUrl;
        this.sqlUser = sqlUser;
        this.sqlPassword = sqlPassword;
        this.sqlDriverName = sqlDriverName;
        dataBaseConditon = false;
    }

    public boolean start(){
        boolean result;
        conn = new SqlConnector(sqlUrl , sqlUser , sqlPassword , sqlDriverName);
        result = conn.start();
        if(result)
            dataBaseConditon = true;
        return result;
    }

    public void close(){
        if(dataBaseConditon){
            conn.close();
            dataBaseConditon = false;
        }
    }

    public List <String> getTables(){
        List<String> result = new ArrayList<String>();
        if(!start())
            return null;
        else{
            try {
                String sql = sqlGetTablesInfo.replace("DATABASENAME" , sqlDatabaseName);
                conn.setPreparedStatement(sql);
                ResultSet tables = conn.executeQuery();
                result = new ArrayList<String>();
                while (tables.next()) {
                    String table = tables.getString(1);
                    result.add(table);
                    System.out.println(table);
                }
            }catch(Exception e){
                result = null;
                System.out.println(e.getMessage());
            }finally {
                conn.close();
                return result;
            }
        }
    }

    public Map<String , String> getTableColumnInfos(){
        Map<String ,String> result = new HashMap<String , String>();
        if(!start())
            return null;
        else {
            try{
                String sql = sqlGetTableColumnInfo.replace("TABLENAME" , sqlTableName);
                conn.setPreparedStatement(sql);
                ResultSet tableColumns = conn.executeQuery();
                String columnName , dataType;
                while(tableColumns.next()){
                    columnName = tableColumns.getString(1);
                    dataType = tableColumns.getString(2);
                    System.out.println(columnName + "   " + dataType);
                    result.put(columnName , dataType);
                }
            }catch(Exception e){
                result = null;
                System.out.println(e.getMessage());
            }
            finally {
                close();
                return result;
            }
        }
    }
}
