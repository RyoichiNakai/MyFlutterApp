import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/database/db_provider2.dart';
import 'package:flutterapp/database/db_model2.dart';
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
  static int _key;
  static String _title;
  static String _datetime;
  static String _tableName;
  static String _exploreName;
  DbProvider _provider = new DbProvider();
  ToDoListModel _toDoListModel = new ToDoListModel(
      key: _key,
      title: _title,
      dateTime: _datetime
  );//初期化


  void _updateKey(int key) {
    setState(() {
      _key = key;
    });
  }

  void _updateTitle(String name) {
    setState(() {
      _title = name;
    });
  }

  void _updateDatetime(String datetime) {
    setState(() {
      _datetime = datetime;
    });
  }

  void _updateTableName(String tableName) {
    setState(() {
      _tableName = tableName;
    });
  }

  void _updateModel(ToDoListModel model){
    setState(() {
      _toDoListModel = ToDoListModel(
        key: _key,
        title: _title,
        dateTime: _datetime
      );
    });
  }

  void _updateExploreName(String name){
    setState(() {
      _exploreName = name;
    });
  }


  @override
  void initState() {
    super.initState();
    _provider.init(); //dbの初期化
  }

  @override
  Widget build(BuildContext context) {
    //databaseが作られてなかった
    //helper.database;
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Test'),
      ),
      body: ListView(
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
                _updateTableName(val);
              },
              decoration: InputDecoration(labelText: 'tablename'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_tableName'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateKey(int.parse(val));
              },
              decoration: InputDecoration(labelText: 'key...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_key'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateTitle(val);
              },
              decoration: InputDecoration(labelText: 'title...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_title'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateDatetime(val);
              },
              decoration: InputDecoration(labelText: 'datetime...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('$_datetime'),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (val) {
                _updateKey(int.parse(val));
              },
              decoration: InputDecoration(labelText: 'detete...'),
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
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('create Table'),
                  onPressed: () async {
                    try{
                      //これでいいのか？？
                      _provider.createDBTable(_provider.db, 1, _tableName);
                      print("Create table!");
                    }
                    catch(e){
                      print(e);
                      print("Already Exist!");
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('print Tables'),
                  onPressed: () async {
                    try{
                      var list = await _provider.getTables();
                      print(list);
                    }catch(e){
                      print(e);
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('insert'),
                  onPressed: () async {
                    _updateModel(_toDoListModel);
                    try{
                      await _provider.insertList(_toDoListModel, _tableName);
                      print("success insert!");
                    }
                    catch(e){
                      print(e);
                      print("cannnot insert ${_toDoListModel.toMap}");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
              //todo エラーの直しか
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('get'),
                  onPressed: () async {
                    try{
                      var list = await _provider.getList(_tableName);
                      for (int i = 0; i < list.length; i++){
                        print(list[i]);
                      }
                      print("success getList!");
                    }
                    catch(e){
                      print(e);
                      print("cannnot getList");
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('explore'),
                  onPressed: () async {
                    try{
                      var exploreList = await _provider.exploreTitle(_exploreName, _tableName);
                      print(exploreList);
                      print('id:${exploreList[0]['id']}');
                      print('username:${exploreList[0]['username']}');
                      print('score:${exploreList[0]['score']}');
                    }
                    catch(e){
                      print(e);
                      print("cannot explore");
                    }

                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text('delete'),
                  onPressed: () async {
                    try{
                      await _provider.deleteList(_key, _tableName);
                    }
                    catch(e){
                     print(e);
                     print("canonot delete");
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
