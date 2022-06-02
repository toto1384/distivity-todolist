


import 'package:flutter/widgets.dart';

class Todo {

  int id;
  int parentId;
  String name;
  String description;

  //data
  String dueDate;
  String dueTime;
  int repeatEvery;
  //

  int progress;


  Todo({this.id, @required this.parentId, @required this.name, @required this.description,
    @required this.dueDate, @required this.repeatEvery, @required this.progress,@required this.dueTime});


  Map toMap(){


    return {
      "id" :id,
      "parentId" : parentId,
      "name" : name,
      "description" : description,
      "dueDate": dueDate,
      "dueTime": dueTime,
      "repeatEvery" : repeatEvery,
      "progress" : progress
    };
  }


  static Todo fromMap(Map map){
    return Todo(

      id: map["id"],
      parentId: map["parentId"],
      name: map["name"],
      description: map["description"],
      dueDate: map["dueDate"],
      progress: map["progress"],
      dueTime: map["dueTime"],
      repeatEvery: map["repeatEvery"],

    );
  }

}