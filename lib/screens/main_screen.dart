import 'dart:async';
import 'dart:io' show Platform;

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copsalert/screens/create_group_screen.dart';
import 'package:copsalert/screens/join_group_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  static const String id = "main_screen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  DropdownMenuItem dropdownValue = DropdownMenuItem(child: Text("No Rooms"), value: null,);
  var errorMessage = "";
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  void getInviteCode() {}

  playLocal() async {
    AudioPlayer audioPlayer = new AudioPlayer();
   // int result = await audioPlayer.play(localPath, isLocal: true);
  }

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        audioCache.play("test1.mp3");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: (){
                  audioCache.clear("test1.mp3");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");


        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
    super.initState();
  }
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
                    List<DropdownMenuItem> roomsList = [];
//                    roomsList.add(DropdownMenuItem(child: Text("No Room"), value: "Nothing",));
                    for (DocumentSnapshot room in snapshot.data.documents) {
                      roomsList.add(DropdownMenuItem(
                        child: Text(room.id),
                        value: room.id,
                      ));
                    }

                    return DropdownButton<dynamic>(
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 15,
                      elevation: 16,
                      value: dropdownValue.value,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),



                      onChanged: (newValue) {
                        var oldvalue;
                        print("new valueeeeeeeeeeeeeeee::: " + newValue);
                        setState(() {


                          _fcm.unsubscribeFromTopic(dropdownValue.value);


//                          dropdownValue = newValue;
                          var item = DropdownMenuItem(
                            child: Text(newValue),value: newValue,
                          );
                          dropdownValue = item;
                          if (dropdownValue.value != null){
                            _fcm.subscribeToTopic(dropdownValue.value);
                            oldvalue = dropdownValue;
                          }else{
                            errorMessage = "Please Choose or Join a Room";
                          }


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

                if (dropdownValue.value ==null ){
                  setState(() {
                    errorMessage = "Please Join a room first";
                  });
                }else{
                  print("pressed");
                  FirebaseFirestore.instance
                      .collection("rooms")
                      .doc(dropdownValue.value)
                      .collection(dropdownValue.value)
                      .doc()
                      .get()
                      .then((value) {
                    if (!value.exists) {
                      setState(() {
                        errorMessage = "";
                      });

                      FirebaseFirestore.instance
                          .collection("rooms")
                          .doc(dropdownValue.value)
                          .collection(dropdownValue.value)
                          .doc()
                          .set({
                        "roomName" : dropdownValue.value,
                        "myUid" : FirebaseAuth.instance.currentUser.uid,
                      });

                    } else {
                      setState(() {
                        errorMessage = "Please Join a room first";
                      });
                    }
                  });
                }},
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
              Text(errorMessage),
              NeumorphicButton(
                  margin: EdgeInsets.only(top: 12),
                  onPressed: () {
                    print(dropdownValue.value);
                    _fcm.unsubscribeFromTopic(dropdownValue.value);
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
