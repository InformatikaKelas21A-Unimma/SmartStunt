import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DompetDonasi extends StatefulWidget {
  const DompetDonasi({super.key});

  @override
  State<DompetDonasi> createState() => _DompetDonasiState();
}

class _DompetDonasiState extends State<DompetDonasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 13.0, bottom: 10.0),
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
                "Dompet Donasi",
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
            Text(
              "Total Dompet Donasi",
              style: TextStyle(
                fontFamily: "PoppinsLight",
                fontSize: 14.0,
                color: Color(0x0ff787878),
              ),
            ),
            Text(
              "Rp. 100.000,00",
              style: TextStyle(
                fontFamily: "PoppinsRegular",
                fontSize: 16.0,
                color: Color(0x0ff444444),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7.0),
              width: 340.0,
              height: 64.0,
              decoration: BoxDecoration(
                color: Color(0x0ffE5E5E5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Image.asset(
                          "images/icons/withdraw.png",
                        ),
                        Text(
                          "Tarik",
                          style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 14.0,
                            color: Color(0x0ff787878),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 4,
                    color: whiteColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Image.asset(
                          "images/icons/deposit.png",
                        ),
                        Text(
                          "Isi",
                          style: TextStyle(
                            fontFamily: "PoppinsLight",
                            fontSize: 14.0,
                            color: Color(0x0ff787878),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
