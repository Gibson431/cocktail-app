import 'package:cocktail_app/models/adapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setup() async {
    // await Future.delayed(const Duration(milliseconds: 200), () {});
    // await Hive.openBox('settings');
    Hive.registerAdapter(IngredientAdapter());
    Hive.registerAdapter(CocktailAdapter());
    await Hive.openBox('favorites');
    await Hive.openBox('persistent-cache');
    await Hive.openBox('ingredients');
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
