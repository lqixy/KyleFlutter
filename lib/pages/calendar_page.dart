import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.utc(2099, 12, 31),
          ),
        ),
        Container(
          child: Column(children: [Text('test'), Text('sdf')]),
        )
      ],
    );
  }
}
