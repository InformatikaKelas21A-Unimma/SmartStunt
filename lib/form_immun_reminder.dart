import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:example/notification_manager/notification_manager.dart';
import 'package:example/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class FormImmunReminderPage extends StatefulWidget {
  const FormImmunReminderPage({super.key});

  @override
  State<FormImmunReminderPage> createState() => _FormImmunReminderPageState();
}

class _FormImmunReminderPageState extends State<FormImmunReminderPage> {
  TextEditingController? _medicalController = TextEditingController();
  TextEditingController? _doctorController = TextEditingController();
  final List<DateTime> scheduledDateTime = [];
  String? _selectedOption;
  List<String> _options = [
    'Influenza',
    'Polio',
    'BCG',
    'Campak',
    'Tipes',
    'Cacar Air',
  ];
  bool? status = false;
  @override
  void dispose() {
    _medicalController?.dispose();
    _doctorController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Immun Reminder"),
        backgroundColor: greenColor,
        toolbarHeight: 71.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 19,
            right: 31,
            left: 31,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Immunization Category *",
                  style: TextStyle(
                    fontFamily: 'PoppinsMedium',
                    fontSize: 12,
                    color: greenColor,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  child: DropdownButtonFormField2<String>(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // isExpanded: true,
                    hint: const Text(
                      'Select Immunity',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    items: _options.map((String? option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option!),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select role.';
                      }
                      return null;
                    },

                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      width: 328.0,
                      padding: EdgeInsets.only(right: 20, left: 20),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  "Medical Facility *",
                  style: TextStyle(
                    fontFamily: 'PoppinsMedium',
                    fontSize: 12,
                    color: greenColor,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  height: 40,
                  child: TextField(
                    controller: _medicalController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Medical Facility',
                      labelStyle: TextStyle(
                        fontSize: 11,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  "Doctor Name *",
                  style: TextStyle(
                    fontFamily: 'PoppinsMedium',
                    fontSize: 12,
                    color: greenColor,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  height: 40,
                  child: TextField(
                    controller: _doctorController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Doctor Name',
                      labelStyle: TextStyle(
                        fontSize: 11,
                        fontFamily: 'PoppinsRegular',
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Image.asset('images/icon/date.png'),
                              SizedBox(
                                width: 9,
                              ),
                              Text(
                                "Date *",
                                style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 12.0,
                                  color: greenColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 118,
                          height: 31,
                          child: ElevatedButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              selectedDate != null
                                  ? '${DateFormat('yyyy-M-dd').format(selectedDate!)}'
                                  : 'Select Date',
                              style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 10,
                                color: blackColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Image.asset('images/icon/time.png'),
                              SizedBox(
                                width: 9,
                              ),
                              Text(
                                "Time *",
                                style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  fontSize: 12.0,
                                  color: greenColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 118,
                          height: 31,
                          child: ElevatedButton(
                            onPressed: () => _selectTime(context),
                            child: Text(
                              selectTimeHour != null && selectTimeMinute != null
                                  ? '${selectTimeHour}:${selectTimeMinute}'
                                  : 'Select Time',
                              style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 10,
                                color: blackColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 134,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      DateTime dateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectTimeHour!,
                        selectTimeMinute!,
                      );
                      String immun = _selectedOption!;

                      NotificationManager().scheduleNotification(
                        dateTime,
                        "SmartStunt",
                        "Ayo imunisasi ${immun} di ${_medicalController!.text}.\nBersama ${_doctorController!.text}",
                      );
                      Navigator.pop(
                        context,
                        {
                          'dateTime': dateTime,
                          'immun': immun,
                          'hospital': _medicalController!.text,
                          'doctor': _doctorController!.text,
                          'status': status,
                        },
                      );
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: 'PoppinsMedium',
                        fontSize: 15.0,
                        color: whiteColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  int? selectTimeHour;
  int? selectTimeMinute;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
      useRootNavigator: false,
    );

    if (picked != null) {
      // Mengambil jam dan menit dari TimeOfDay
      final int hour = picked.hour;
      final int minute = picked.minute;

      setState(() {
        selectTimeHour = hour;
        selectTimeMinute = minute;
      });
    }
  }
}
