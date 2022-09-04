import 'package:flutter/material.dart';
import 'package:cocktail_app/models/cocktail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cocktail_app/hero_dialog_route.dart';
import 'popup_card.dart';

class CocktailCard extends StatefulWidget {
  final Cocktail data;
  const CocktailCard({Key? key, required this.data}) : super(key: key);

  @override
  State<CocktailCard> createState() => _CocktailCardState();
}

class _CocktailCardState extends State<CocktailCard> {
  late Box<dynamic> favoriteBox;
  // late Box<dynamic> ingredientsBox;
  late Cocktail data;

  bool isFavorite = false;

  Future<bool> checkFavorite(String id) async {
    dynamic res = favoriteBox.get(id);
    if (res == null) {
      return false;
    }
    if (res is bool) return false;
    if (res.isFavorite == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    // ingredientsBox = Hive.box('ingredients');
    favoriteBox = Hive.box('favorites');
    checkFavorite(widget.data.strIdDrink).then((b) {
      setState(() {
        data.isFavorite = b;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoriteBox.listenable(),
        builder: (context, Box<dynamic> box, widget) {
          return GestureDetector(
            onTap: (() {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return CocktailPopupCard(
                  data: data,
                  isFavorite: data.isFavorite,
                );
              })).then((_) async {
                data.isFavorite = await checkFavorite(data.strIdDrink);
                setState(() {});
              });
            }),
            child: Hero(
                tag: data.strIdDrink,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.strDrink,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    // const Spacer(),
                                    GestureDetector(
                                      child: (data.isFavorite)
                                          ? Icon(
                                              Icons.star_rate,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            )
                                          : const Icon(Icons.star_border),
                                      onTap: () async {
                                        data.isFavorite = !data.isFavorite;
                                        if (data.isFavorite) {
                                          await favoriteBox.put(
                                              data.strIdDrink, data);
                                        } else {
                                          await favoriteBox.delete(data.strIdDrink);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                  endIndent: 8,
                                ),
                                Text('Main Spirit: ${data.strMainIngredient}'),
                                const Divider(
                                  thickness: 1,
                                  endIndent: 8,
                                ),
                                const Text('Ingredients:'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: data.lstIngredients
                                      .cast()
                                      .map((e) => Text('- ${e.name}'))
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: ClipRRect(
                                child: Image.network(data.strDrinkThumb),
                                borderRadius: BorderRadius.circular(8),
                              ))
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }
}
