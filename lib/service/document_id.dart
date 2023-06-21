import 'package:flutter/material.dart';

class DocumentIdProvider with ChangeNotifier {
  String? _documentId;

  String? get documentId => _documentId;

  void setDocumentId(String? documentId) {
    _documentId = documentId;
    notifyListeners();
  }
}
