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
        ],
      ),
    );
  }

  Container _buildButton() {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text('create Table'),
            onPressed: () async {
              _updateModel(_toDoListModel);
            },
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
                    await _provider.insertList(_toDoListModel, _tableName);
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
                    var list = await _provider.getList(_tableName);
                    for (int i = 0; i < list.length; i++){
                      print(list[i]);
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
                    await _provider.deleteList(_key, _tableName);
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
            ],
          )
        ],
      ),
    );
  }
}
