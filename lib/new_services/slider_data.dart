import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:opinio/Models/slider_model.dart';

//639d10116c964e13acf705f1d3235f69
class Sliders {
  List<sliderModel> sliders = [];

  Future<void> getSlider() async {
    String url =
        "https://newsapi.org/v2/everything?q=technology&from=2024-11-01&sortBy=publishedAt&apiKey=9b2792d524184decaedecf873d289986";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          sliderModel slidermodel = sliderModel(
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
