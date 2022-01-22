import 'package:flutter_application_homework/classes/ingredient.dart';

class Recipe {
  late String title;
  late List<Ingredient> usedIngredients;
  late List<Ingredient> missedIngredients;
  late String ytUrl;

  Recipe(String t, List<Ingredient> u, List<Ingredient> m, String url) {
    title = t;
    usedIngredients = u;
    missedIngredients = m;
    ytUrl = url;
  }

  @override
  String toString() {
    return "$title\nUsed:$usedIngredients\nMissed:$missedIngredients,";
  }
}
