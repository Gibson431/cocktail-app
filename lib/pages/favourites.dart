import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cocktail_app/models/cocktail.dart';
import 'package:cocktail_app/widgets/cocktail_card.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late Box<dynamic> favoriteBox;

  List<Widget> cards = [];

  Future<List<CocktailCard>> getFavoriteCards() async {
    Map all = favoriteBox.toMap();
    List<Cocktail> list = [];

    for (String key in all.keys) {
      if (favoriteBox.get(key) == true) {
        dynamic out = await fetchDrinkById(key);
        if (out is Cocktail) {
          list.add(out);
        }
      }
    }

    List<CocktailCard> cardList =
        list.map((c) => CocktailCard(data: c)).toList();

    return cardList;
  }

  void setup() async {
    cards = await getFavoriteCards();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites');
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoriteBox.listenable(),
        builder: (context, Box<dynamic> box, widget) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favourites'),
              automaticallyImplyLeading: false,
            ),
            body: (cards.isEmpty)
                ? const Center(
                    child: Text('No favorites yet.'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
