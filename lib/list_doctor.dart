import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/utils/card_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'details_doctor.dart';
import 'theme.dart';

class ListDoctorPage extends StatefulWidget {
  final String role;
  const ListDoctorPage({super.key, required this.role});

  @override
  State<ListDoctorPage> createState() => _ListDoctorPageState();
}

class _ListDoctorPageState extends State<ListDoctorPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0x0ff006D77),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Consultation Nutri'),
        backgroundColor: greenColor,
        toolbarHeight: 71.0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 20),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: widget.role == "doctor"
                      ? users.where('role', isEqualTo: 'user').snapshots()
                      : users.where('role', isEqualTo: 'doctor').snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs.map((e) {
                          final status =
                              (e.data() as Map<String, dynamic>)['status'] ??
                                  '';
                          final docId = e.id;
                          return CardDoctor(
                            firstNameDoctor: (e.data()
                                    as Map<String, dynamic>)['firstName'] ??
                                '',
                            lastNameDoctor: (e.data()
                                    as Map<String, dynamic>)['lastName'] ??
                                '',
                            image: (e.data()
                                    as Map<String, dynamic>)['imageUrl'] ??
                                '',
                            role: (e.data() as Map<String, dynamic>)['role'] ??
                                '',
                            status: status,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsDoctorPage(
                                    firstName: (e.data() as Map<String,
                                            dynamic>)['firstName'] ??
                                        '',
                                    lastName: (e.data() as Map<String,
                                            dynamic>)['lastName'] ??
                                        '',
                                    image: (e.data() as Map<String, dynamic>)[
                                            'imageUrl'] ??
                                        '',
                                    docId: docId,
                                  ),
                                ),
                              );
                            },
                            textTombol: "See Details",
                          );
                        }).toList(),
                      );
                    } else {
                      return Text("Loading");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
