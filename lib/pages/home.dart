import 'package:flutter/material.dart';
import 'package:cocktail_app/models/cocktail.dart';
import 'package:cocktail_app/widgets/cocktail_card.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const Map routes = {'home': 0, 'search': 1, 'favourites': 2};

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<String> routes = ['/home', '/search', '/favourites'];

  List<CocktailCard> cards = [];

  void setup() async {
    List<dynamic> list = await fetchDrinksByFirstLetter('a');
    if (mounted) {
      setState(() {
        cards = list
            .map((c) => CocktailCard(
                  key: Key(c.strIdDrink),
                  data: c,
                ))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('favorites').listenable(),
        builder: (context, box, widget) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 5,
              ),
            ),
          );
        });
  }
}
