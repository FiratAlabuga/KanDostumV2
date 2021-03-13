import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kandostum2/app/modules/home/pages/home_page.dart';
import 'package:kandostum2/app/modules/login/controllers/account_controller.dart';
import 'package:kandostum2/app/modules/login/models/user_model.dart';
import 'package:kandostum2/app/modules/profile/controllers/profile_controller.dart';
import 'package:kandostum2/app/shared/helpers/chatconstant.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<DbHelper> dbList = List();
  DbHelper helper;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  ProfileController _controller = ProfileController();

  UserModel user;

  @override
  void initState() {
    super.initState();
    helper = DbHelper("", "", "", "");
    databaseReference = database.reference().child("to_do");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  // TextEditingController _itemEditingController = TextEditingController();
  // TextEditingController _timeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          title: Text("Kan Dostum Canlı Akış"),
           centerTitle: true,
           backgroundColor: Colors.grey[850],
           automaticallyImplyLeading: true,
         ),
        body:Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(400, 30, 0, 0),
              ),
              Container(
                height: 20,
                child: FutureBuilder<UserModel>(
                    future: _controller.getCurrentUser(),
                    builder: (context, snapshot) { 
                      setState() {

                        user = snapshot.data;
                      }
                      return !snapshot.hasData ?  CircularProgressIndicator() : 
                      Text(
                        "Hoşgeldin ${snapshot.data.name}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[700],
                            fontWeight: FontWeight.bold),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              ),
              Flexible(
                flex: 0,
                child: Center(
                  child: Form(
                    key: formkey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.subject,
                            color: Colors.purple[700],
                          ),
                          title: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Konu",
                            ),
                            initialValue: "",
                            onSaved: (val) => helper.subject = val,
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.message),
                          title: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Mesaj",
                            ),
                            initialValue: "",
                            onSaved: (val) => helper.body = val,
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Paylaş",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          color: Colors.purple[700],
                          onPressed: () {
                            handleSubmit();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Flexible(
                child: FirebaseAnimatedList(
                  query: databaseReference,
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5.5,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(dbList[index].userImageUrl),
                          // child: Text(dbList[index].time),
                          backgroundColor: Colors.purple[700],
                        ),
                        title: Text(
                            "${dbList[index].userName} : ${dbList[index].subject}"),
                        subtitle: Text("${dbList[index].body}"),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
        // floatingActionButton: FloatingActionButton(
        //   elevation: 50.0,
        //   tooltip: "Add Note",
        //   backgroundColor: Colors.purple[700],
        //   child: ListTile(
        //     title: Icon(Icons.add),
        //   ),
        //   onPressed: _showFormDialog,
        // ),
      
    
  }

  void _onEntryAdded(Event event) {
    setState(() {
      dbList.add(DbHelper.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formkey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      helper.userName = _controller.user.name;
      //helper.userImageUrl = _controller.user.picture;
      //Save Form Data To Database
      databaseReference.push().set(helper.toJson());
      // Navigator.pop(context);
    }
  }

  void _onEntryChanged(Event event) {
    var oldEntry = dbList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      dbList[dbList.indexOf(oldEntry)] = DbHelper.fromSnapshot(event.snapshot);
    });
  }
}
