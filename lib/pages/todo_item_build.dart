import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kyle_todolist/models/todo_item.dart';

todoListItemView({
  // required int itemCount,
  // required List<TodoItem> item,
  required TodoItem item,
  SlidableActionCallback? starOnPressed,
  SlidableActionCallback? calendarOnPressed,
  SlidableActionCallback? deleteOnPressed,
  ValueChanged<bool?>? checkBoxOnChanged,
}) {
  return Slidable(
      endActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          icon: item.isMark ? Icons.star : Icons.star_outline,
          backgroundColor: Color.fromARGB(255, 70, 189, 244),
          foregroundColor: item.isMark ? Colors.blue : Colors.white,
          // onPressed: starOnPressed,
          // onPressed: starOnPressed,
          onPressed: starOnPressed,
        ),
        SlidableAction(
          icon: Icons.calendar_month_outlined,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          // onPressed: calendarOnPressed,
          onPressed: calendarOnPressed,
        ),
        SlidableAction(
          icon: Icons.delete_outline,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: deleteOnPressed,
        ),
      ]),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 0,
        child: ListTile(
          leading: Checkbox(
            activeColor: Colors.grey,
            shape: CircleBorder(),
            // onChanged: checkBoxOnChanged,
            onChanged: checkBoxOnChanged,
            value: item.finished,
          ),
          title: Text(item.title),
          subtitle: Text('${item.time}'),
          trailing: Text('${item.isMark}'),
        ),
      ));
}
