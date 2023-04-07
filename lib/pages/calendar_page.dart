import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:kyle_todolist/constants/date_extensions.dart';
import 'package:kyle_todolist/models/todo_item.dart';
import 'package:kyle_todolist/pages/todo_item_build.dart';
import 'package:kyle_todolist/services/todo_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  TodoService service = GetIt.I<TodoService>();
  List<TodoItem> todoSource = [];
  List<TodoItem> selectedTodoItems = [];

  final DateTime _selectedDay = DateTime.now();

  List<DateTime?> dates = [];

  @override
  void initState() {
    todoSource = service.getTodoList();
    selectedTodoItems = todoSource
        .where((element) => element.deadline.isSameDay(_selectedDay))
        .toList();
    dates.add(_selectedDay);
    super.initState();
  }

  void updateSelectedTodoList(DateTime? time) {
    setState(() {
      dates = [time];
      selectedTodoItems = todoSource
          .where((element) => element.deadline.isSameDay(time!))
          .toList();
    });
  }

  void deleteTodoItem(int index) {
    var cur = selectedTodoItems[index];
    setState(() {
      todoSource.remove(cur);
      selectedTodoItems.removeAt(index);
    });
  }

  void staredTodoItem(int index) {
    var cur = selectedTodoItems[index];
    setState(() {
      cur.isMark = !cur.isMark;
    });
  }

  void checkedTodoItem(int index) {
    var cur = selectedTodoItems[index];
    setState(() {
      cur.finished = !cur.finished;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                flex: 1,
                child: CalendarDatePicker2(
                  onValueChanged: (value) {
                    updateSelectedTodoList(value.first);
                  },
                  value: dates,
                  config: CalendarDatePicker2Config(
                      calendarType: CalendarDatePicker2Type.single),
                )),
            Expanded(
                flex: 1,
                child: SlidableAutoCloseBehavior(
                  child: ListView.builder(
                    itemCount: selectedTodoItems.length,
                    itemBuilder: (context, index) {
                      return todoListItemView(
                        item: selectedTodoItems[index],
                        starOnPressed: (context) {
                          staredTodoItem(index);
                        },
                        deleteOnPressed: (context) {
                          deleteTodoItem(index);
                        },
                        checkBoxOnChanged: (value) {
                          checkedTodoItem(index);
                        },
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // Slidable getTodoItemSlidable(int index) {
  //   return Slidable(
  //       endActionPane: ActionPane(motion: DrawerMotion(), children: [
  //         SlidableAction(
  //           icon: selectedTodoItems[index].isMark
  //               ? Icons.star
  //               : Icons.star_outline,
  //           backgroundColor: Color.fromARGB(255, 70, 189, 244),
  //           foregroundColor:
  //               selectedTodoItems[index].isMark ? Colors.blue : Colors.white,
  //           onPressed: (context) {
  //             staredTodoItem(index);
  //           },
  //         ),
  //         SlidableAction(
  //           icon: Icons.calendar_month_outlined,
  //           backgroundColor: Colors.blue,
  //           foregroundColor: Colors.white,
  //           onPressed: (context) {},
  //         ),
  //         SlidableAction(
  //           icon: Icons.delete_outline,
  //           backgroundColor: Colors.red,
  //           foregroundColor: Colors.white,
  //           onPressed: (context) {
  //             removeTodoItem(index);
  //           },
  //         ),
  //       ]),
  //       child: listTile(selectedTodoItems[index]));
  // }

  // Widget listTile(TodoItem item) {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(15))),
  //     elevation: 0,
  //     child: ListTile(
  //       leading: Checkbox(
  //         activeColor: Colors.grey,
  //         shape: CircleBorder(),
  //         onChanged: (value) {
  //           setState(() {
  //             item.finished = !item.finished;
  //           });
  //         },
  //         value: item.finished,
  //       ),
  //       title: Text(item.title),
  //       subtitle: Text('${item.time}'),
  //       trailing: Text('${item.isMark}'),
  //     ),
  //   );
  // }
}
