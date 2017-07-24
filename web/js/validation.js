/**
 * Created by oliver on 2017/7/12.
 */
function formValidation(){
    var result = true;
    var database_url = document.getElementById("database[url]").value;
    var database_port = document.getElementById("database[port]").value;
    var database_database = document.getElementById("database[database]").value;
    var database_user = document.getElementById("database[user]").value;
    var database_pwd = document.getElementById("database[pwd]").value;


    var re = new RegExp("[1|2]{0,1}?[0-9][0-9]\.[1|2]{0,1}?[0-9][0-9]\.[1|2]{0,1}?[0-9][0-9]\.[1|2]{0,1}?[0-9][0-9]");
    if(re.test(database_url)){
        result = false;
        alert("The url of database is valid!");
        return result;
    }
    return result;
}