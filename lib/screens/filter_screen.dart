import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final Function saveFilter;
  final Map<String, bool> currentFilter;

  FilterScreen(this.currentFilter, this.saveFilter);

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilter['gluten'];
    _isLactoseFree = widget.currentFilter['lactose'];
    _isVegan = widget.currentFilter['vegan'];
    _isVegetarian = widget.currentFilter['vegetarian'];
  }

  Widget _buildSwitchListTile(
    String title,
    String subTitle,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilter = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
              };
              widget.saveFilter(selectedFilter);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal settings",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    'Gluten-free',
                    'Only include gluten-free meals',
                    _isGlutenFree, (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    _isLactoseFree, (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include vegan meals', _isVegan, (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }),
                _buildSwitchListTile('Vegetarian',
                    'Only include vegetarian meals', _isVegetarian, (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
