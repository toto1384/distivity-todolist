import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:distivity_todolist/data/database.dart';
import 'package:distivity_todolist/icon_pack_icons.dart';
import 'package:distivity_todolist/main.dart';
import 'package:distivity_todolist/objects/todo.dart';
import 'package:distivity_todolist/utils.dart';
import 'package:distivity_todolist/widgets.dart/add_task_bottom_sheet.dart';
import 'package:distivity_todolist/widgets.dart/editTaskWidget.dart';
import 'package:distivity_todolist/widgets.dart/helper_widgets.dart';
import 'package:distivity_todolist/widgets.dart/todo_view.dart';
import 'package:flutter/material.dart';


class ListViewTodos extends StatefulWidget {

  final ListViewMode listViewMode;
  final TodoViewMode todoViewMode;
  final List<Todo> todos;

  ListViewTodos({Key key,@required this.listViewMode, @required this.todos,@required this.todoViewMode}) : super(key: key);

  _ListViewTodosState createState() => _ListViewTodosState();
}

class _ListViewTodosState extends State<ListViewTodos> {

  DatabaseHelper databaseHelper ;

  PageController boardPosition;

  @override
  void initState() {
    if(databaseHelper==null){
      databaseHelper = DatabaseHelper.instance;
    }
    if(boardPosition ==null && ListViewMode.LIST_VIEW_MODE_BOARD == widget.listViewMode){
      boardPosition = PageController(viewportFraction: 0.8,initialPage: 0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(ListViewMode.LIST_VIEW_MODE_LIST==widget.listViewMode){
      return getListView();
    }else if(widget.listViewMode==ListViewMode.LIST_VIEW_MODE_BOARD){
      return getBoardView();
    }else if(widget.listViewMode==ListViewMode.LIST_VIEW_MODE_CALENDAR){
      return Center();

      //implement later
    }else{
      return Center(child: Text("error"),);
    }
  }



  getCalendarView(){
    List listViewContent = getCalendarViewData();
      }
    
    
    
      ListView getListView(){
        return ListView.builder(
          itemBuilder: (ctx,index){
            return TodoView(
              onChecked: (checked){
                setState(() {
                  widget.todos[index].progress=10;
                });
              },
              todo: widget.todos[index],
              onMorePressed:(){
                showMoreFromTaskBottomSheet(widget.todos[index], index);
              },
            );
          },
        );
      }
    
    
      Widget getBoardView(){
    
        return BoardView(
          lists: List.generate(4, (index){
                  return getBoardList(index);
                 }),
        );
    
      }
    
      BoardList getBoardList(int index){
    
        List<Todo> items = List();
    
    
        switch(index){
          case 0: widget.todos.forEach((item){
            if(item.progress==0){
              items.add(item);
            }
          });break;
          case 1: widget.todos.forEach((item){
            if(item.progress<=3){
              items.add(item);
            }
          });break;
          case 2: widget.todos.forEach((item){
            if(item.progress<=6){
              items.add(item);
            }
          });break;
          case 3: widget.todos.forEach((item){
            if(item.progress<=10){
              items.add(item);
            }
          }); break;
        }
    
    
        return BoardList(
          index: index,
          items: List.generate(items.length, (index){
            return BoardItem(
              onDropItem: (listIndex,itemIndex,state){
                Todo droppedTodo = items[index];
    
                widget.todos.remove(droppedTodo);
                items.remove(droppedTodo);
    
                switch(listIndex){
                  case 0:droppedTodo.progress=0;break;
                  case 1:droppedTodo.progress=3;break;
                  case 2:droppedTodo.progress=6;break;
                  case 3:droppedTodo.progress=10;break;
                }
    
                widget.todos.add(droppedTodo);
                databaseHelper.update(droppedTodo);
              },
              item: Text(items[index].name),
              onTapItem: launchPage(context, EditTaskPage()),
            );
          }),
        );
      }
    
      showMoreFromTaskBottomSheet(Todo todo, int todoIndex){
        showDistivityModalBottomSheet(context, ListView.builder(
          itemCount: 6,
          itemBuilder: (ctx,index){
    
            Icon icon;
            String text;
            Function onPressed;
    
            switch(index){
              case 0:
                icon = Icon(IconPack.zoom_in);
                text = "Zoom in";
                onPressed =(){
                  //todo implement later
                };
                break;
    
    
              case 1:
                icon = Icon(IconPack.edit);
                text = "Edit task";
                onPressed =(){
                  showDistivityModalBottomSheet(context, AddTaskBottomSheet(
                    isDarkMode: MyApp.isDarkMode,
                    onTodoSubmited: (submitedTodo){
                      setState(() {
                        widget.todos[todoIndex] = submitedTodo;
                       databaseHelper.update(submitedTodo); 
                      });
    
                    },
                    todo: todo,
                  ), MyApp.isDarkMode);
                };
                break;
    
              case 2:
                icon = Icon(IconPack.duplicate);
                text = "Duplicate task";
                onPressed =(){
    
                  Todo copyTodo = Todo(
                    description: todo.description,
                    parentId: todo.parentId,
                    name: "Copy of ${todo.name}",
                    dueDate: todo.dueDate,
                    progress: todo.progress,
                    repeatEvery: todo.repeatEvery);
    
                  setState(() {
                    widget.todos.add(copyTodo);
                    databaseHelper.insert(copyTodo);
                  });
                };
                break;
    
                case 0:
                  icon = Icon(IconPack.duplicate);
                  text = "Copy to";
                  onPressed =(){
                    //todo implement later
                  };
                  break;
    
                case 0:
                  icon = Icon(IconPack.carret_foward);
                  text = "Move task";
                  onPressed =(){
                    //todo implement later
                  };
                  break;
    
                case 0:
                  icon = Icon(IconPack.trash);
                  text = "Delete Task";
                  onPressed =(){
                    setState(() {
                      widget.todos.removeAt(todoIndex);
                      databaseHelper.delete(todo.id);
                    });
                  };
                  break;
    
    
            }
    
            return ListTile(
              leading: icon,
              title: Text(text),
              onTap: onPressed,
            );
    
          },
        ), MyApp.isDarkMode);
    
      }
    
      List getCalendarViewData(CalendarViewMode calendarViewMode) {
        List data = List();

        for(int i = 0 ; i<24;i++){
          data.add(i);
        }
      }
}

class CalendarViewMode{
  int mode ;

  CalendarViewMode(this.mode);


  static final CalendarViewMode calendarViewModeToday = CalendarViewMode(0);
  static final CalendarViewMode calendarViewModeTomorrow = CalendarViewMode(1);
  static final CalendarViewMode calendarViewModeThisWeek = CalendarViewMode(2);
}