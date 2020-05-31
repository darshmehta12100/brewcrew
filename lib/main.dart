import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Firebase Brew Crew',
        debugShowCheckedModeBanner: false,

        home: Wrapper(),

      ),
    );
  }
}

