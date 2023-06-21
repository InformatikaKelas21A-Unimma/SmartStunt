import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'theme.dart';

class GrowcheckPage extends StatefulWidget {
  const GrowcheckPage({super.key});

  @override
  State<GrowcheckPage> createState() => _GrowcheckPageState();
}

enum Sex { boy, girl }

class _GrowcheckPageState extends State<GrowcheckPage> {
  String prediction = '';
  Sex? _sex = Sex.girl;
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _weightController;
  TextEditingController? _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _sex = null;
  }

  convert(Sex sex) {
    if (sex == Sex.boy) {
      return 0;
    } else if (sex == Sex.girl) {
      return 1;
    }
  }

  Future<void> fetchPrediction(List<num> inputData) async {
    final apiUrl = 'http://10.0.2.2:5000/predict/stunting';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'input': inputData}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        prediction = data['prediction'];
      });
    } else {
      throw Exception('Failed to fetch prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Growcheck Baby'),
        backgroundColor: greenColor,
        toolbarHeight: 71.0,
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Enter baby data",
                style: TextStyle(
                  fontFamily: "PoppinsMedium",
                  fontSize: 20.0,
                  color: blackColor,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Baby Name"),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 300,
                        height: 46,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            prefixIcon: Image.asset(
                              "images/icon/baby.png",
                              width: 10,
                              height: 10,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 15.0,
                            color: blackColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: ListTile(
                              title: const Text('Laki - laki'),
                              horizontalTitleGap: 0,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              leading: Radio<Sex>(
                                value: Sex.boy,
                                groupValue: _sex,
                                onChanged: (Sex? value) {
                                  setState(() {
                                    _sex = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: ListTile(
                              title: const Text('Perempuan'),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              horizontalTitleGap: 0,
                              leading: Radio<Sex>(
                                value: Sex.girl,
                                groupValue: _sex,
                                onChanged: (Sex? value) {
                                  setState(() {
                                    _sex = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Age"),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 300,
                        height: 46,
                        child: TextField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            prefixIcon: Image.asset(
                              "images/icon/age.png",
                              width: 10,
                              height: 10,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Weight"),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 300,
                        height: 46,
                        child: TextField(
                          controller: _weightController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            prefixIcon: Image.asset(
                              "images/icon/weight.png",
                              width: 10,
                              height: 10,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Height"),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 300,
                        height: 46,
                        child: TextField(
                          controller: _heightController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            prefixIcon: Image.asset(
                              "images/icon/height.png",
                              width: 10,
                              height: 10,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          fetchPrediction(
                            [
                              convert(_sex!),
                              int.parse(_ageController!.text),
                              double.parse(_weightController!.text),
                              double.parse(_heightController!.text),
                            ],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'Check',
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 18.0,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    prediction == ''
                        ? SizedBox()
                        : prediction == 'Ya'
                            ? Text(
                                'Oops, ${_nameController!.text} was diagnosed with stunting',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "PoppinsRegular",
                                  color: Colors.red,
                                ),
                              )
                            : Text(
                                '${_nameController!.text} wasn`t diagnosed with stunting',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "PoppinsRegular",
                                  color: Colors.green,
                                ),
                              ),
                    SizedBox(
                      height: 30,
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
