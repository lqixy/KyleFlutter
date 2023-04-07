import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:kyle_todolist/home_drawer.dart';
import 'package:kyle_todolist/models/todo_item.dart';
import 'package:kyle_todolist/pages/custom_drawer.dart';

import 'package:kyle_todolist/pages/todo_item_build.dart';
import 'package:kyle_todolist/services/category_service.dart';
import 'package:kyle_todolist/services/todo_service.dart';
import '../models/todo_category.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TodoService todoService = GetIt.I<TodoService>();
  CategoryService categoryService = GetIt.I<CategoryService>();

  List<TodoItem> todoSource = [];
  List<TodoItem> selectedTodoItems = [];
  List<TodoCategory> categories = [];

  // final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Sort');
  // Map<DateType, List<TodoItem>> todoGroupedMap = {};

  int selectedCategoryId = 0;

  @override
  void initState() {
    super.initState();
    todoSource = todoService.getTodoList();
    selectedTodoItems = selectedCategoryId > 0
        ? todoSource
            .where((element) => element.categoryId == selectedCategoryId)
            .toList()
        : todoSource;
    categories = categoryService.getCategories();
    // todoGroupedMap = todoSource.groupListsBy((element) => element.dateType);
  }

  /// 选中分类按钮
  void seletedCategoryButton(int id) {
    setState(() {
      selectedCategoryId = id;
      selectedTodoItems = id > 0
          ? todoSource.where((element) => element.categoryId == id).toList()
          : todoSource;
    });
  }

  /// 分类按钮
  Widget getCategoryItemButton(TodoCategory e) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: TextButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    selectedCategoryId == e.id
                        ? Colors.lightBlue[600]
                        : Colors.grey[500]),
                backgroundColor: MaterialStateProperty.all(
                    selectedCategoryId == e.id
                        ? Colors.lightBlue[200]
                        : Colors.grey[200]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
            onPressed: () {
              seletedCategoryButton(e.id);
            },
            child: Text(e.title)));
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

  String _keyword = '';

  void searchTodoList(String keyword) {
    setState(() {
      selectedTodoItems = selectedTodoItems
          .where((element) => element.title.contains(keyword))
          .toList();
    });
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            // child: AnimSearchBar(
            //     width: 400,
            //     textController: textController,
            //     onSuffixTap: () {},
            //     onSubmitted: (s) {}),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        // RDrawer.open(
                        //   HomeDrawer(),
                        // );
                      },
                      icon: Icon(Icons.menu),
                    )),
                Expanded(
                  flex: 8,
                  child: AnimSearchBar(
                    width: 400,
                    textController: textController,
                    onSuffixTap: () {
                      // textController.clear();
                      setState(() {
                        _keyword = '';
                      });
                    },
                    closeSearchOnSuffixTap: true,
                    onSubmitted: (s) {
                      // print(s);
                      searchTodoList(s);
                    },
                    boxShadow: false,
                  ),
                ),
                // IconButton(
                //     onPressed: () {

                //     },
                //     icon: Icon(Icons.menu)),
                // IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                Expanded(
                  flex: 1,
                  child: MenuAnchor(
                    menuChildren: [
                      MenuItemButton(
                        child: Text('截止日期和时间'),
                        onPressed: () {},
                      ),
                      MenuItemButton(
                        child: Text('任务创建时间'),
                        onPressed: () {},
                      ),
                      MenuItemButton(
                        child: Text('字母A-Z'),
                        onPressed: () {},
                      ),
                      MenuItemButton(
                        child: Text('字母Z-A'),
                        onPressed: () {},
                      ),
                    ],
                    builder: (context, controller, child) {
                      return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: Icon(Icons.sort));
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: categories
                          .map((e) => getCategoryItemButton(e))
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.category_outlined)),
                )
              ],
            ),
          ),
          Expanded(
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
    );
  }
}
