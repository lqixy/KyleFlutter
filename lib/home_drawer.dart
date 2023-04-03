import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kyle_todolist/models/todo_category.dart';
import 'package:kyle_todolist/services/category_service.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  /// 右边栏功能各类
  static List<HomeDrawerTitleItem> tiles = [
    HomeDrawerTitleItem(
        iconData: Icons.checkroom_outlined,
        iconColor: Colors.pink,
        title: '主题'),
    HomeDrawerTitleItem(
        iconData: Icons.category_outlined,
        iconColor: Colors.purple,
        title: '小部件'),
    HomeDrawerTitleItem(
        iconData: Icons.share_outlined,
        iconColor: Colors.orange,
        title: '分享应用'),
    HomeDrawerTitleItem(
        iconData: Icons.error_outline, iconColor: Colors.green, title: '反馈'),
    HomeDrawerTitleItem(
        iconData: Icons.settings_outlined,
        iconColor: Colors.lightBlue,
        title: '设置'),
  ];

  CategoryService get service => GetIt.I<CategoryService>();
  List<TodoCategory> categories = [];

  @override
  void initState() {
    categories = service.getCategories();
    super.initState();
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)));
  }

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

  /// 类别详情隐藏
  bool _categoryOffstage = true;
  IconData _categoryOffstageIcon = Icons.chevron_right;
  Widget getCategoryOffstageWidget() {
    return Offstage(
      offstage: _categoryOffstage,
      child: Column(
        children: categories
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(e.title),
                    const SizedBox(
                      width: 150,
                    ),
                    Text('')
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'To-Do List',
              style: TextStyle(fontSize: 40, color: Colors.lightBlue),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: getBoxDecoration(),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  DrawerItemRow(
                      iconData: Icons.star_outline,
                      iconColor: Colors.lightBlue,
                      title: '标星任务'),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _categoryOffstage = !_categoryOffstage;
                        _categoryOffstageIcon = _categoryOffstage
                            ? Icons.chevron_right
                            : Icons.expand_more;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: DrawerItemRow(
                                iconData: Icons.category_outlined,
                                iconColor: Colors.lightBlue,
                                title: '类别')),
                        Icon(_categoryOffstageIcon)
                        // IconButton(
                        //     onPressed: () {
                        //       setState(() {
                        //         _categoryOffstage = !_categoryOffstage;
                        //       });
                        //     },
                        //     icon: Icon(Icons.chevron_right)),
                      ],
                    ),
                  ),
                  getCategoryOffstageWidget()
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: getBoxDecoration(),
              padding: const EdgeInsets.all(10),
              child: Column(
                  children: tiles
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DrawerItemRow(
                                iconData: e.iconData,
                                iconColor: e.iconColor,
                                title: e.title),
                          ))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItemRow extends StatelessWidget {
  IconData iconData;
  Color? iconColor;
  String title;

  DrawerItemRow(
      {super.key,
      required this.iconData,
      required this.iconColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title),
      ],
    );
  }
}

class HomeDrawerTitleItem {
  String title;
  IconData iconData;
  Color iconColor;

  HomeDrawerTitleItem(
      {required this.iconData, required this.iconColor, required this.title});
}
