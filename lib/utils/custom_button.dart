import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onpressed;
  final double width;
  final double height;
  final String icon;
  final String text;

  const CustomButton(
      {super.key,
      required this.onpressed,
      required this.width,
      required this.height,
      required this.icon,
      required this.text});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x0ffDEDEDE),
      ),
      child: TextButton(
        onPressed: widget.onpressed,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Image.asset(
              "images/icon/${widget.icon}.png",
              color: greenColor,
            ),
            SizedBox(
              width: 22.0,
            ),
            Text(
              "${widget.text}",
              style: TextStyle(
                fontFamily: "PoppinsRegular",
                fontSize: 16.0,
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }
}
