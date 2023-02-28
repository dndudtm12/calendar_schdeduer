
import 'package:flutter/material.dart';

import '../component/calendar.dart';
import '../component/schedule_bottom_sheet.dart';
import '../component/schedule_card.dart';
import '../component/today_banner.dart';
import '../const/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: renderFloatingActionButton(),
        body: Column(
          children: [
            Calendar(
                selectedDay: selectedDay,
                focusedDay: focusedDay,
                onDaySelected: onDaySelected),
            const SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDate: selectedDay!,
              scheduleCount: 3,
            ),
            const SizedBox(
              height: 8.0,
            ),
            const _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return const ScheduleBottomSheet();
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => const SizedBox(
            height: 8.0,
          ),
          itemBuilder: (context, index) {
            return ScheduleCard(
              startTime: 12,
              endTime: 14,
              content: '프로그래밍 공부하기. $index',
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
