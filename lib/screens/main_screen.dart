import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copsalert/screens/create_group_screen.dart';
import 'package:copsalert/screens/join_group_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  static const String id = "main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var dropdownValue;
  void getInviteCode() {}

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      home: Scaffold(
        floatingActionButton: NeumorphicFloatingActionButton(
          child: Icon(Icons.add, size: 30),
          onPressed: () {
            _settingModalBottomSheet(context);
          },
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Neumorphic(
                padding: EdgeInsets.all(14),
                style: NeumorphicStyle(),
                child: Text("Joined Group: "),

              ),

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .collection("rooms")
                    .snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                   List <DropdownMenuItem> roomsList = [];
                   for (DocumentSnapshot room in  snapshot.data.documents){

                     roomsList.add(DropdownMenuItem(child: Text(room.id) , value: room.id,));
                   }

                   return DropdownButton<dynamic>(
                     icon: Icon(Icons.arrow_downward),
                     iconSize: 15,
                     elevation: 16,
                     value: dropdownValue,
                     style: TextStyle(color: Colors.black),
                     underline: Container(
                       height: 2,
                       color: Colors.blue,
                     ),
                     onChanged: ( newValue) {
                       setState(() {
                         dropdownValue = newValue;

                       });
                     },
                     items: roomsList,
                   );



                  } else {
                    return Text("No rooms");
                  }
                },
              ),


//              Neumorphic(
//                child: FlatButton(child: Text("Join"), onPressed: (){
//                  Navigator.pushNamed(context, CreateGroupScreen.id);
//                },),
//
//              ),
              NeumorphicButton(
                pressed: null,
                provideHapticFeedback: true,
                onPressed: () {
//                  _signInAnonymously();
                  FirebaseFirestore.instance
                      .collection("rooms")
                      .doc("2334")
                      .collection("2334")
                      .doc()
                      .set({});
                },
                style: NeumorphicStyle(
                  intensity: 15,
                  depth: 10,
                  lightSource: LightSource.top,
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                padding: const EdgeInsets.all(100.0),
                child: Icon(
                  Icons.warning,
                ),
              ),
              NeumorphicButton(
                  margin: EdgeInsets.only(top: 12),
                  onPressed: () {
                    _signOut();
//                    NeumorphicTheme.of(context).themeMode =
//                    NeumorphicTheme.isUsingDark(context)
//                        ? ThemeMode.light
//                        : ThemeMode.dark;
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Sign out",
//                  style: TextStyle(color: _textColor(context)),
                  )),
//              NeumorphicButton(
//                  margin: EdgeInsets.only(top: 12),
//                  onPressed: () {
////                  NeumorphicTheme.of(context).themeMode =
////                  NeumorphicTheme.isUsingDark(context)
////                      ? ThemeMode.light
////                      : ThemeMode.dark;
//                  },
//                  style: NeumorphicStyle(
//                    shape: NeumorphicShape.flat,
//                    boxShape:
//                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
//                  ),
//                  padding: const EdgeInsets.all(12.0),
//                  child: Text(
//                    "Toggle Theme",
////                  style: TextStyle(color: _textColor(context)),
//                  )),
            ],
          ),
        ),
      ),
    );
  }

//  Color _iconsColor(BuildContext context) {
//    final theme = NeumorphicTheme.of(context);
//    if (theme.isUsingDark) {
//      return theme.current.accentColor;
//    } else {
//      return null;
//    }
//  }

//  Color _textColor(BuildContext context) {
//    if (NeumorphicTheme.isUsingDark(context)) {
//      return Colors.white;
//    } else {
//      return Colors.black;
//    }
//  }
//}
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Neumorphic(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.music_note),
                      title: new Text('Create Group'),
                      onTap: () {
                        Navigator.pushNamed(context, CreateGroupScreen.id);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.videocam),
                    title: new Text('Join Group'),
                    onTap: () {
                      Navigator.pushNamed(context, JoinGroupScreen.id);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Future<void> _signInAnonymously() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (e) {
    print(e); // TODO: show dialog with error
  }
}

Future<void> _signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e); // TODO: show dialog with error
  }
}
