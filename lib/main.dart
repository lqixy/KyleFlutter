import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kyle_todolist/constants/navigator_provider.dart';
import 'package:kyle_todolist/home_drawer.dart';
import 'package:kyle_todolist/pages/calendar_page.dart';
import 'package:kyle_todolist/pages/mine_page.dart';
import 'package:kyle_todolist/pages/task_page.dart';
import 'package:kyle_todolist/services/category_service.dart';
import 'package:kyle_todolist/services/todo_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => CategoryService());
  GetIt.I.registerLazySingleton(() => TodoService());
}

void main() {
  setupLocator();
  // Intl.defaultLocale = 'en';

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    locale: Locale('zh', 'CN'),
    home: HomePage(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final screes = [CollectCtn(), CalendarPage(), MinePage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: NavigatorProvider.navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        // Locale('en', ''),
        Locale('zh', ''),
      ],
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final screes = [TaskPage(), CalendarPage(), MinePage()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),

      body: screes[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            activeIcon: Icon(Icons.feed),
            label: '任务',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_month),
              label: '日历'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '我的')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
      // drawer: HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
