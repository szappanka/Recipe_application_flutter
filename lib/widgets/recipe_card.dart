import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_homework/classes/recipe.dart';
import 'package:flutter_application_homework/classes/recipe_provider.dart';
import 'package:flutter_application_homework/widgets/youtube_player.dart';
import 'package:provider/provider.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    return Card(
      color: provider.nightMode
          ? const Color.fromRGBO(68, 68, 68, 1)
          : const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
            iconColor: const Color.fromRGBO(206, 158, 121, 1),
            title: Center(
                child: Text(
              recipe.title[0].toUpperCase() + recipe.title.substring(1),
              style: TextStyle(
                color: provider.nightMode
                    ? const Color.fromRGBO(206, 158, 121, 1)
                    : Colors.black,
              ),
            )),
            children: [
              const Text(
                "Available ingredients:",
                style: TextStyle(color: Color.fromRGBO(206, 158, 121, 1)),
              ),
              Column(
                children: (recipe.usedIngredients.isNotEmpty)
                    ? recipe.usedIngredients
                        .map((e) => Text("${e.amount} ${e.unit} of ${e.name}",
                            style: TextStyle(
                              color: provider.nightMode
                                  ? Colors.white
                                  : Colors.black,
                            )))
                        .toList()
                    : [
                        Text("-",
                            style: TextStyle(
                              color: provider.nightMode
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
              ),
              const Text(
                "Missed ingredients:",
                style: TextStyle(color: Color.fromRGBO(206, 158, 121, 1)),
              ),
              Column(
                children: (recipe.missedIngredients.isNotEmpty)
                    ? recipe.missedIngredients
                        .map((e) => Text("${e.amount} ${e.unit} of ${e.name}",
                            style: TextStyle(
                              color: provider.nightMode
                                  ? Colors.white
                                  : Colors.black,
                            )))
                        .toList()
                    : [
                        Text("-",
                            style: TextStyle(
                              color: provider.nightMode
                                  ? Colors.white
                                  : Colors.black,
                            ))
                      ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: SizedBox(
                  height: 200,
                  child: YoutubePlayer(url: recipe.ytUrl),
                ),
              )
            ]),
      ),
    );
  }
}
