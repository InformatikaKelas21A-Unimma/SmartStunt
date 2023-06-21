// import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
// }

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    this.dateTime,
    this.immun,
    this.doctor,
    this.hospital,
    // required this.onDelete,
  }) : super(key: key);

  final DateTime? dateTime;
  final String? immun;
  final String? doctor;
  final String? hospital;
  // final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: greenColor,
          width: 1.0,
        ),
      ),
      child: RoundedExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          children: [
            Image.asset(
              "images/icon/inject.png",
              width: 50,
            ),
            Text('Imunisasi ${immun}'),
          ],
        ),
        children: [
          Container(
            width: 100.0,
            height: 2.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Color(0x0FFCED3DE),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 13, top: 13),
            child: ListTile(
              subtitle: Text(
                "Hospital : ${hospital}\nDoctor : ${doctor}\nDate : ${DateFormat('dd - MM - yyyy').format(dateTime!)}\nTime : ${DateFormat('HH : mm').format(dateTime!)}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: grey2Color,
                  fontFamily: "PoppinsRegular",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// trailing: IconButton(
        //   icon: Icon(Icons.delete),
        //   color: Colors.redAccent,
        //   onPressed:
        //       onDelete, // Panggil fungsi callback onDelete saat tombol ditekan
        // ),