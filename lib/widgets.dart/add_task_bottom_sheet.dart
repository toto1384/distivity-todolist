import 'package:distivity_todolist/objects/todo.dart';
import 'package:distivity_todolist/utils.dart';
import 'package:flutter/material.dart';


class AddTaskBottomSheet extends StatefulWidget {

  final Todo todo;
  final Function(Todo) onTodoSubmited;
  final bool isDarkMode;

  AddTaskBottomSheet({Key key,@required this.onTodoSubmited, this.todo,@required this.isDarkMode}) : super(key: key);

  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {


  TextEditingController nameEditingController;
  TextEditingController descriptionEditingController;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              getTextField(
                "Fight bears, go to the moon, do homework",
                 widget.isDarkMode,
                 nameEditingController, TextInputType.text, 200),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // icons
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getButton2("Add task", (){
                Todo newTodo;
                if(widget.todo==null){
                  newTodo= Todo(
                    checked: false,
                    description: descriptionEditingController.text,
                    name: nameEditingController.text,
                    parentId: 0,
                  );
                }else{
                  newTodo = widget.todo;
                  newTodo.name = nameEditingController.text;
                  newTodo.description = descriptionEditingController.text;
                }
                widget.onTodoSubmited(newTodo);
                
              }, widget.isDarkMode),
            ),
          ],
        ),
      ],
    );
  }
}