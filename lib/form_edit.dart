import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'setting.dart';
import 'theme.dart';

class EditProfileForm extends StatefulWidget {
  final Map<String, dynamic> data;
  final String docId;

  EditProfileForm({required this.data, required this.docId});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateData(String docId, Map<String, dynamic> newData) async {
    try {
      await users.doc(docId).update(newData);
      print("Data updated successfully");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.data['firstName'] ?? '';
    lastNameController.text = widget.data['lastName'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 26,
                  right: 26,
                  top: 30,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'First Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PoppinsRegular',
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        textAlignVertical: TextAlignVertical.center,
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: greyColor,
                          hintText: 'First Name',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: blackColor,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 9.76,
                              right: 18,
                              left: 28,
                            ),
                            child: Icon(
                              Icons.person,
                              color: greenColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Last Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'PoppinsRegular',
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: lastNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: greyColor,
                          hintText: 'Last Name',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: blackColor,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 9.76,
                              right: 18,
                              left: 30,
                            ),
                            child: Icon(
                              Icons.email,
                              color: greenColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Map<String, dynamic> newData = {
                          "firstName": firstNameController.text,
                          "lastName": lastNameController.text,
                        };
                        updateData(widget.docId, newData);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingPage(),
                          ),
                        );
                      },
                      child: Text("Edit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
