import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1950),
      lastDay: DateTime(2050),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
        });
      },
      selectedDayPredicate: (day) {
        if(selectedDay == null){
          return false;
        }
        return day.year == selectedDay!.year
            && day.month == selectedDay!.month
            && day.day == selectedDay!.day;
      },
    );
  }
}
