import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class JoinGroupScreen extends StatefulWidget {
  static const String id = "join_group_Screen";

  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
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
                        decoration: InputDecoration(hintText: "Type Code Here"),
                      ),
                    ),
                  ],
                ),
              ),
              NeumorphicButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
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
