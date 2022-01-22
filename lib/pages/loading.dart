import 'package:flutter/material.dart';
import 'package:flutter_application_homework/classes/recipe_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String string = "Loading screen";

  void setupAPI() async {
    final provider = Provider.of<RecipeProvider>(context);
    await provider.getData();
    Navigator.pushReplacementNamed(context, "/recipes");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setupAPI();
    return const Scaffold(
      backgroundColor: Color.fromRGBO(206, 158, 121, 1),
      body: Center(
          child: SpinKitChasingDots(
        color: Colors.white,
        size: 50.0,
      )),
    );
  }
}
