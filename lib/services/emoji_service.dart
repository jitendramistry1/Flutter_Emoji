import 'dart:async';
import 'package:flutter_emoji/api/http_api.dart';
import 'package:flutter_emoji/api/response_api.dart';
import 'package:flutter_emoji/utils/api_key_utils.dart';

class EmojiService {
  Future<APIResponse> getEmojis() async {
    try {
      String url = APIKey.baseUrl;

      APIResponse response = await Http().handleHttpRequest<APIResponse>(
        "",
        () async => await Http.get(url, auth: false),
      );
      return response;
    } catch (e) {
      return APIResponse(
        false,
        data: e.toString(),
        message: "An error occurred while attempting to retrieve emojis.",
        severity: ErrorLevel.Connection,
      );
    }
  }
}
