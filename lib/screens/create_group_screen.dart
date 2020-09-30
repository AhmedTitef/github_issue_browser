import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CreateGroupScreen extends StatefulWidget {
  static const String id = "create_group_Screen";

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
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
          child: Column(
            children: <Widget>[
              Neumorphic(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Group Name"),
                      subtitle: TextFormField(),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Invite Code"),
                      subtitle: Text("EE#QD¬A"),
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
