import 'package:copsalert/screens/create_group_screen.dart';
import 'package:copsalert/screens/join_group_screen.dart';
import 'package:copsalert/screens/landing_page.dart';

import 'package:copsalert/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import '';
import 'package:flutter/material.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: LandingPage.id ,
      routes: {

        CreateGroupScreen.id :(context) => CreateGroupScreen(),
        JoinGroupScreen.id :(context) => JoinGroupScreen(),
        MainScreen.id : (context) => MainScreen(),
        LandingPage.id : (context) => LandingPage(),

       

      },
    );
  }
}


