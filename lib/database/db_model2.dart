import 'package:meta/meta.dart';

class ToDoListModel {
  final int key;
  final String title;
  final String dateTime;

  ToDoListModel({
    @required this.key,
    @required this.title,
    @required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["key"] = key;
    map["title"] = title;
    map["dateTime"] = dateTime;
    return map;
  }
}