import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService{

  final FirebaseAuth _auth= FirebaseAuth.instance;
  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid: user.uid):null;
  }

  //Stream to see if user logs in or logs out
  Stream<User> get user{
    return _auth.onAuthStateChanged.
    //map((FirebaseUser user) => _userFromFirebaseUser(user));
    map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      //create a new document with uid
      await DatabaseService(uid: user.uid).updateUserData("0", "new member", 100);

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  //sign in username and password
  Future signIn(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
      
    }
  }

  //register
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document with uid
      await DatabaseService(uid: user.uid).updateUserData("0", "new member", 100);

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }

  }

  //signout
  Future signOut() async{
    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}