import 'package:flutter/material.dart';
import 'package:flutter_application_homework/classes/recipe_provider.dart';
import 'package:flutter_application_homework/widgets/flutter_tag_view.dart';
import 'package:provider/provider.dart';

class Fridge extends StatefulWidget {
  const Fridge({Key? key}) : super(key: key);

  @override
  _FridgeState createState() => _FridgeState();
}

class _FridgeState extends State<Fridge> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);
    return Scaffold(
      backgroundColor: provider.nightMode
          ? const Color.fromRGBO(68, 68, 68, 1)
          : const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Add your ingredients",
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
                      "https://images.unsplash.com/photo-1533841175647-39fea57b86ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
              minWidth: 300,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const TagView(),
            )),
      ),
    );
  }
}
