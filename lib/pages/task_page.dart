import 'package:flutter/material.dart';

import '../models/todo_category.dart';

class TaskPage extends StatelessWidget {
  Widget buildTile(TodoCategory tile) {
    if (tile.categories.isEmpty) {
      return ListTile(
        title: Text(tile.title),
      );
    } else {
      return ExpansionTile(
        title: Text(tile.title),
        children: tile.categories.map((e) => buildTile(e)).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TodoCategory> categories = [
      TodoCategory(id: -1, title: '类别', categories: [
        TodoCategory(id: 0, title: '所有'),
        TodoCategory(id: 1, title: '工作'),
        TodoCategory(id: 2, title: '个人'),
        TodoCategory(id: 3, title: '心愿单'),
        TodoCategory(id: 4, title: '生日'),
      ]),
    ];

    return Container(
      child: ListView(
        children: categories.map(buildTile).toList(),
      ),
    );
  }
}
