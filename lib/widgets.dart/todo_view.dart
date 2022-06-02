import 'package:distivity_todolist/objects/todo.dart';
import 'package:distivity_todolist/utils.dart';
import 'package:flutter/material.dart';



class TodoView extends StatefulWidget {

  final Todo todo;
  final Function(bool) onChecked;

  TodoView({Key key,@required this.todo,@required this.onChecked}) : super(key: key);

  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {

  bool snapToEnd = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: getText(widget.todo.name, MyColors.black161616),
      leading: getFlareCheckbox(widget.todo.checked, snapToEnd,
        onCallbackCompleted: (checked){
          widget.onChecked(checked);
        },
        onTap: (){
          snapToEnd=false;
        }),
    );
  }
}