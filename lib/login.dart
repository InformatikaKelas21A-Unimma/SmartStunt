// import 'dart:html';

import 'package:example/dashboard.dart';
import 'package:example/rooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/theme.dart';
import 'firebase_options.dart';
import 'register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'utils/bottom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late final String documentId;
  FocusNode? _focusNode;
  bool _loggingIn = false;
  TextEditingController? _passwordController;
  TextEditingController? _usernameController;
  // bool _error = false;
  // bool _initialized = false;
  // User? _user;
  // late final String documentId;

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    _focusNode = FocusNode();
    _passwordController = TextEditingController(text: '');
    _usernameController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _passwordController?.dispose();
    _usernameController?.dispose();
    super.dispose();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
            child: Column(
              children: <Widget>[
                Image.asset('images/Logo.png'),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 46,
                  child: TextField(
                    autocorrect: false,
                    autofillHints: _loggingIn ? null : [AutofillHints.email],
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Enter email',
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
                    readOnly: _loggingIn,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 46,
                  child: Container(
                    child: TextField(
                      autocorrect: false,
                      // autofillHints:
                      //     _loggingIn ? null : [AutofillHints.password],
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
                      onEditingComplete: _login,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                SizedBox(
                  width: 300,
                  child: InkWell(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Remember me',
                        style: TextStyle(
                          fontFamily: 'PoppinsMedium',
                          fontSize: 11,
                          color: grey2Color,
                        ),
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: SizedBox(
                              width: 110,
                            ),
                          ),
                          TextSpan(
                            text: 'Forgot Password ?',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'PoppinsMedium',
                              color: greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                TextButton(
                  onPressed: _loggingIn ? null : _login,
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
                        'Login',
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
                Container(
                  margin: EdgeInsets.only(
                    top: 6.0,
                  ),
                  width: 300,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: greenColor,
                          thickness: 1,
                          indent: 3.0,
                          endIndent: 13.0,
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                          fontFamily: "PoppinsMedium",
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: greenColor,
                          thickness: 1,
                          indent: 13.0,
                          endIndent: 3.0,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    _loggingIn ? null : _login;
                    UserCredential? userCredential = await signInWithGoogle();

                    if (userCredential != null) {
                      // Navigasi ke halaman RoomsPage() jika login berhasil
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    } else {
                      // Menampilkan pesan atau tindakan jika login gagal
                      // Contoh: menampilkan snackbar atau dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Google sign-in failed.'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 5.0,
                    ),
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2), // Mengatur posisi bayangan
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/Google.png'),
                              SizedBox(
                                width: 10.0,
                              ),
                              const Text(
                                'Sign in with Google',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 15.0,
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
                SizedBox(
                  height: 25.0,
                ),
                SizedBox(
                  width: 300.0,
                  child: InkWell(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Don’t have an Account ? ',
                        style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 12,
                          color: blackColor,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Create Account',
                            style: TextStyle(
                              fontFamily: "PoppinsBold",
                              fontSize: 14,
                              color: greenOldColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _loggingIn
                                  ? null
                                  : () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
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

  void _login() async {
    // final String documentId;
    FocusScope.of(context).unfocus();

    setState(() {
      _loggingIn = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController!.text,
        password: _passwordController!.text,
      );
      String userId = userCredential.user!.uid;

      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      DocumentSnapshot userSnapshot = await userRef.get();

      String documentId = userSnapshot.id;

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DashboardPage(documentId: documentId),
        ),
      );
    } catch (e) {
      setState(() {
        _loggingIn = false;
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

  void initializeFlutterFire() async {
    // try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //     setState(() {
    //       _user = user;
    //     });
    //   });
    //   setState(() {
    //     _initialized = true;
    //   });
    // } catch (e) {
    //   setState(() {
    //     _error = true;
    //   });
    // }
  }
}
