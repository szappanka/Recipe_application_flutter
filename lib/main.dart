import 'package:flutter/material.dart';
import 'package:flutter_application_homework/classes/recipe_provider.dart';
import 'package:flutter_application_homework/pages/recipes.dart';
import 'package:flutter_application_homework/pages/fridge.dart';
import 'package:flutter_application_homework/pages/loading.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => RecipeProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const Loading(),
            '/recipes': (context) => const Recipes(),
            '/fridge': (context) => const Fridge(),
          },
        ),
      ),
    );
