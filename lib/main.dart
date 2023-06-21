import 'package:example/login.dart';
import 'package:example/service/document_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dashboard.dart';
import 'dashboard.dart';
import 'firebase_options.dart';
import 'main_page.dart';
import 'notification_manager/notification_manager.dart';
import 'utils/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationManager().initNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

final documentIdProvider =
    ChangeNotifierProvider((ref) => DocumentIdProvider());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartStunt',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          String? documentId;

          if (snapshot.hasData) {
            documentId = snapshot.data!.uid;
            // return
            return BottomNavbar(
              documentId: documentId,
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
