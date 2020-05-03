import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/database/db_practice.dart';
import 'package:flutterapp/database/db_model.dart';
import 'dart:math';
import 'dart:convert';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  MyHomepageState createState() => MyHomepageState();
}

class MyHomepageState extends State<MyHomepage> {
  static String _username;
  static int _score;
  static int _id = 0;
  var rnd = new Random();
  DbProvider10 helper = new DbProvider10();
  User u = new User(_id, _username, _score); //初期化
  var list;
  var exploreList;
  String _exploreName;

  void _updateName(String name) {
    setState(() {
      _username = name;
    });
  }

  void _updateScore(int score) {
    setState(() {
      _score = score;
    });
  }

  void _updateID(){
    setState(() {
      _id = rnd.nextInt(10)
            + rnd.nextInt(10) * 10
            + rnd.nextInt(10) * 100
            + rnd.nextInt(10) * 1000
            + rnd.nextInt(10) * 10000;
    });
  }

  void _updateUser(User user){
    setState(() {
      u = User(_id, _username, _score);
    });
  }

  void _updateExploreName(String name){
    setState(() {
      _exploreName = name;
    });
  }


  @override
  Widget build(BuildContext context) {
    //databaseが作られてなかった
    //helper.database;
    helper.init();
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Test'),
      ),
      body: Column(
        children: <Widget>[_buildText(), _buildButton()],
      ),
    );
  }

  Container _buildText() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateName(val);
                _updateID();
              },
              decoration: InputDecoration(labelText: 'username...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_username'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateScore(int.parse(val));
                _updateID();
              },
              decoration: InputDecoration(labelText: 'score...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_score'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateExploreName(val);
              },
              decoration: InputDecoration(labelText: 'explore...'),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildButton() {

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('insert'),
              onPressed: () async {
                _updateUser(u);
                await helper.insertScore(u);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('get'),
              onPressed: () async {
                list = await helper.getScore();
                print(list);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('explore'),
              onPressed: () async {
                exploreList = await helper.getName(_exploreName);
                print(exploreList);
                print('id:${exploreList[0]['id']}');
                print('username:${exploreList[0]['username']}');
                print('score:${exploreList[0]['score']}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
