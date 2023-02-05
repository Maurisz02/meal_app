import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = '/categories-meal';

  final List<Meal> availableMeal;

  CategoriesMealScreen(this.availableMeal);

  @override
  State<CategoriesMealScreen> createState() {
    return CategoriesMealScreenState();
  }
}

class CategoriesMealScreenState extends State<CategoriesMealScreen> {
  //final String title;
  //final String id;

  //CategoriesMealScreen(this.title, this.id);
  var _loadedInitData = false;
  String title;
  List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      title = routeArgs['title'];
      final id = routeArgs['id'];

      categoryMeals = widget.availableMeal.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      _loadedInitData = true;
    }
  }

  void removeItem(String mealId) {
    setState(() {
      return categoryMeals.removeWhere((meal) {
        //((meal) => meal.id == mealId)) same but shorter with one argument
        return meal.id == mealId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
            //removeItem: removeItem,
          );
        }),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
