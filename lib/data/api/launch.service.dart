import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex_app/data/models/launch.model.dart';

class LaunchService {

  static final String _baseUrl = 'https://api.spacexdata.com/v4';

  static Future<List<Launch>> fetchLaunchList() async {
    final Uri url = Uri.parse('$_baseUrl/launches');
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Launch list not available');
    }

    try {
      final List<dynamic> list = json.decode(response.body);
      List<Launch> res = list.map((dynamic model) => Launch.fromJson(model)).toList();
      return res;
    } catch (e) {
      throw Exception('Launch list not available');
    }
  }

}