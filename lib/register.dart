import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:example/login.dart';
import 'package:example/theme.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _email;
  String? _firstName;
  FocusNode? _focusNode;
  String? _lastName;
  String? _phone;
  Role? _role;
  TextEditingController? _lastNameController;
  TextEditingController? _firstNameController;
  TextEditingController? _passwordController;
  // TextEditingController? _nameController;
  TextEditingController? _phoneController;
  bool _registering = false;
  TextEditingController? _usernameController;
  TextEditingController? _roleController;

  @override
  void initState() {
    super.initState();
    final faker = Faker();
    // _firstName = _firstNameController.toString(); //faker.person.firstName();
    // _lastName = _lastNameController.toString(); //faker.person.lastName();
    // _email = _usernameController.toString();

    // '${_firstName!.toLowerCase()}.${_lastName!.toLowerCase()}@${faker.internet.domainName()}';
    _focusNode = FocusNode();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController(); //text: 'Qawsed1-');
    _usernameController = TextEditingController(); //text: _email,
    // _roleController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _passwordController?.dispose();
    _usernameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Image.asset('images/Logo.png'),
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                Text(
                  'Create your new account',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          width: 142.5,
                          height: 46,
                          child: TextField(
                            // autocorrect: false,
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              labelText: 'First Name',
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () => _firstNameController?.clear(),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,

                            onEditingComplete: () {
                              _focusNode?.requestFocus();
                            },
                            readOnly: _registering,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 142.5,
                          height: 46,
                          child: TextField(
                            // autocorrect: false,
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              labelText: 'Last Name',
                              labelStyle: TextStyle(
                                fontSize: 12,
                                fontFamily: 'PoppinsRegular',
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () => _lastNameController?.clear(),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,

                            onEditingComplete: () {
                              _focusNode?.requestFocus();
                            },
                            readOnly: _registering,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  height: 46,
                  child: TextField(
                    // autocorrect: false,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _phoneController?.clear(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      _focusNode?.requestFocus();
                    },
                    readOnly: _registering,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  height: 46,
                  child: TextField(
                    // autocorrect: false,
                    // autofillHints: _registering ? null : [AutofillHints.email],
                    // autofocus: true,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _usernameController?.clear(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      _focusNode?.requestFocus();
                    },
                    readOnly: _registering,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  height: 46,
                  child: TextField(
                    // autocorrect: false,
                    autofillHints:
                        _registering ? null : [AutofillHints.password],
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _passwordController?.clear(),
                      ),
                    ),
                    focusNode: _focusNode,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    onEditingComplete: _register,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 300,
                  height: 46,
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // isExpanded: true,
                    hint: const Text(
                      'Select Your Role',
                      style: TextStyle(fontSize: 14),
                    ),
                    value: _role,
                    onChanged: (Role? newValue) {
                      setState(
                        () {
                          _role = newValue;
                        },
                      );
                    },
                    items: Role.values
                        .map(
                          (Role role) => DropdownMenuItem(
                            value: role,
                            child: Text(
                              _getRoleText(role),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select role.';
                      }
                      return null;
                    },

                    buttonStyleData: const ButtonStyleData(
                      height: 60,
                      padding: EdgeInsets.only(right: 10),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 305,
                  child: InkWell(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By signing up you agree to our ',
                        style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 12,
                          color: blackColor,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Terms & Conditions ',
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 12,
                              color: greenOld2Color,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: 'and ',
                            style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              fontSize: 12,
                              color: blackColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontFamily: "PoppinsMedium",
                              fontSize: 12,
                              color: greenOld2Color,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                TextButton(
                  onPressed: _registering ? null : _register,
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF56BFBF),
                          Color(0xFF026A6A),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontFamily: 'PoppinsBold',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Already have an Account ? ',
                        style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 12,
                          color: blackColor,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              fontFamily: "PoppinsBold",
                              fontSize: 14,
                              color: greenOldColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  String _getRoleText(Role role) {
    if (role == Role.doctor) {
      return 'doctor';
    } else if (role == Role.admin) {
      return 'admin';
    } else if (role == Role.user) {
      return 'user';
    } else {
      return role.toString();
    }
  }

  void _register() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _registering = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameController!.text,
        password: _passwordController!.text,
      );
      // final userRoleString = _role.toString();
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _firstNameController?.text,
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${_firstNameController?.text}',
          lastName: _lastNameController?.text,
          email: _usernameController?.text,
          phone: _phoneController?.text,
          role: _role,
        ),
      );
      // String userId = credential.user!.uid;
      // DocumentReference userRef =
      //     FirebaseFirestore.instance.collection('users').doc(userId);
      // // Dapatkan snapshot dari dokumen pengguna
      // DocumentSnapshot userSnapshot = await userRef.get();

      // // Dapatkan documentId (ID dokumen) dari snapshot
      // String documentId = userSnapshot.id;

      // FirebaseFirestore firestore = FirebaseFirestore.instance;
      // CollectionReference users = firestore.collection('users');
      // DocumentReference userDoc = users.doc(documentId);

      // await userRef.set('status':'Unavailable');

      // Map<String, dynamic> newData = {
      //   'email': '${_usernameController?.text}',
      //   'firstName': '${_firstNameController?.text}',
      //   'lastName': '${_lastNameController?.text}',
      //   'imageUrl': 'https://i.pravatar.cc/300?u=${_firstNameController?.text}',
      //   'phone': '${_phoneController?.text}',
      //   'role': '${_getRoleText(_role!)}',
      // };
      // userDoc.update(newData);

      // Map<String, dynamic> newData = {
      //   'status': 'Unavailable',
      //   'phone': "${_phoneController}",
      // };
      // userRef.set(newData);

      if (!mounted) return;
      Navigator.of(context)..pop();
    } catch (e) {
      setState(() {
        _registering = false;
      });

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }
}
