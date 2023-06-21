import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CardDoctor extends StatefulWidget {
  final String? firstNameDoctor;
  final String? uId;
  final String? lastNameDoctor;
  final String? image;
  final String? textTombol;
  final String? status;
  final String? docId;
  final String? role;
  final VoidCallback onpressed;
  const CardDoctor({
    super.key,
    this.firstNameDoctor,
    this.lastNameDoctor,
    this.image,
    this.textTombol,
    required this.onpressed,
    this.status,
    this.uId,
    this.docId,
    this.role,
  });

  @override
  State<CardDoctor> createState() => _CardDoctorState();
}

class _CardDoctorState extends State<CardDoctor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 4.0,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
        color: whiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 2.0,
              top: 15.0,
              right: 15.0,
              left: 15.0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${widget.image}",
                  ),
                ),
                SizedBox(
                  width: 14.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.role == 'doctor'
                        ? Text(
                            "dr. ${widget.firstNameDoctor} ${widget.lastNameDoctor}",
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 12.0,
                              color: blackColor,
                            ),
                          )
                        : Text(
                            "${widget.firstNameDoctor} ${widget.lastNameDoctor}",
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 12.0,
                              color: blackColor,
                            ),
                          ),
                    Text(
                      "Specialist Nutrition",
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 11.0,
                        color: Color(0x0ffB5B5B5),
                      ),
                    ),
                    widget.status == 'Online'
                        ? Text(
                            "ONLINE",
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 11.0,
                              color: Color(0x0ff00FF1A),
                            ),
                          )
                        : Text(
                            "OFFLINE",
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 11.0,
                              color: Colors.red,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 2.0, bottom: 15.0, right: 15.0, left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today :",
                      style: TextStyle(
                        fontFamily: "PoppinsMedium",
                        fontSize: 10.0,
                        color: Color(0x0ffA3A3A3),
                      ),
                    ),
                    Text(
                      "08 : 00 - 12 : 00",
                      style: TextStyle(
                        fontFamily: "PoppinsMedium",
                        fontSize: 10.0,
                        color: greenColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 110.0,
                  height: 28.0,
                  child: TextButton(
                    onPressed: widget.onpressed,
                    child: Text(
                      "${widget.textTombol}",
                      style: TextStyle(
                        fontFamily: "PoppinsSB",
                        fontSize: 10.0,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
