import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class JoinGroupScreen extends StatefulWidget {
  static const String id = "join_group_Screen";

  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  String invitationCodeToJoin = "";
  String errorMessage = "";


  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: NeumorphicAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Join Group"),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Neumorphic(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Invite Code"),
                      subtitle: TextFormField(
                        onChanged: (value){
                          setState(() {
                            invitationCodeToJoin = value;
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            invitationCodeToJoin = value;
                          });
                        },
                        decoration: InputDecoration(hintText: "Type Code Here"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                errorMessage,
              ),
              NeumorphicButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  
                  FirebaseFirestore.instance
                      .collection("rooms")
                      .doc(invitationCodeToJoin)
                      .get()
                      .then((value) {
                    if (value.exists) {
                      
                      print("Room exists");
                      setState(() {
                        errorMessage = "";
                      });

                      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).collection("rooms").doc(invitationCodeToJoin).set({
                        "inviteCode" : invitationCodeToJoin,
                      });

                      Navigator.pop(context);
                    } else {
                      print("Room does not exist");
                      setState(() {
                        errorMessage = "Room does not exist";
                      });
                    }
                  });

//
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                child: Text(
                  "Submit",
//
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
