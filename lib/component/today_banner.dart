import 'package:flutter/material.dart';

import '../const/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int scheduleCount;

  const TodayBanner({
    required this.selectedDate,
    required this.scheduleCount,
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
            Text(
              '$scheduleCount개',
              style: testStyle,
            ),
          ],
        ),
      ),
    );
  }
}
