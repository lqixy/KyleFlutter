import 'dart:math';

import '../models/todo_item.dart';

class TodoService {
  // List<TodoItem> list = [];
  static DateTime now = DateTime.now();
  static Random random = Random();
  // static int num = Random().nextInt(20) + 1;

  static List<TodoItem> list = List.generate(
      20,
      (index) => TodoItem(
          id: index,
          title: 'totle: $index',
          deadline: now.add(Duration(days: index))));

  List<TodoItem> getTodoList() {
    return list.where((element) => !element.deleted).toList();
  }
}
