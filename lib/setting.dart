import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'form_edit.dart';
import 'theme.dart';
import 'utils/dompet_donasi.dart';
import 'utils/layanan.dart';
import 'utils/tentang.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

String getCurrentUID() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String uid = user.uid;
    return uid;
  } else {
    // Tindakan jika tidak ada pengguna yang masuk
    // Misalnya, tampilkan pesan kesalahan atau arahkan pengguna ke halaman masuk
    return '';
  }
}

class _SettingPageState extends State<SettingPage> {
  String activeTab = "Personal";
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(getCurrentUID()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String docId = snapshot.data!.id;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: greenColor,
              title: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 22.0,
                  ),
                ),
              ),
              elevation: 0,
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: greenColor),
                          height: 180.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data['firstName']} ${data['lastName']}",
                                              style: TextStyle(
                                                fontFamily: "PoppinsSB",
                                                fontSize: 20.0,
                                                color: whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "Kab. Magelang, Indonesia",
                                              style: TextStyle(
                                                fontFamily: "PoppinsRegular",
                                                fontSize: 15.0,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileForm(
                                                  data: data,
                                                  docId: docId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              "${data['imageUrl']}",
                                            ),
                                            radius: 45.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  activeTab = "Personal";
                                                });
                                              },
                                              child: Text(
                                                "Personal",
                                                style: TextStyle(
                                                  fontFamily: "PoppinsRegular",
                                                  fontSize: 15.0,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ),
                                            if (activeTab == "Personal")
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                width: 67.0,
                                                child: const Divider(
                                                  thickness: 4.0,
                                                  color: whiteColor,
                                                ),
                                              ),
                                            if (activeTab != "Personal")
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                width: 67.0,
                                                child: const Divider(
                                                  thickness: 4.0,
                                                  color: greenColor,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (activeTab == "Personal")
                                Visibility(
                                  visible: activeTab == "Personal",
                                  child: Column(
                                    children: <Widget>[
                                      Layanan(),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text("Loading"),
              ),
            ],
          ),
        );
      },
    );
  }
}
