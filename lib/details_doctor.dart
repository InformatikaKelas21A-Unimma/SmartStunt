import 'package:example/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'theme.dart';

class DetailsDoctorPage extends StatefulWidget {
  final String image;

  final String firstName;
  final String docId;
  final String lastName;

  const DetailsDoctorPage({
    super.key,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.docId,
  });

  @override
  State<DetailsDoctorPage> createState() => _DetailsDoctorPageState();
}

class _DetailsDoctorPageState extends State<DetailsDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                  ),
                  borderRadius: BorderRadius.circular(19),
                ),
                width: 47.0,
                height: 47.0,
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0x0ff006D77),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "dr. ${widget.firstName} ${widget.lastName}",
                  style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 20.0,
                    color: blackColor,
                  ),
                ),
                Text(
                  "Specialist Nutrition",
                  style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 15.0,
                    color: Color(0x0ff006D77),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                  ),
                  borderRadius: BorderRadius.circular(19),
                ),
                width: 47.0,
                height: 47.0,
                child: Icon(
                  Icons.more_vert,
                  color: Color(0x0ff006D77),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  "${widget.image}",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    width: 62.0,
                    height: 62.0,
                    decoration: BoxDecoration(
                      color: Color(0x0ff006D77),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 4.0,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.videocam_rounded,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Container(
                    width: 62.0,
                    height: 62.0,
                    decoration: BoxDecoration(
                      color: Color(0x0ff006D77),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 4.0,
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 94),
                      child: Container(
                        width: 62,
                        child: StreamBuilder<List<types.User>>(
                          stream: FirebaseChatCore.instance.users(),
                          initialData: const [],
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 200),
                                child: const Text('No users'),
                              );
                            }

                            // Ambil pengguna berdasarkan ID atau kriteria lainnya
                            final user = snapshot.data!
                                .where((user) =>
                                    user.firstName == widget.firstName &&
                                    user.lastName == widget.lastName)
                                .toList();

                            if (user == null) {
                              return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 200),
                                child: const Text('User not found'),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: user.length,
                              itemBuilder: (context, index) {
                                final users = user[index];
                                //
                                return GestureDetector(
                                  onTap: () {
                                    _handlePressed(
                                        users, context, widget.docId);
                                  },
                                  child: Container(
                                    width: 62.0,
                                    height: 62.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x0ff006D77),
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 5),
                                          blurRadius: 4.0,
                                          color: Color.fromRGBO(0, 0, 0, 0.2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.chat,
                                      color: whiteColor,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 62.0,
                  //   height: 62.0,
                  //   decoration: BoxDecoration(
                  //     color: Color(0x0ff006D77),
                  //     borderRadius: BorderRadius.circular(100),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         offset: Offset(0, 5),
                  //         blurRadius: 4.0,
                  //         color: Color.fromRGBO(0, 0, 0, 0.2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.chat,
                  //       color: whiteColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 28.0,
              ),
              Container(
                color: Color.fromRGBO(0, 109, 119, 0.13),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About Doctor",
                              style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                fontSize: 20.0,
                                color: blackColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "⭐ 4.9",
                                  style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 12.0,
                                    color: blackColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "( 280 Reviews )",
                                  style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    fontSize: 12.0,
                                    color: Color.fromRGBO(0, 109, 119, 0.56),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: Text(
                          "A doctor is someone who is experienced and certified to practice medicine to help maintain or restore physical and mental health.",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 15.0,
                            color: Color(0x0ff006D77),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handlePressed(
      types.User otherUser, BuildContext context, String docId) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    navigator.pop();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
          docId: docId,
        ),
      ),
    );
  }
}
// return Container(
//   width: 62.0,
//   height: 62.0,
//   decoration: BoxDecoration(
//     color: Color(0x0ff006D77),
//     borderRadius: BorderRadius.circular(100),
//     boxShadow: [
//       BoxShadow(
//         offset: Offset(0, 5),
//         blurRadius: 4.0,
//         color: Color.fromRGBO(0, 0, 0, 0.2),
//       ),
//     ],
//   ),
//   child: IconButton(
//     onPressed: () {
//       _handlePressed(users, context);
//     },
//     icon: Icon(
//       Icons.chat,
//       color: whiteColor,
//     ),
//   ),
// );
