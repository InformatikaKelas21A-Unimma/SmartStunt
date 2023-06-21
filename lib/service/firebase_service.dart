import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _documentId;

  String? get documentId => _documentId;

  Future<void> login() async {
    // Lakukan proses login menggunakan FirebaseAuth
    // Setelah login berhasil, simpan document ID ke _documentId
    // Misalnya:
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: 'email@example.com',
      password: 'password',
    );
    _documentId = user.user!.uid;
  }

  Future<void> logout() async {
    // Lakukan proses logout menggunakan FirebaseAuth
    // Set _documentId ke null
    await _firebaseAuth.signOut();
    _documentId = null;
  }
}
