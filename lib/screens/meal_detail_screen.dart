import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail-screen";

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Colors.orange.shade200,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${index + 1}'),
                            ),
                            title: Text(selectedMeal.steps[index]),
                          ),
                          Divider(
                            thickness: 5,
                            color: Colors.green,
                          ),
                        ],
                      ),
                  itemCount: selectedMeal.steps.length),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFavorite(mealId);
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        child: isFavorite(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
      ),
    );
  }
}
