import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model.dart';

class Repository {
  final _baseUrl = 'https://64761861e607ba4797dd4a57.mockapi.io/data/';

  Future getData() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
      );
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Post> post = it.map((e) => Post.fromJson(e)).toList();
        return post;
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
