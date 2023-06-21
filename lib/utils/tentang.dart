import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class Tentang extends StatefulWidget {
  const Tentang({super.key});

  @override
  State<Tentang> createState() => _TentangState();
}

class _TentangState extends State<Tentang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13.0),
      width: 390.0,
      height: 250.0,
      decoration: BoxDecoration(
        color: Color(0x0ffF5F5F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(4, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Tentang",
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
            GridView.count(
              childAspectRatio: 3.0,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Bank",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 14.0,
                        color: Color(0x0ff787878),
                      ),
                    ),
                    Text(
                      "BCA",
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 14.0,
                        color: Color(0x0ff444444),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Telepon",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 14.0,
                        color: Color(0x0ff787878),
                      ),
                    ),
                    Text(
                      "0857-8667-5453",
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 14.0,
                        color: Color(0x0ff444444),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Rekening",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 14.0,
                        color: Color(0x0ff787878),
                      ),
                    ),
                    Text(
                      "0982-0987-4321-009",
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 14.0,
                        color: Color(0x0ff444444),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ID Akun",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 14.0,
                        color: Color(0x0ff787878),
                      ),
                    ),
                    Text(
                      "#982102",
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 14.0,
                        color: Color(0x0ff444444),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: TextStyle(
                        fontFamily: "PoppinsLight",
                        fontSize: 14.0,
                        color: Color(0x0ff787878),
                      ),
                    ),
                    Text(
                      "suziepoo@gmail.com",
                      style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 14.0,
                        color: Color(0x0ff444444),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  child: Container(
                    constraints:
                        BoxConstraints.tightFor(width: 100.0, height: 30.0),
                    decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("images/icons/edit.png"),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 16.0,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
