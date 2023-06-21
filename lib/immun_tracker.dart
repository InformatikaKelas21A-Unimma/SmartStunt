import 'package:example/service/reminder_data.dart';
import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ImmunTrackerPage extends StatefulWidget {
  // List<Map<String, dynamic>>? reminders = [];
  // ImmunTrackerPage(this.reminders);
  const ImmunTrackerPage({super.key});

  @override
  State<ImmunTrackerPage> createState() => _ImmunTrackerPageState();
}

class _ImmunTrackerPageState extends State<ImmunTrackerPage> {
  ReminderData reminderData = ReminderData.getInstance();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> reminders = reminderData.reminders;
    List<DataColumn> columns = [
      DataColumn(
        label: Text('Date Time'),
      ),
      DataColumn(
        label: Text('Immun'),
      ),
      DataColumn(
        label: Text('Doctor'),
      ),
      DataColumn(
        label: Text('Hospital'),
      ),
      DataColumn(
        label: Text('Status'),
      ),
    ];

    List<DataRow> rows = reminders.map((reminder) {
      final dateTime = reminder['dateTime'];
      final immun = reminder['immun'];
      final doctor = reminder['doctor'];
      final hospital = reminder['hospital'];
      final status = reminder['status'];

      return DataRow(
        cells: [
          DataCell(
            Text(
              '${DateFormat("yyyy - mm - dd").format(dateTime)}\n${DateFormat("HH : mm").format(dateTime)}',
            ),
          ),
          DataCell(
            Text(immun),
          ),
          DataCell(
            Text(doctor),
          ),
          DataCell(
            Text(hospital),
          ),
          DataCell(
            status
                ? SizedBox(
                    width: 10,
                    height: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.greenAccent,
                      ),
                    ),
                  )
                : SizedBox(
                    width: 10,
                    height: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
          ),
        ],
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Immun Tracker'),
        backgroundColor: greenColor,
        toolbarHeight: 71.0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: columns,
            rows: rows,
          ),
        ),
      ),
    );
  }
}
