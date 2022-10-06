import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nf_tugas_public_api/models/user.dart';

class ApiRepository {
  static const bASEURL = 'https://random-data-api.com/api/v2/users';

  getUser() async {
    try {
      final url = Uri.parse(bASEURL);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return User.fromJson(data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
