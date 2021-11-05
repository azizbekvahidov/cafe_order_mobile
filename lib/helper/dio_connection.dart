import 'package:requests/requests.dart';
import '../config/globals.dart' as globals;

class DioConnection {
  // getHttp(url, state, headers) async {
  //   try {
  //     var response;
  //     url = '${globals.api_link}$url';
  //     Dio dio = new Dio();
  //     dio.options.baseUrl = url;
  //     // dio.options.headers = headers;
  //     dio.options.connectTimeout = 5000;
  //     dio.options.receiveTimeout = 3000;

  //     response = await dio.get(url);

  //     globals.isServerConnection = true;
  //     state.setState(() {});
  //     return response;
  //   } catch (e) {
  //     globals.isServerConnection = false;
  //     state.setState(() {});
  //     // return e;
  //   }
  // }

  getHttp(url, state, headers) async {
    try {
      var res = {};
      url = '${globals.apiLink}/$url';
      var response = await Requests.get(url, headers: headers);

      globals.isServerConnection = true;
      state.setState(() {});
      res = {"statusCode": response.statusCode, "result": response.json()};
      return res;
    } catch (e) {
      print(e);
      globals.isServerConnection = false;
      state.setState(() {});
      // return e;
    }
  }

  postHttp(url, state, headers, data) async {
    try {
      var res = {};
      url = '${globals.apiLink}/$url';
      var response = await Requests.post(url,
          headers: headers, body: data, bodyEncoding: RequestBodyEncoding.JSON);

      globals.isServerConnection = true;
      state.setState(() {});
      res = {
        "statusCode": response.statusCode,
        "result": response.content() != "" ? response.json() : ""
      };
      return res;
    } catch (e) {
      print(e);
      globals.isServerConnection = false;
      state.setState(() {});
      // return e;
    }
  }

  postCoockieHttp(url, state, headers, data) async {
    try {
      var res = {};
      url = '${globals.apiLink}/$url';
      var response = await Requests.post(url,
          headers: headers, body: data, persistCookies: true, verify: false);

      globals.isServerConnection = true;
      state.setState(() {});
      res = {"statusCode": response.statusCode, "result": response.json()};
      return res;
    } catch (e) {
      print(e);
      globals.isServerConnection = false;
      state.setState(() {});
      // return e;
    }
  }
}
