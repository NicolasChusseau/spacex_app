import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex_app/data/models/rocket.model.dart';
import 'package:spacex_app/data/api/api_config.dart';

class RocketService {
  static final String _baseUrl = apiBaseUrl;

  static Future<Rocket> fetchRocket(String id) async {
    final Uri url = Uri.parse('$_baseUrl/rockets/$id');
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Rocket not available');
    }

    try {
      final Map<String, dynamic> map = json.decode(response.body) as Map<String, dynamic>;
      return Rocket.fromJson(map);
    } catch (e) {
      throw Exception('Rocket parsing failed');
    }
  }
}
