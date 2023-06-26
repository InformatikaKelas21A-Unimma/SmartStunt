import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'details_doctor.dart';
import 'firebase_options.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'chat.dart';
import 'community.dart';
import 'growcheck.dart';
import 'immunReminder.dart';
import 'immun_tracker.dart';
import 'list_doctor.dart';
import 'login.dart';
import 'rooms.dart';
import 'setting.dart';
import 'theme.dart';
import 'utils/card_doctor.dart';

class DashboardPage extends StatefulWidget {
  final String? documentId;

  DashboardPage({this.documentId});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with WidgetsBindingObserver {
  double _kSize = 100;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update(
      {"status": status},
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    List<Widget> pages = [
      DashboardPage(),
      ImmunReminderPage(),
      RoomsPage(),
      SettingPage(),
    ];

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          "${data['imageUrl']}",
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, ${data['firstName']} ${data['lastName']}",
                            style: TextStyle(
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 15.0,
                              color: greenColor,
                            ),
                          ),
                          Text(
                            "${data['email']}",
                            style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 11.0,
                              color: grey3Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.notifications_active_outlined,
                    color: greyColor,
                  ),
                ],
              ),
              backgroundColor: Color(0x0ffF4F4F4),
              elevation: 0.0,
            ),
            backgroundColor: Color(0x0ffF4F4F4),
            body: ListView(children: [
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 70.0,
                        height: 140.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                top: 20.0,
                                left: 25.0,
                              ),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 156.0,
                                    height: 120.0,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Beware of stunting, take care of children's growth.",
                                            style: TextStyle(
                                              fontFamily: "PoppinsMedium",
                                              fontSize: 14,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Container(
                                              width: 87.0,
                                              height: 21.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Color(0xFF5ABFBF),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Let's start",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    fontSize: 12.0,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 20.0,
                                ),
                                child: Image.asset("images/doctor.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF56BFBF),
                            Color(0xFF026A6A),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 70.0,
                      margin: EdgeInsets.only(
                        top: 27.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RoomsPage(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("images/icon/cn.png"),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Consultation Nutri",
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 11,
                                            color: greenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CommunityPage(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("images/icon/ct.png"),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Community",
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 11,
                                            color: greenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ImmunTrackerPage(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("images/icon/it.png"),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Immun Track",
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 11,
                                            color: greenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ImmunReminderPage(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("images/icon/ir.png"),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Immun Reminder",
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 11,
                                            color: greenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const GrowcheckPage(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset("images/icon/gb.png"),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Growcheck Baby",
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 11,
                                            color: greenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 62,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 18.0,
                      ),
                      padding: EdgeInsets.only(
                        left: 27,
                        right: 27,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "images/icon/it.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 13.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 107,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          "Immun Track Record",
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImmunTrackerPage(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "View All",
                                              style: TextStyle(
                                                fontFamily: 'PoppinsMedium',
                                                fontSize: 11.0,
                                                color: greenColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset("images/icon/note.png"),
                                  ],
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 280.0,
                                        child: Text(
                                          "Immunization record for your toddler Start recording toddler immunizations to prevent stunting",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'PoppinsMedium',
                                            fontSize: 10,
                                            color: greenOld2Color,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImmunReminderPage(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 5.0,
                                ),
                                width: MediaQuery.of(context).size.width - 35,
                                height: 41.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: whiteColor,
                                  border: Border.all(
                                    color: greenColor,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: greenColor,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          const Text(
                                            'Add new record',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: greenColor,
                                              fontSize: 12.0,
                                              fontFamily: 'PoppinsMedium',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Consultation Nutri",
                                style: TextStyle(
                                  fontFamily: "PoppinsMedium",
                                  fontSize: 15.0,
                                  color: blackColor,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListDoctorPage(
                                        role: data['role'],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    fontFamily: "PoppinsMedium",
                                    fontSize: 11.0,
                                    color: greenColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: data['role'] == "doctor"
                                    ? users
                                        .where('role', isEqualTo: 'user')
                                        .snapshots()
                                    : users
                                        .where('role', isEqualTo: 'doctor')
                                        .snapshots(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data!.docs.map((e) {
                                        final status = (e.data() as Map<String,
                                                dynamic>)['status'] ??
                                            '';
                                        final docId = e.id;
                                        return CardDoctor(
                                          firstNameDoctor: (e.data() as Map<
                                                  String,
                                                  dynamic>)['firstName'] ??
                                              '',
                                          lastNameDoctor: (e.data() as Map<
                                                  String,
                                                  dynamic>)['lastName'] ??
                                              '',
                                          image: (e.data() as Map<String,
                                                  dynamic>)['imageUrl'] ??
                                              '',
                                          status: status,
                                          role: (e.data() as Map<String,
                                                  dynamic>)['role'] ??
                                              '',
                                          onpressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsDoctorPage(
                                                  firstName: (e.data() as Map<
                                                              String, dynamic>)[
                                                          'firstName'] ??
                                                      '',
                                                  lastName: (e.data() as Map<
                                                              String, dynamic>)[
                                                          'lastName'] ??
                                                      '',
                                                  image: (e.data() as Map<
                                                              String, dynamic>)[
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
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        }

        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.white,
                  size: _kSize,
                  secondRingColor: Colors.black,
                  thirdRingColor: Colors.purple,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  void logout(BuildContext context) async {
    setStatus('Offline');
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  void _handlePressed(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
        settings: RouteSettings(name: "DashboardPage"),
      ),
    );
  }
}
// FutureBuilder<QuerySnapshot>(
                          //   future:
                          //       users.where('role', isEqualTo: 'doctor').get(),
                          //   builder: (_, snapshot) {
                          //     if (snapshot.hasData) {
                          //       return Column(
                          //         children: snapshot.data!.docs
                          //             .map(
                          //               (e) => CardDoctor(
                          //                 firstNameDoctor: (e.data() as Map<
                          //                         String,
                          //                         dynamic>)['firstName'] ??
                          //                     '',
                          //                 lastNameDoctor: (e.data() as Map<
                          //                         String,
                          //                         dynamic>)['lastName'] ??
                          //                     '',
                          //                 image: (e.data() as Map<String,
                          //                         dynamic>)['imageUrl'] ??
                          //                     '',
                          //                 onpressed: () {},
                          //                 textTombol: "Chat Now",
                          //               ),
                          //             )
                          //             .toList(),
                          //       );
                          //     } else {
                          //       return Text("Loading...");
                          //     }
                          //   },
                          // ),
                          // children: snapshot.data!.docs
                                      //     .map(
                                      //       (e) => CardDoctor(
                                      //         firstNameDoctor: (e.data() as Map<
                                      //                 String,
                                      //                 dynamic>)['firstName'] ??
                                      //             '',
                                      //         lastNameDoctor: (e.data() as Map<
                                      //                 String,
                                      //                 dynamic>)['lastName'] ??
                                      //             '',
                                      //         image: (e.data() as Map<String,
                                      //                 dynamic>)['imageUrl'] ??
                                      //             '',
                                      //         status: (e.data() as Map<String,
                                      //                 dynamic>)['status'] ??
                                      //             '',
                                      //         onpressed: () {
                                      //           Navigator.push(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   DetailsDoctorPage(
                                      //                 firstName: (e.data()
                                      //                             as Map<String,
                                      //                                 dynamic>)[
                                      //                         'firstName'] ??
                                      //                     '',
                                      //                 lastName: (e.data()
                                      //                             as Map<String,
                                      //                                 dynamic>)[
                                      //                         'lastName'] ??
                                      //                     '',
                                      //                 image: (e.data() as Map<
                                      //                             String,
                                      //                             dynamic>)[
                                      //                         'imageUrl'] ??
                                      //                     '',
                                      //               ),
                                      //             ),
                                      //           );
                                      //         },
                                      //         textTombol: "See Details",
                                      //       ),
                                      //     )
                                      //     .toList(),