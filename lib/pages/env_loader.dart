import 'dart:convert';
import 'package:flutter/services.dart';

class Env {
  static Map<String, dynamic>? _config;

  static Future<void> load() async {
    final String response = await rootBundle.loadString('env.json');
    _config = json.decode(response);
  }

  static String? get apiKey => _config?['api_key'];
}
