import 'package:flutter/cupertino.dart';
import 'package:flutter_application_homework/classes/ingredient.dart';
import 'package:flutter_application_homework/classes/recipe.dart';
import 'package:flutter_application_homework/utilities/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeProvider extends ChangeNotifier {
  late List<Recipe> _recipes = [];
  late List<String> _tags = [];
  bool nightMode = false;

  List<Recipe> get recipes => _recipes.toList();

  void refreshTags(List<String> tags) {
    _tags = tags;
  }

  Future<void> getData() async {
    _recipes = [];

    try {
      var ingredients = concatenate();
      var response = await http.get(Uri.parse(
          "https://api.spoonacular.com/recipes/findByIngredients?ingredients=$ingredients&number=5&apiKey=$apiKey1"));
      var data = await json.decode(response.body);

      await recipeFill(data);
    } catch (err) {
      throw err.toString();
    }
  }

  void removeRecipe(Recipe recipe) {
    _recipes.remove(recipe);

    notifyListeners();
  }

  String concatenate() {
    if (_tags.isEmpty) return "water,salt,sugar";

    return _tags.join(",");
  }

  Future<String> getVideo(String recipeName) async {
    String temp = recipeName.replaceAll(" ", "%20") + "%20recipe";
    String _url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$temp&type=video&key=$apiKey2';

    try {
      var response = await http.get(Uri.parse(_url));
      var data = await json.decode(response.body);
      var returnString = "dQw4w9WgXcQ";
      try {
        returnString = data["items"][0]["id"]["videoId"];
      } catch (err) {
        throw err.toString();
      }
      return returnString;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> recipeFill(List<dynamic> data) async {
    for (int i = 0; i < data.length; i++) {
      var rec = data[i];
      List<Ingredient> used = [];
      List<Ingredient> missed = [];
      for (int j = 0; j < rec["usedIngredients"].length; j++) {
        var temp1 = rec["usedIngredients"][j];
        Ingredient ing1 = Ingredient(
            temp1["name"], temp1["unit"], temp1["amount"].toString());
        used.add(ing1);
      }
      for (int j = 0; j < rec["missedIngredients"].length; j++) {
        var temp2 = rec["missedIngredients"][j];
        Ingredient ing2 = Ingredient(
            temp2["name"], temp2["unit"], temp2["amount"].toString());
        missed.add(ing2);
      }
      String s = await getVideo(rec["title"]);
      Recipe r = Recipe(rec["title"], used, missed, s);
      _recipes.add(r);
    }
  }
}
