import 'package:brewcrew/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'models/brew.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (BuildContext context , int index){
          return BrewTile(brew : brews[index]);
        }
    );
  }
}
