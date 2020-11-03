import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombre/Constants/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  double _eventIconSize = 40;
  double _addIconSize = 24;
  double _favIconSize = 24;
  double _searchIconSize = 24;

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
    switch (index) {
      case 0:
        setState(() {
          _eventIconSize = 40;
          _addIconSize = 24;
          _favIconSize = 24;
          _searchIconSize = 24;
        });
        break;
      case 1:
        setState(() {
          _eventIconSize = 24;
          _addIconSize = 40;
          _favIconSize = 24;
          _searchIconSize = 24;
        });
        break;

      case 2:
        setState(() {
          _eventIconSize = 24;
          _addIconSize = 24;
          _favIconSize = 40;
          _searchIconSize = 24;
        });
        break;
      case 3:
        setState(() {
          _eventIconSize = 24;
          _addIconSize = 24;
          _favIconSize = 24;
          _searchIconSize = 40;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: scaffoldBgColor,
      bottomNavigationBar: CurvedNavigationBar(
          index: _index,
          animationDuration: Duration(milliseconds: 200),
          height: MediaQuery.of(context).size.height * 0.09,
          buttonBackgroundColor: selectedIconBgColor,
          color: bottomNavigationBgColor,
          backgroundColor: scaffoldBgColor,
          animationCurve: Curves.bounceInOut,
          items: [
            Icon(
              Icons.event,
              size: _eventIconSize,
            ),
            Icon(
              Icons.add,
              size: _addIconSize,
            ),
            Icon(
              Icons.favorite,
              size: _favIconSize,
            ),
            Icon(
              Icons.search,
              size: _searchIconSize,
            )
          ],
          onTap: (index) {
            _onTap(index);
          }),
      body: screens[_index],
    );
  }
}
