import 'dart:async';
import 'dart:convert';
import 'package:flutter_emoji/api/response_api.dart';
import 'package:flutter_emoji/main.dart';
import 'package:flutter_emoji/utils/sharedpreferences_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Http {
  //
  Future<APIResponse> handleHttpRequest<T>(
    String defaultErrorMessage,
    Future<http.Response> Function() requestFunction, {
    Duration timeoutDuration = const Duration(seconds: 30),
  }) async {
    try {
      final response = await requestFunction().timeout(timeoutDuration);

      return response.process(defaultErrorMessage);
    } on TimeoutException catch (e) {
      return APIResponse(
        false,
        data: e.toString(),
        message: "Server Timeout",
        severity: ErrorLevel.Connection,
      );
    } on SocketException catch (e) {
      return APIResponse(
        false,
        data: e.toString(),
        message: "No Internet connection",
        severity: ErrorLevel.Connection,
      );
    } on Error catch (e) {
      return APIResponse(
        false,
        data: e.toString(),
        message: "Something went wrong please try again.",
        severity: ErrorLevel.Connection,
      );
    }
  }

  static final _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  static Future<http.Response> post(
    String url,
    dynamic body, {
    bool auth = true,
    Map<String, String> headers = const {},
  }) async {
    return http.post(
      Uri.tryParse(url)!,
      headers: _getHeaders(auth)..addAll(headers),
      body: json.encode(body),
    );
  }

  static Future<http.Response> multipart(
    http.MultipartRequest request, {
    bool auth = true,
  }) async {
    request.headers.addAll(_getHeaders(auth));
    return http.Response.fromStream(await request.send());
  }

  static Future<http.Response> put(
    String url,
    dynamic body, {
    bool auth = true,
    Map<String, String> headers = const {},
  }) async {
    return http.put(
      Uri.tryParse(url)!,
      headers: _getHeaders(auth)..addAll(headers),
      body: json.encode(body),
    );
  }

  static Future<http.Response> patch(
    String url,
    dynamic body, {
    bool auth = true,
    Map<String, String> headers = const {},
  }) async {
    return http.patch(
      Uri.tryParse(url)!,
      headers: _getHeaders(auth)..addAll(headers),
      body: json.encode(body),
    );
  }

  static Future<http.Response> get(
    String url, {
    bool auth = true,
    Map<String, String> headers = const {},
  }) {
    return http.get(
      Uri.tryParse(url)!,
      headers: _getHeaders(auth)..addAll(headers),
    );
  }

  static Future<http.Response> delete(
    String url, {
    bool auth = true,
    Map<String, String> headers = const {},
  }) {
    return http.delete(
      Uri.tryParse(url)!,
      headers: _getHeaders(auth)..addAll(headers),
    );
  }

  static Map<String, String> _getHeaders(bool withAuth) {
    String token = prefs!.getString(Local.token) ?? "";
    if (withAuth) {
      return _headers
        ..addAll({
          "Authorization": "Bearer $token",
        });
    } else {
      return _headers;
    }
  }
}
