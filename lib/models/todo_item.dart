class TodoItem {
  int id;
  String title;
  bool finished, isMark;
  DateTime deadline;
  DateTime? time, remindTime;
  bool deleted = false;
  int categoryId;

  // static  DateType dateType(){

  // }

  DateType get dateType => deadline.isBefore(DateTime.now())
      ? DateType.before
      : deadline.isAfter(DateTime.now())
          ? DateType.future
          : DateType.today;

  // set todoItemDateType(value) {
  //   DateTime now = DateTime.now();
  //   if (deadline.isBefore(now)) {
  //     dateType = DateType.before;
  //   } else if (deadline.isAfter(now)) {
  //     dateType = DateType.future;
  //   } else {
  //     dateType = DateType.today;
  //   }
  //   // this.dateType
  // }

  // DateTime remindTime;
  Repeat repeat;

  TodoItem(
      {required this.id,
      required this.title,
      required this.deadline,
      this.categoryId = 0,
      this.time,
      this.remindTime,
      this.finished = false,
      this.isMark = false,
      this.repeat = Repeat.none});
}

enum Repeat { none, day, week, month, year }

enum DateType {
  before(0, '以前'),
  today(1, '今天'),
  future(2, '未来');

  const DateType(this.number, this.value);

  final int number;
  final String value;
}
