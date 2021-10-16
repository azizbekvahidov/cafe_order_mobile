import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../globals.dart' as globals;

class NetworkService {
  final JsonDecoder _decoder = const JsonDecoder();
  final JsonEncoder _encoder = const JsonEncoder();

  Map<String, String> headers = globals.headers;
  Map<String, String> cookies = {};

  void _updateCookie(http.Response response) {
    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
      globals.headers = headers;
    }
  }

  void _setCookie(String? rawCookie) {
    if (rawCookie != null) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      cookie += key + "=" + cookies[key]!;
    }

    return cookie;
  }

  Future<dynamic> get(String url, {String token = ""}) {
    if (token != "") {
      headers.addAll({"Authorization": "token $token"});
    }
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    return ioClient
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      _updateCookie(response);
      return response;
    });
  }

  Future<dynamic> post(String url, {body, encoding, token = ""}) {
    if (token != "") {
      headers.addAll({"Authorization": "token $token"});
    }
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    return ioClient
        .post(Uri.parse(url),
            body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      _updateCookie(response);

      return response;
    });
  }

  Future<dynamic> put(String url, {body, encoding, token = ""}) {
    if (token != "") {
      headers.addAll({"Authorization": "token $token"});
    }
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(httpClient);
    return ioClient
        .put(Uri.parse(url),
            body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      _updateCookie(response);
      return response;
    });
  }
}
