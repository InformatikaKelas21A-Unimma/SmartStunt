import 'package:flutter/material.dart';

class ListReminder extends StatefulWidget {
  const ListReminder({super.key});

  @override
  State<ListReminder> createState() => _ListReminderState();
}

class _ListReminderState extends State<ListReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              children: [
                Text("1"),
              ],
            ),
            Column(
              children: [
                Text("2"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
