import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/login_screen.dart';
import 'package:vacancies_app/utils/snackbar.dart';

class CallApi {
  // static final String url = 'https://gnmcargo.com/cargo/';
  // static final String url = 'http://192.168.100.21:8000/cargo/';
  static const String url = 'http://192.168.100.26:8001/';
  static const String media_url = 'http://68.183.5.97:5000/media/v1/';
  static const String flask_microservice_url = 'http://68.183.5.97:3000/';
  var token = '';

  // ignore: unused_element
  getJWTToken({context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('refresh_token');
    if (token != null) {
      var data = {"refresh": token};
      var res = await http.post(
          Uri.parse(
            '${url}users/auth/token/refresh/',
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        sharedPreferences.setString("token", body['access']);
        token = 'JWT ' + body['access'];
      } else {
        await _navigateHome(context: context);
      }
    } else {
      _navigateHome(context: context);
    }
  }

  _navigateHome({context}) async {
    if (context != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove('token');
      sharedPreferences.remove('refresh_token');
      sharedPreferences.remove('user');
      sharedPreferences.remove('notifications');
      try {
        showSnack(context, 'Unauthorized, please login again');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } catch (e) {}
    }
  }

  _getNormalToken(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token != null) {
      token = 'Token $token';
    } else {
      await _navigateHome(context: context);
    }
  }

  getToken(context) async {
    _getNormalToken(context);
  }

  evaluateResponseData(res, context, {login = false}) {
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 500) {
      //--- Push to a page with 500 status, and code for troubleshoot
      // showSnack(context, AppLocalizations.of(context)!.unauthorized);
      return null;
    } else if (res.statusCode == 400) {
      //--- Push to a page with 500 status, and code for troubleshoot
      // scafold(context, 'Record Not Found');
      return null;
    } else if (res.statusCode == 401) {
      if (login) {
        showSnack(context, 'Invalid OTP');
      } else {
        _navigateHome(context: context);
      }
      return null;
    } else {
      // scafold(context, res.body);
      return null;
    }
  }

  authenticatedPostRequest(data, apiUrl, {context}) async {
    var fullUrl = url + apiUrl;
    await getToken(context);
    try {
      var res = await http.post(
          Uri.parse(
            fullUrl,
          ),
          body: jsonEncode(data),
          headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  authenticatedGetRequest(apiUrl, {context}) async {
    await getToken(context);
    var fullUrl = url + apiUrl;
    print(fullUrl);
    try {
      var res = await http.get(Uri.parse(fullUrl), headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  authenticatedPutRequest(apiUrl, {context, data}) async {
    await getToken(context);
    var fullUrl = url + apiUrl;
    try {
      var res = await http.put(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  authenticatedDeleteRequest(apiUrl, {context}) async {
    await getToken(context);
    var fullUrl = url + apiUrl;
    try {
      var res = await http.delete(Uri.parse(fullUrl), headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  authenticatedUploadRequest(data, apiUrl,
      {context, int? uploaded, State? state, String master_url = ''}) async {
    print(apiUrl);
    var starteUrl = master_url != '' ? master_url : url;
    var fullUrl = starteUrl + apiUrl;
    print(fullUrl);
    await getToken(context);
    try {
      Response res = await Dio()
          .post(fullUrl, data: data, options: Options(headers: _setHeaders()),
              onSendProgress: (int sent, int total) {
        if (state != null) {
          print(sent);
          state.setState(() {
            uploaded = (sent / total * 100).round();
          });
        }
      });
      print(res.data);

      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  authenticatedDownloadRequest(data, apiUrl, {context}) async {
    var fullUrl = url + apiUrl;
    await getToken(context);
    try {
      var res = await http.post(
          Uri.parse(
            fullUrl,
          ),
          body: jsonEncode(data),
          headers: _setHeaders());
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  getRequest(apiUrl, {context}) async {
    var fullUrl = url + apiUrl;
    try {
      var res = await http.get(Uri.parse(fullUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      return evaluateResponseData(res, context);
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  postRequest(data, apiUrl, {context, login = false, evaluate = true}) async {
    var fullUrl = url + apiUrl;
    try {
      var res = await http.post(
          Uri.parse(
            fullUrl,
          ),
          body: jsonEncode(data),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      if (evaluate) {
        return evaluateResponseData(res, context, login: login);
      }
      return res;
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  putRequest(apiUrl, {context}) async {
    var fullUrl = url + apiUrl;
    try {
      return await http.put(Uri.parse(fullUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
    } catch (e) {
      showSnack(context, 'No network');
      return null;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      };
}
