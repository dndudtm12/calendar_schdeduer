import 'package:flutter/material.dart';

import '../component/calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Calendar(),
          ],
        ),
      ),
    );
  }
}
