import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:math' show Random;

class CreateGroupScreen extends StatefulWidget {
  static const String id = "create_group_Screen";

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String inviteCode = "";
  String groupName = "";

  @override
  void initState() {
    createRandomInviteCode();
    super.initState();
  }

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
          title: Text("Create Group"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Neumorphic(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Group Name"),
                        subtitle: TextFormField(
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (value) {
                            setState(() {
                              groupName = value;
                              print(groupName);
                            });
                          },
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Invite Code"),
                        subtitle: Text(inviteCode),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Created By"),
                        subtitle: Text("Someone"),
                      ),
                    ],
                  ),
                ),
                NeumorphicButton(
                  margin: EdgeInsets.only(top: 12),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("rooms")
                        .doc(inviteCode)
                        .set({
                      "groupName": groupName,
                    }).then((value) {
//                      Navigator.pop(context);
                    });

                    FirebaseFirestore.instance
                        .collection("rooms")
                        .doc(inviteCode)
                        .collection("members")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .set({});


                    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).collection("rooms").doc(inviteCode).set({

                      "inviteCode" : inviteCode,
                    });

                    Navigator.pop(context);
//                    FirebaseFirestore.instance.collection("rooms").doc(inviteCode).collection(inviteCode).add({
//                      "groupName" : "test",
//                    });
//                  NeumorphicTheme.of(context).themeMode =
//                  NeumorphicTheme.isUsingDark(context)
//                      ? ThemeMode.light
//                      : ThemeMode.dark;
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                  child: Text(
                    "Create",
//                  style: TextStyle(color: _textColor(context)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createRandomInviteCode() {
    setState(() {
      inviteCode = randomString(5);
    });
  }
}
