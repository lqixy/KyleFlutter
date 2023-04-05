import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kyle_todolist/models/todo_item.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kyle_todolist/services/todo_service.dart';

import '../models/todo_category.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TodoService todoService = GetIt.I<TodoService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(onPressed: () {}, child: Text('所有')),
                        TextButton(onPressed: () {}, child: Text('个人')),
                        TextButton(onPressed: () {}, child: Text('心愿')),
                        TextButton(onPressed: () {}, child: Text('心愿')),
                        TextButton(onPressed: () {}, child: Text('心愿')),
                        TextButton(onPressed: () {}, child: Text('心愿')),
                      ],
                    ),
                  ),
                ),
                Container(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.category_outlined)))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('$index'),
                    );
                  }))
        ],
      ),

      // child: Flex(
      //   // mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   direction: Axis.vertical,
      //   children: [
      //     Expanded(
      //         flex: 1,
      //         child: IconButton(onPressed: () {}, icon: Icon(Icons.menu))),
      //     Expanded(
      //         flex: 1,
      //         child:
      //          Flex(
      //           direction: Axis.horizontal,
      //           children: [
      //             TextButton(onPressed: () {}, child: Text('所有')),
      //             TextButton(onPressed: () {}, child: Text('个人')),
      //             TextButton(onPressed: () {}, child: Text('心愿')),
      //             TextButton(onPressed: () {}, child: Text('心愿')),
      //             TextButton(onPressed: () {}, child: Text('心愿')),
      //             TextButton(onPressed: () {}, child: Text('心愿')),
      //           ],
      //         )),
      //     Expanded(
      //         flex: 8,
      //         child: ListView.builder(
      //           itemCount: 10,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text('$index'),
      //             );
      //           },
      //         ))
      //   ],
      // ),
    );
  }
}


// class TaskPage extends StatelessWidget {
//   Widget buildTile(TodoCategory tile) {
//     if (tile.categories.isEmpty) {
//       return ListTile(
//         title: Text(tile.title),
//       );
//     } else {
//       return ExpansionTile(
//         title: Text(tile.title),
//         children: tile.categories.map((e) => buildTile(e)).toList(),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<TodoCategory> categories = [
//       TodoCategory(id: -1, title: '类别', categories: [
//         TodoCategory(id: 0, title: '所有'),
//         TodoCategory(id: 1, title: '工作'),
//         TodoCategory(id: 2, title: '个人'),
//         TodoCategory(id: 3, title: '心愿单'),
//         TodoCategory(id: 4, title: '生日'),
//       ]),
//     ];

//     return Container(
//       child: ListView(
//         children: categories.map(buildTile).toList(),
//       ),
//     );
//   }
// }
