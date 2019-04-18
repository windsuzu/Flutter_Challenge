import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'User.dart';
import 'dart:convert'; // import for json decode

class JsonDialog extends StatefulWidget {
  @override
  _JsonDialogState createState() => _JsonDialogState();
}

class _JsonDialogState extends State<JsonDialog> {
  Dio dio = Dio();
  User user;

  @override
  void initState() {
    _getJsonObject().then((val) {
      user = val;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Center(
          child: user == null
              ? Text('Loading...')
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: CircleAvatar(
                        radius: 28,
                        child: Text(
                          user.username[0],
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        backgroundColor: Colors.greenAccent,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                      ),
                      _createUserInfo('User ID', user.id),
                      _createUserInfo('Username', user.username),
                      _createUserInfo('Name', user.name),
                      _createUserInfo('E-mail', user.email),
                      _createUserInfo('Company', user.company.name),
                      _createUserInfo('Address', user.address.city),
                      _createUserInfo('Phone', user.phone),
                      _createUserInfo('Website', user.website),
                    ],
                  ),
                ),
        )
      ],
    );
  }

  /// 取得 Json Object 並解析
  Future<User> _getJsonObject() async {
    // decode a jsonObject
    var response =
        await dio.get('https://jsonplaceholder.typicode.com/users/1');
    Map jsonUserMap = json.decode(response.toString());
    user = User.fromJsonMap(jsonUserMap);
    print(user.name);
    return user;
  }

  /// 取得 Json Array 並解析
  Future<List<User>> _getJsonArray() async {
    // decode a jsonArray
    var userList = List<User>();
    var response2 = await dio.get('https://jsonplaceholder.typicode.com/users');
    String res2Json =
        jsonEncode(response2.data); // 因為沒有雙引號 (BUG) ， 所以需要先強制轉回 json
    List jsonArray = jsonDecode(res2Json); // 再進行 Decode
    userList.addAll(jsonArray.map((obj) => User.fromJsonMap(obj)));
    userList.forEach((user) => print(user.name));
    return userList;
  }

  Widget _createUserInfo(String title, dynamic content) {
    return RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
          TextSpan(
              text: ' $content',
              style: TextStyle(fontSize: 18, color: Colors.blue))
        ]));
  }
}
