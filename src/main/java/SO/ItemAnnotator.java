package SO;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import mySql.SqlConnector;


public class ItemAnnotator {

    public SqlConnector conn;
    public String[] classificationCategory;
    public int[] classificationCategoryCount;
    public ResultSet rs;

    private String sqlUrl;
    private String sqlUser;
    private String sqlPassword;
    private String sqlDrivenName;

    private String tableName;
    private List<String> dispalyElements;
    private String labelColumn;
    private int dispalyNumber;

    private String sql;

    //region getter and setter
    public String getSqlUrl(){
        return sqlUrl;
    }
    public void setSqlUrl(String value){
        this.sqlUrl = value;
    }

    public String getSqlUser(){
        return sqlUser;
    }
    public void setSqlUser(String value){
        this.sqlUser = value;
    }

    public String getSqlPassword(){
        return sqlPassword;
    }
    public void setSqlPassword(String value){
        this.sqlPassword = value;
    }

    public String getSqlDrivenName(){
        return sqlDrivenName;
    }
    public void setSqlDrivenName(String value){
        this.sqlDrivenName = value;
    }

    public String getTableName(){
        return tableName;
    }
    public void setTableName(String value){
        this.tableName = value;
    }

    public String getLabelColumn(){
        return labelColumn;
    }
    public void setLabelColumn(String value){
        this.labelColumn = value;
    }


    public List<String> getDispalyElements(){
        return dispalyElements;
    }
    public void setDispalyElements(List<String> value){
        if(dispalyElements == null){
            dispalyElements = new ArrayList<String>();
        }else{
            dispalyElements.clear();
        }
        for(String element : value){
            dispalyElements.add(element);
        }
    }
    public void addDisplayElement(String element){
        if(dispalyElements == null){
            dispalyElements = new ArrayList<String>();
        }
        dispalyElements.add(element);
    }

    public int getDispalyNumber(){
        return dispalyNumber;
    }
    //endregion

    public static void main(String[] args) throws Exception{
        //region main
        /*SqlConnector select = new SqlConnector("jdbc:mysql://127.0.0.1:3306/stackoverflow" ,
                "root" ,
                "woxnsk" ,
                "com.mysql.jdbc.Driver");
        select.start();

        SqlConnector selectForAnswer = new SqlConnector("jdbc:mysql://127.0.0.1:3306/stackoverflow" ,
                "root" ,
                "woxnsk" ,
                "com.mysql.jdbc.Driver");
        selectForAnswer.start();


        SqlConnector insert = new SqlConnector("jdbc:mysql://127.0.0.1:3306/stackoverflow" ,
                "root" ,
                "woxnsk" ,
                "com.mysql.jdbc.Driver");
        insert.start();

        String sql = "select Id , AcceptedAnswerId , Title , Body from lucene_question order by Id asc limit 10000";
        select.setPreparedStatement(sql);

        sql = "select body from lucene_answer where Id = ?";
        selectForAnswer.setPreparedStatement(sql);

        sql = "Insert into LIN_DATA (QuestionId , Title , QuestionBody , AnswerId , AnswerBody , API) values (? , ? , ? , ? , ? , ?)";
        insert.setPreparedStatement(sql);


        int count = 0;
        ResultSet rs = select.executeQuery();
        ResultSet question;

        String title;
        String questionId;
        String questionBody;
        String answerId;
        String answerBody;


        while(rs.next()){
            title = rs.getString(3);
            title = title.toLowerCase().trim();
            answerId = rs.getString(2);
            System.out.println(title);
            if(title.startsWith("how to") && answerId.compareTo("") != 0){
                questionId = rs.getString(1);
                questionBody = rs.getString(4);

                selectForAnswer.setInt(1 , Integer.parseInt(answerId) );
                question = selectForAnswer.executeQuery();
                if(question.next()){
                    answerBody = question.getString(1);
                    insert.setInt(1 , Integer.parseInt(questionId));
                    insert.setString(2 , title);
                    insert.setString(3 , questionBody);
                    insert.setString(4 , answerId);
                    insert.setString(5 , answerBody);
                    insert.setString( 6 , "");
                    insert.execute();
                }
            }
        }*/
        // endregion
    }



    public ItemAnnotator() {
        conn = new SqlConnector("jdbc:mysql://127.0.0.1:3306/stackoverflow" ,
                "root" ,
                "woxnsk" ,
                "com.mysql.jdbc.Driver");
        conn.start();
    }

    public ItemAnnotator(String sqlUrl , String sqlUser , String sqlPassword ){
        this.sqlUrl = sqlUrl;
        this.sqlUser = sqlUser;
        this.sqlPassword = sqlPassword;
        this.sqlDrivenName = "com.mysql.jdbc.Driver";
        conn = new SqlConnector(sqlUrl , sqlUser , sqlPassword , "com.mysql.jdbc.Driver");
        conn.start();
    }

    private boolean constructSql(){
        sql = "select ELEMENT_LIST from TABLE_NAME";
        String elementList ="" ;
        dispalyNumber = dispalyElements.size() + 1;
        if(dispalyNumber == 0 || tableName == null || tableName.compareTo("") == 0)
            return false;

        Iterator<String> it = dispalyElements.iterator();
        while(it.hasNext()){
            elementList += (it.next() + " , ");
        }
        elementList += labelColumn;

        sql = sql.replace("ELEMENT_LIST" , elementList);
        sql = sql.replace("TABLE_NAME" , tableName);
        return true;
    }

    public String[][] getAllNodes(){
        ArrayList<String[]> list = new ArrayList<String[]>();
        try{
            if(sql != null && sql.length() > 0 || constructSql()) {
                conn.setPreparedStatement(sql);
                rs = conn.executeQuery();
                while (rs.next()) {
                    String[] row = new String[dispalyNumber];
                    for (int i = 0; i < dispalyNumber; i++) {
                        row[i] = rs.getString(i + 1);
                    }
                    list.add(row);
                }
            }

        }catch(Exception e){
            list = null;
            System.out.println();
        }finally {
            return list.toArray(new String[0][]);
        }
    }

    //region old version getAllNodes
    /*
    public String[][] getAllNodes(){
        ArrayList<String[]> list = new ArrayList<String[]>();
        try{
            String sql = "select * from lin_data";
            conn.setPreparedStatement(sql);
            rs = conn.executeQuery();
            while(rs.next()){
                String[] row = new String[6];
                row[0] = rs.getString(1);
                row[1] = rs.getString(2);
                row[2] = rs.getString(3);
                row[3] = rs.getString(4);
                row[4] = rs.getString(5);
                row[5] = rs.getString(6);
                list.add(row);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }

        return list.toArray(new String[0][]);
    }*/
    //endregion


    /*public String[][] getAllNodes() throws Exception {
        ArrayList<String[]> list = new ArrayList<String[]>();
        try{
            String sql_postSelect = "select * from SOAnswerWithCode";
            conn.setPreparedStatement(sql_postSelect);
            rs = conn.executeQuery();

            while(rs.next()){
                String[] row = new String[4];//Id Body API PostId
                row[0] = rs.getString(1);
                row[1] = rs.getString(2);
                row[2] = rs.getString(3);
                row[3] = rs.getString(4);
                list.add(row);
            }
            rs.close();
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        System.out.println("获取列表大小：" + list.size());
        return list.toArray(new String[0][]);
    }*/


    //independent transaction
    public boolean createClassification(String post , String apiName) {

        return true;
    }

    /**
     * This function is used to find weather the string contain the API(apiName)
     *
     * @param string: consists of apis contained in a document in form (API1,API2,API3,...)
     * @param apiName: the name of a API
     * @return the start position of apiName , if string contain apiName,
     *         -1 , else
     *         but , it should be clear that if the string = "IndexReader,IndexWriter" and apiName = "Index" , the return value will be -1
     */

    private int indexofAPI(String string , String apiName){
        int index = -1;
        string = "," + string + ",";
        if(string.contains("," + apiName +",")){
            index = string.indexOf("," + apiName +",");// the situation is actually the start position of the first character of apiName
        }
        return index;
    }
    /**
     * deleteApiInString is used to delete a API(apiName) in the oriString
     * when apiName = "Index" , it should be deleted only in 3 cases
     * 								 1.at the start of the oriString , i.e. oriString = "Index,..." or "Index"
     * 								 2.at the middle of the oriString , i.e. oriString = "...,Index,..."
     * 								 3.at the end of the oriString , i.e. oriString = "...,Index" or "Index"
     * but be careful, when apiName just a part of another API name, for example oriString = "...,IndexWriter,..." , it should not be deleted.
     * @param oriString: the parameter consist of a set of APIs , and the APIs are organized in the form "API1,API2,API3,..."
     *  				 the form means the APIs are separated by comma
     * @param apiName: the name of a API which will be deleted from the oriString.
     * @return the changed string , if the oriString contains apiName , and delete apiName successfully
     * 		   null , other.
     */
    public String deleteApiFromString(String oriString , String apiName){
        if(oriString == null || apiName == null){
            return null;
        }else{
            oriString = oriString.trim();
            apiName = apiName.trim();
        }

        if(oriString.length() == 0 || apiName.length() == 0){
            return null;
        }

        String result = null;
        int startPosition = indexofAPI(oriString , apiName);

        //apiName should be deleted from the oriString
        if(startPosition != -1){
            result = "";
            if(startPosition != 0)
                result = oriString.substring(0 , startPosition - 1) ; // before the apiName , there is a comma, we should delete
            if(startPosition + apiName.length() < oriString.length() ){
                if(result.length() > 0)
                    result += ",";
                result += oriString.substring(startPosition + apiName.length() + 1);
            }
        }
        return result;
    }

    public String addApiInString(String oriString , String apiName){
        if(oriString == null)
            oriString = "";
        else if (apiName == null)
            return null;
        else{
            oriString = oriString.trim();
            apiName = apiName.trim();
        }

        if(apiName.length() == 0)
            return null;

        oriString = oriString.trim();
        apiName = apiName.trim();

        String result = null;
        int startPosition = indexofAPI(oriString , apiName);
        if(startPosition == -1){
            if(oriString.length() == 0){
                result = apiName;
            }else {
                result = oriString + "," + apiName;
            }
        }
        return result;
    }

    public void addTag(String itemIndex , String tag){
        addAnnotation(itemIndex , tag);
        /*try{
            String sql = "select API from SOAnswerWithCode where Id =" + post + "";

            conn.setPreparedStatement(sql);
            ResultSet rs = conn.executeQuery();
            if(rs.next()){
                String addApi = rs.getString(1);
                System.out.println("afasd" + addApi);
                addApi = addApiInString(addApi , apiName);
                //we need to update
                if(addApi != null){
                    sql = "Update SOAnswerWithCode SET API='" + addApi + "' where Id =" + post + "";
                    conn.setPreparedStatement(sql);
                    conn.execute();
                }
            }
            rs.close();
        }catch(Exception e){
            System.out.println("ERROR: some worng has happened when you add a new API which should contain in the API list of a post!");
        }*/
    }

    public void deleteTag(String itemIndex , String annotation){
        deleteAnnotation(itemIndex , annotation);
        /*
        try{
            String sql = "select API from SOAnswerWithCode where Id ='" + post + "'";
            conn.setPreparedStatement(sql);
            ResultSet rs = conn.executeQuery();
            String APIs = "";
            if(rs.next()){
                APIs = rs.getString(1);
                APIs = deleteApiFromString(APIs , apiName);
                if(APIs != null){
                    sql = "Update SOAnswerWithCode Set API = '" + APIs + "' where Id = " + post ;
                    conn.setPreparedStatement(sql);
                    conn.execute();
                }
            }
            rs.close();
        }catch(Exception e){
            System.out.println("ERROR: some wrong has happened when you delete a API in the API list of a post!");
        }*/
    }

    //change a node's classification
    public boolean addAnnotation(String itemIndex, String annotation) {
        boolean result = true;
        try{
            //String sql = "select salientAPI from Post where Uuid ='" + post + "'";
            String sql = "select API from lin_data where QuestionId='" + itemIndex +"'";

            String annotations;
            conn.setPreparedStatement(sql);
            ResultSet rs = conn.executeQuery();
            if(rs.next()){
                annotations = rs.getString(1);
                annotations = addApiInString(annotations , annotation);
                if(annotations != null ){
                    //sql = "update Post SET salientAPI=? where Uuid=?";
                    sql = "update lin_data SET API=? where QuestionId=?";
                    System.out.println("update: " + sql);
                    conn.setPreparedStatement(sql);
                    conn.setString(1, annotations);
                    conn.setString(2, itemIndex);
                    conn.execute();
                }
            }
            rs.close();
        }catch(Exception e){
            System.out.println("ERROR: some worng has happened when you add a new annotation!");
            result = false;
        }
        System.out.println();
        return result;
    }

    public boolean deleteAnnotation(String itemIndex  , String annotation) {
        boolean result = true;
        try{
            //String sql = "select salientAPI from Post where Uuid ='" + post + "'";
            String sql ="select API from lin_data where QuestionID ='" + itemIndex +"'";
            String annotations;
            conn.setPreparedStatement(sql);
            ResultSet rs = conn.executeQuery();
            if(rs.next()){
                annotations = rs.getString(1);
                annotations = deleteApiFromString(annotations , annotation);
                if(annotations != null){
                    //sql = "Update Post Set salientAPI ='" + salientAPI + "' where Uuid = '" + post + "'";
                    sql = "Update lin_data Set API='" + annotations + "' where QuestionId='" + itemIndex + "'";
                    System.out.print(annotations);
                    conn.setPreparedStatement(sql);
                    conn.execute();
                }
            }
            rs.close();
        }catch(Exception e){
            System.out.println("ERROR: some worng has happened when you delete a salientAPI in the salientAPI list of a post!");
            result = false;
        }
        System.out.println();
        return result;
    }

    public boolean deletePost(String Id){
        boolean result = false;
        try{
            String sql = "delete from SOAnswerWithCode where Id =" + Id;
            conn.setPreparedStatement(sql);
            conn.execute();
            result = true;
        }catch (Exception e){
            System.out.println(e.getMessage());
            result = false;
        }finally{
            return result;
        }
    }
}
