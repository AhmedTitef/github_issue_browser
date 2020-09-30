import 'package:flutter_neumorphic/flutter_neumorphic.dart';
class SettingsScreen extends StatefulWidget {
  static const String id = "settings_screen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      home: Scaffold(),
    );
  }
}
