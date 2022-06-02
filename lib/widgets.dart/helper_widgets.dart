


class TodoViewMode{

  int viewMode;

  TodoViewMode(this.viewMode);

  static final int _TODO_VIEW_MODE_SIMPLE=0000;
  static final int _TODO_VIEW_MODE_COMPACT=00001;
  static final int _TODO_VIEW_MODE_ADVANCED=00002;


  static final TodoViewMode TODO_VIEW_MODE_SIMPLE=TodoViewMode(_TODO_VIEW_MODE_SIMPLE);
  static final TodoViewMode TODO_VIEW_MODE_COMPACT=TodoViewMode(_TODO_VIEW_MODE_COMPACT);
  static final TodoViewMode TODO_VIEW_MODE_ADVANCED=TodoViewMode(_TODO_VIEW_MODE_ADVANCED);
}


class ListViewMode{

  int viewMode;

  ListViewMode(this.viewMode);

  static final int _LIST_VIEW_MODE_LIST=0000;
  static final int _LIST_VIEW_MODE_CALENDAR=00001;
  static final int _LIST_VIEW_MODE_BOARD=00002;


  static final ListViewMode LIST_VIEW_MODE_LIST=ListViewMode(_LIST_VIEW_MODE_LIST);
  static final ListViewMode LIST_VIEW_MODE_CALENDAR=ListViewMode(_LIST_VIEW_MODE_CALENDAR);
  static final ListViewMode LIST_VIEW_MODE_BOARD=ListViewMode(_LIST_VIEW_MODE_BOARD);


}