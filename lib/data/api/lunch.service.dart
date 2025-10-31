import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex_app/data/models/lunch.model.dart';

class LunchService {

  static final String _baseUrl = 'https://api.spacexdata.com/v4';

  static Future<List<Lunch>> fetchLunchList() async {
    final Uri url = Uri.parse('$_baseUrl/launches');
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Lunch list not available');
    }

    try {
      final List<dynamic> list = json.decode(response.body);
      List<Lunch> res = list.map((dynamic model) => Lunch.fromJson(model)).toList();
      return res;
    } catch (e, s) {
      throw Exception('Lunch list not available');
    }
  }

}