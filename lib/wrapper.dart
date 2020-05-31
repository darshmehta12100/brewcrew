import 'package:brewcrew/screens/home/home.dart';
import 'package:brewcrew/screensauthenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return user!=null?Home():Authenticate();
  }
}

