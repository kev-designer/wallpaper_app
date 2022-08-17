import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/search_model.dart';
import 'package:wallpaper_app/models/tranding_model.dart';

//TRENDING API SERVICES
class TrendyApiServices {
  String apiKey = "563492ad6f9170000100000187066e6fcd7041489f68b66f7480732b";
  Future<TrendyModel> getTrendyWallpaperApi() async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=1"),
      headers: {"Authorization": apiKey},
    );

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return TrendyModel.fromJson(data);
    } else {
      throw Exception("Fetching World API Error");
    }
  }
}

//SEARCH API SERVICES
class SearchApiServices {
  String apiKey = "563492ad6f9170000100000187066e6fcd7041489f68b66f7480732b";
  Future<SearchModel> getSearchWallpaperApi(String query) async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80"),
      headers: {"Authorization": apiKey},
    );

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return SearchModel.fromJson(data);
    } else {
      throw Exception("Fetching World API Error");
    }
  }
}
