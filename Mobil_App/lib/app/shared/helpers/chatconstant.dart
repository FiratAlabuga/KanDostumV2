import 'package:firebase_database/firebase_database.dart';
class DbHelper{
  String key;
  String subject;
  String body;
  String userName;
  String userImageUrl;


  DbHelper(this.subject,this.body,this.userName,this.userImageUrl);

  DbHelper.fromSnapshot(DataSnapshot snapshot){
    key = snapshot.key;
    subject = snapshot.value["subject"];
    body = snapshot.value["body"];  
    userName = snapshot.value["userName"];
    userImageUrl = snapshot.value["userImageUrl"];  
  }

  toJson(){
    return {
      "subject" : subject,
      "body" : body,
      "userName" : userName,
      "userImageUrl" : userImageUrl,
    };
  }

}