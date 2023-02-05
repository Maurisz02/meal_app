import 'package:flutter/material.dart';

import '../screens/categories_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;
  final String title;

  CategoryItem(this.id, this.color, this.title);

  void selectCategory(BuildContext context) {
    /*Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoriesMealScreen(title, id);
        },
      ),
    );*/
    Navigator.of(context).pushNamed(
      CategoriesMealScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
