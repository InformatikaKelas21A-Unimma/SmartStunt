import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../form_edit.dart';
import '../login.dart';
import '../theme.dart';
import 'custom_button.dart';

class Layanan extends StatefulWidget {
  const Layanan({super.key});

  @override
  State<Layanan> createState() => _LayananState();
}

void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (route) => false,
  );
}

class _LayananState extends State<Layanan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13.0, bottom: 25.0),
      width: 390.0,
      decoration: BoxDecoration(
        color: Color(0x0ffF5F5F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Layanan",
                style: TextStyle(
                  fontFamily: "PoppinsSB",
                  fontSize: 15.0,
                  color: blackColor,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
              color: Color(0x0ffD2D2D2),
            ),
            CustomButton(
              onpressed: () {},
              width: 339.0,
              height: 51.0,
              icon: "gear",
              text: "Pengaturan",
            ),
            CustomButton(
              onpressed: () {},
              width: 339.0,
              height: 51.0,
              icon: "quest",
              text: "Bantuan",
            ),
            CustomButton(
              onpressed: () {},
              width: 339.0,
              height: 51.0,
              icon: "info",
              text: "Tentang Charity",
            ),
            CustomButton(
              onpressed: () {},
              width: 339.0,
              height: 51.0,
              icon: "cs",
              text: "Hubungi",
            ),
            CustomButton(
              onpressed: () {
                logout(context);
              },
              width: 339.0,
              height: 51.0,
              icon: "logout",
              text: "Keluar",
            ),
          ],
        ),
      ),
    );
  }
}
