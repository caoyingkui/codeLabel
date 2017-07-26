package SO;

/**
 * Created by oliver on 2017/7/11.
 */
public class PageParameter {
    public static final String database_url = "database[url]";
    public static final String database_port = "database[port]";
    public static final String database_database = "database[database]";
    public static final String database_user = "database[user]";
    public static final String database_pwd = "database[pwd]";

    public static final String pageIndex = "pageIndex";
    public static final String getAllItem = "allItem";
    public static final String deleteItem = "deleteItem";
    public static final String jumpTo = "jump";
    public static final String addTag = "addTag";
    public static final String deleteTag = "deleteTag";
    public static final String addAnnotation = "addAnnotation";
    public static final String deleteAnnotation = "deleteAddAnnotation";
    public static final String initAnnotator = "initAnnotator";
    public static final String currentAnnotator = "currentAnnotator";
    public static final String searchItemIndex = "searchItemIndex";
    public static final String isNew = "isNew";

    public static final String colorContent[] = {	"#2ecc71","#9b59b6","#34495e","#f1c40f","#e67e22",
            "#e74c3c","#bdc3c7","#7f8c8d","#16a085","#27ae60",
            "#2980b9","#8e44ad","#2c3e50","#f39c12","#d35400",
            "#c0392b","#ecf0f1","#95a5a6","#1abc9c","#3498db"};

    public static String color(int index){
        return colorContent[index % colorContent.length];
    }

}
