import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../const/colors.dart';
import '../datebase/drift_database.dart';
import '../model/schedule_with_color.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;

  const TodayBanner({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const testStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: testStyle,
            ),
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDataBase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                int count = 0;

                if(snapshot.hasData){
                  count = snapshot.data!.length;
                }
                return Text(
                  '$count개',
                  style: testStyle,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
