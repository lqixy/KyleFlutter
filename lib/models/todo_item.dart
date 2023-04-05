class TodoItem {
  int id;
  String title;
  bool finished, isMark;
  DateTime deadline;
  DateTime? time, remindTime;
  bool deleted = false;

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
      this.time,
      this.remindTime,
      this.finished = false,
      this.isMark = false,
      this.repeat = Repeat.none});
}

enum Repeat { none, day, week, month, year }

enum DateType { before, today, future }
