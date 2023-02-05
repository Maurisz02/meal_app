import 'package:flutter/material.dart';

import './screens/categories_meal_screen.dart';
//import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filter_screen.dart';
import './screens/tabs_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _saveFilter(Map<String, bool> filter) {
    setState(() {
      _filters = filter;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id) {
    final existingIndex = _favoriteMeal.indexWhere((meal) =>
        meal.id ==
        id); //ha nincs bene -1 et returnol ha bennevan megkeresi az id je megkeresi az indexet az id nek azaz az aktuális kajanak
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeal
            .add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoriteMeal.any((element) => id == element.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meal App",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.green,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          color: Colors.redAccent,
          titleTextStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      //home: CategoriesScreen(),ugyan az mint a routing nál a /
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteMeal),
        CategoriesMealScreen.routeName: (context) =>
            CategoriesMealScreen(_availableMeal),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FilterScreen.routeName: (context) =>
            FilterScreen(_filters, _saveFilter),
      },
      /*onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) =>
                CategoriesScreen()); //ha nem talál semmilyen megfelelo utvonalat ezt tölti be
      },*/
    );
  }
}
