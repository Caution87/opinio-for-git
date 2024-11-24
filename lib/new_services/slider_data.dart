// ignore_for_file: unused_import

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:opinio/Models/slider_model.dart';
import 'package:intl/intl.dart';

//639d10116c964e13acf705f1d3235f69
class Sliders {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String url =
        "https://newsapi.org/v2/everything?q=technology&from=2024-11-01&sortBy=publishedAt&apiKey=9b2792d524184decaedecf873d289986";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    
    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          SliderModel slidermodel = SliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(slidermodel);
        }
      });
    }
  }
}

class SliderModel {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? content;
  final String? author;
  SliderModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.author,
  });
}
