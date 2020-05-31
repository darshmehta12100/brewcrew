import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email="";
  String password="";
  String error="";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading == true ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign In To Brew Crew'),
        //centerTitle: true,
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Sign Up'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.pink,style: BorderStyle.solid,width: 2.0)
                  ),

                ),
                validator: (val) => val.isEmpty ? "Email Id not found,Sign Up" : null,
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                  },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.pink,style: BorderStyle.solid,width: 2.0)
                  ),

                ),
                validator: (val) => val.length<6 ? "Password does not match" : null,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                  },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pinkAccent,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                  dynamic result = await _auth.signIn(email,password);
                  if(result == null){
                    setState(() {
                      error = "Please enter valid credentials";
                      loading=false;
                    });
                  }

                }},
              ),
              SizedBox(height: 10.0,),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),)
            ],
          ),

        ),
      ),
    );
  }
}
