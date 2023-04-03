class TodoCategory {
  int id;
  String title;

  List<TodoCategory> categories;

  TodoCategory(
      {required this.id, required this.title, this.categories = const []});
}
