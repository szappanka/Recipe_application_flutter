import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_application_homework/classes/recipe_provider.dart';
import 'package:flutter_application_homework/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    final recipes = provider.recipes;

    return Scaffold(
      backgroundColor: provider.nightMode
          ? const Color.fromRGBO(68, 68, 68, 1)
          : const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Switch(
              value: provider.nightMode,
              onChanged: (value) {
                setState(() {
                  provider.nightMode = value;
                });
              },
              activeColor: const Color.fromRGBO(40, 40, 40, 1),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          "Recipes",
          style: TextStyle(fontWeight: FontWeight.bold, shadows: [
            Shadow(
              blurRadius: 3.0,
              color: Colors.black.withOpacity(1.0),
            )
          ]),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1466637574441-749b8f19452f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500,
            minWidth: 300,
          ),
          child: ListView(
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/fridge');
                  },
                  icon: Icon(
                    Icons.kitchen,
                    color: provider.nightMode ? Colors.white : Colors.black,
                    size: 50,
                  ),
                  label: Text(
                    "What is in your fridge?",
                    style: TextStyle(
                      color: provider.nightMode ? Colors.white : Colors.black,
                    ),
                  )),
              Flex(
                direction: Axis.vertical,
                children: recipes.map((e) => RecipeCard(recipe: e)).toList(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(206, 158, 121, 1),
        child: const Icon(Icons.refresh, color: Colors.white),
        onPressed: () async {
          await provider.getData();
          setState(() {});
        },
      ),
    );
  }
}
