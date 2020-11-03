import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombre/Screens/search_screen.dart';

final Color bottomNavigationBgColor = Color(0xff263240);
final Color scaffoldBgColor = Color(0xff0d111a);
final Color searchBgColor = Color(0xff263240);
final Color selectedIconBgColor = Color(0xfffd4e79);
final Color unselectedBgColor = Colors.white;

List<Widget> screens = [
    Center(child: Text('Events')),
    Center(child: Text('Add')),
    Center(child: Text('Fav')),
    SearchScreen()
  ];

final String EVENTS_COLLECTION = 'Events';
