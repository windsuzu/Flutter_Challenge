import 'package:flutter/material.dart';
import 'package:flutter_challenge/PathProvider/PathRoute.dart';
import 'package:flutter_challenge/Layout/LayoutRoute.dart';
import 'package:flutter_challenge/Scrollable/ScrollableRoute.dart';
import 'package:flutter_challenge/Functional/FunctionalRoute.dart';
import 'package:flutter_challenge/Animation/AnimationRoute.dart';
import 'package:flutter_challenge/Customization/CustomizationRoute.dart';
import 'package:flutter_challenge/Network/NetworkRoute.dart';
import 'generated/i18n.dart';
import 'Functional/EventBusRoute.dart' show EventBus;

class HomePage extends StatefulWidget {
  final _appBarTitle;

  HomePage(this._appBarTitle);

  @override
  _HomePageState createState() => _HomePageState(_appBarTitle);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this._appBarTitle);

  int currentIndex = 0;
  String _appBarTitle;
  Widget _scaffoldBody = PathRoute();
  EventBus bus = EventBus();

  @override
  Widget build(BuildContext context) {
    changeScaffold(currentIndex);
    final theme =
        ThemeData(brightness: Brightness.light, primaryColor: Colors.white);
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.category),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          title: Text(_appBarTitle),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.translate),
              onPressed: () {
                bus.emit('language', '');
              },
            )
          ],
        ),
        drawer: MyDrawer(onItemSelected: (index) {
          currentIndex = index;
          changeScaffold(index);
          setState(() {});
        }),
        body: _scaffoldBody,
      ),
    );
  }

  void changeScaffold(int index) {
    switch (index) {
      case 0:
        _scaffoldBody = PathRoute();
        _appBarTitle = S.of(context).tap_counter;
        break;
      case 1:
        _scaffoldBody = LayoutRoute();
        _appBarTitle = S.of(context).layout_challenge;
        break;
      case 2:
        _scaffoldBody = ScrollableRoute();
        _appBarTitle = S.of(context).scrollable;
        break;
      case 3:
        _scaffoldBody = FunctionalRoute();
        _appBarTitle = S.of(context).functional;
        break;
      case 4:
        _scaffoldBody = AnimationRoute();
        _appBarTitle = S.of(context).animation;
        break;
      case 5:
        _scaffoldBody = CustomizationRoute();
        _appBarTitle = S.of(context).customization;
        break;
      case 6:
        _scaffoldBody = NetworkRoute();
        _appBarTitle = S.of(context).network;
        break;
    }
  }
}

class MyDrawer extends StatelessWidget {
  final Function onItemSelected;

  const MyDrawer({Key key, this.onItemSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            curve: Curves.fastOutSlowIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).my_challenge,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Expanded(
                    child: CircleAvatar(
                  child: Text(
                    'J',
                    style: TextStyle(fontSize: 24),
                  ),
                  backgroundColor: Colors.white,
                  radius: 28,
                ))
              ],
            ),
            decoration: BoxDecoration(color: Colors.grey),
          ),
          _createListTile(context, S.of(context).tap_counter, 0),
          _createListTile(context, S.of(context).layout_challenge, 1),
          _createListTile(context, S.of(context).scrollable, 2),
          _createListTile(context, S.of(context).functional, 3),
          _createListTile(context, S.of(context).animation, 4),
          _createListTile(context, S.of(context).customization, 5),
          _createListTile(context, S.of(context).network, 6),
        ],
      ),
    );
  }

  Widget _createListTile(BuildContext context, String title, int index) {
    return ListTile(
        title: Text(title),
        onTap: () {
          onItemSelected(index);
          Navigator.of(context).pop();
        });
  }
}
