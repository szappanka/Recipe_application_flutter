import 'package:flutter/material.dart';
import 'package:flutter_application_homework/classes/recipe_provider.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';

List<String> _items = [];
double _fontSize = 14;

class TagView extends StatefulWidget {
  const TagView({Key? key}) : super(key: key);

  @override
  _FridgeState createState() => _FridgeState();
}

class _FridgeState extends State<TagView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    return Tags(
      textField: TagsTextField(
        width: MediaQuery.of(context).size.width,
        hintTextColor: provider.nightMode
            ? const Color.fromRGBO(250, 250, 250, 0.6)
            : const Color.fromRGBO(60, 60, 60, 1),
        hintText: "Add an ingredient",
        textStyle: TextStyle(
            fontSize: _fontSize,
            color: provider.nightMode ? Colors.white : Colors.black),
        onSubmitted: (String str) {
          setState(() {
            _items.add(str);
            provider.refreshTags(_items);
          });
        },
      ),
      itemCount: _items.length,
      itemBuilder: (int index) {
        final item = _items[index];

        return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            textStyle: TextStyle(
              fontSize: _fontSize,
            ),
            combine: ItemTagsCombine.withTextBefore,
            activeColor: const Color.fromRGBO(28, 28, 40, 0.9),
            color: const Color.fromRGBO(91, 137, 216, 1),
            removeButton: ItemTagsRemoveButton(
              onRemoved: () {
                setState(() {
                  _items.removeAt(index);
                  provider.refreshTags(_items);
                });
                return true;
              },
            ));
      },
    );
  }
}
