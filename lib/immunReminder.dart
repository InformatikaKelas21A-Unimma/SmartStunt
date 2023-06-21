import 'package:example/service/reminder_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_launcher_icons/ios.dart';
import 'package:table_calendar/table_calendar.dart';
import 'form_immun_reminder.dart';
// import 'main.dart';
// import 'notification_manager/notification_manager.dart';

import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'theme.dart';
// import 'utils/bottom_navbar.dart';
import 'utils/card.dart';
// import 'utils/custom_button.dart';

class ImmunReminderPage extends StatefulWidget {
  const ImmunReminderPage({super.key});

  @override
  State<ImmunReminderPage> createState() => _ImmunReminderPageState();
}

class _ImmunReminderPageState extends State<ImmunReminderPage> {
  DateTime? dateTime;
  String? immun;
  String? doctor;
  String? hospital;
  bool? status;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  ReminderData reminderData = ReminderData.getInstance();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Immun Reminder"),
          backgroundColor: greenColor,
          toolbarHeight: 71.0,
        ),
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 368.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Color(0x0FFCED3DE),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 60,
                      ),
                      height: MediaQuery.of(context).size.height - 500,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: reminderData.reminders.length,
                        itemBuilder: (context, index) {
                          final reminder = reminderData.reminders[index];
                          final dateTime = reminder['dateTime'];
                          final immun = reminder['immun'];
                          final doctor = reminder['doctor'];
                          final hospital = reminder['hospital'];
                          final status = reminder['status'];

                          if (reminderData.reminders.isEmpty) {
                            return Text(
                              "Kamu belum mempunyai jadwal imunisasi",
                            );
                          } else {
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.horizontal,
                              secondaryBackground: Container(
                                color: Colors.red,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              background: Container(
                                color: Colors.green,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onDismissed: (direction) {
                                setState(
                                  () {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      reminderData.removeReminderAt(index);
                                    } else if (direction ==
                                        DismissDirection.startToEnd) {
                                      reminder['status'] = true;
                                      reminderData.updateStatusAtIndex(
                                        index,
                                        true,
                                      );
                                    }
                                  },
                                );
                              },
                              child: status
                                  ? SizedBox()
                                  : Container(
                                      padding: EdgeInsets.only(
                                        right: 15,
                                        left: 15,
                                      ),
                                      child: ListCard(
                                        dateTime: dateTime,
                                        immun: immun,
                                        doctor: doctor,
                                        hospital: hospital,
                                      ),
                                    ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 130.0,
              right: 130.0,
              bottom: 20.0,
              child: TextButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormImmunReminderPage(),
                    ),
                  );
                  if (result != null) {
                    setState(
                      () {
                        dateTime = result['dateTime'];
                        immun = result['immun'];
                        doctor = result['doctor'];
                        hospital = result['hospital'];
                        status = result['status'];
                      },
                    );
                    reminderData.addReminder(result);
                  }
                },
                icon: Icon(Icons.add),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(134, 44),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(3.0),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor: MaterialStateProperty.all<Color>(greenColor),
                ),
                label: Text(
                  'New Reminder',
                  style: TextStyle(
                    fontFamily: "PoppinsMedium",
                    fontSize: 12.0,
                    color: greenOld2Color,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _SlidableOverlay extends StatelessWidget {
  const _SlidableOverlay({
    required this.title,
    required this.iconData,
  });

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: Colors.red,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "PoppinsMedium",
            fontSize: 15,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
