import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:io'; // import for httpclient
import 'dart:convert'; // import for utf8 decode

class NetworkRequestDialog extends StatefulWidget {
  @override
  _NetworkRequestDialogState createState() => _NetworkRequestDialogState();
}

class _NetworkRequestDialogState extends State<NetworkRequestDialog> {
  Dio dio = Dio();
  Response response;

  @override
  void initState() {
    requestGoogle();
    super.initState();
  }

  /// 利用 Dio 發出 Request
  void requestGoogle() async =>
      await dio.get("https://www.google.com").then((res) {
        response = res;
        setState(() {});
      });

  /// 利用 HttpClient 發出 Request
  void _requestGoogleUsingHttpClient() async {
    try {
      var httpClient = HttpClient();
      var request =
          await httpClient.getUrl(Uri.parse("https://www.google.com"));
      var response = await request.close();
      var _text = await response.transform(utf8.decoder).join();
      print(_text);
      httpClient.close();
    } catch (e) {
      var _text = "Request Fail : $e";
      print(_text);
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Google Response'),
      titlePadding: EdgeInsets.all(24),
      contentPadding: EdgeInsets.all(16),
      children: <Widget>[
        Center(
          child: Text(response == null
              ? "Loading..."
              : response.data.toString().replaceAll(RegExp(r"\s"), "")),
        ),
        FlatButton(
          color: Theme.of(context).primaryColor,
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
