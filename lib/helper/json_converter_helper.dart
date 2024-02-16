import 'package:flutter/services.dart';

class JsonConverterHelper {
  //Function to load Emojies from assets
  Future<String> loadJson(String json) async {
    return await rootBundle.loadString(json);
  }
}
