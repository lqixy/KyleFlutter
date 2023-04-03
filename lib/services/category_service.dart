import '../models/todo_category.dart';

class CategoryService {
  /// 类别
  static List<TodoCategory> categories = [
    TodoCategory(id: 0, title: '所有'),
    TodoCategory(id: 1, title: '工作'),
    TodoCategory(id: 2, title: '个人'),
    TodoCategory(id: 3, title: '心愿单'),
    TodoCategory(id: 4, title: '生日'),
  ];

  List<TodoCategory> getCategories() {
    return categories;
  }
}
