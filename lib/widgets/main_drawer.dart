import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget listTileBuilder(String text, IconData icon, Function tapHandler) {
    return ListTile(
      onTap: tapHandler,
      leading: Icon(
        icon,
        size: 26,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.yellow,
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appBarTheme.color,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          listTileBuilder(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          SizedBox(
            height: 20,
          ),
          listTileBuilder(
            'Filters',
            Icons.settings,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
