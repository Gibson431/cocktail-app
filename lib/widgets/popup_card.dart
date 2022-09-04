import 'package:flutter/material.dart';
import 'package:cocktail_app/models/cocktail.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CocktailPopupCard extends StatefulWidget {
  final Cocktail data;
  final bool isFavorite;
  const CocktailPopupCard(
      {Key? key, required this.data, required this.isFavorite})
      : super(key: key);

  @override
  State<CocktailPopupCard> createState() => _CocktailPopupCardState();
}

class _CocktailPopupCardState extends State<CocktailPopupCard> {
  late Box<dynamic> favoriteBox;
  late Cocktail data;
  bool isFavorite = false;

  Future<bool> checkFavorite(String id) async {
    dynamic res = favoriteBox.get(id);
    if (res == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    isFavorite = widget.isFavorite;
    favoriteBox = Hive.box('favorites');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoriteBox.listenable(),
        builder: (context, Box<dynamic> box, widget) {
          return SafeArea(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Hero(
                      tag: data.strIdDrink,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(data.strDrink,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.0,
                                                          )),
                                                    ),
                                                    // const Spacer(),
                                                    GestureDetector(
                                                      child: (isFavorite)
                                                          ? Icon(
                                                              Icons.star_rate,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            )
                                                          : const Icon(Icons
                                                              .star_border),
                                                      onTap: () async {
                                                        isFavorite =
                                                            !isFavorite;
                                                        favoriteBox.put(
                                                            data.strIdDrink,
                                                            isFavorite);
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                ),
                                                const Text(
                                                  'Ingredients:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: data
                                                          .lstIngredients
                                                          .cast()
                                                          .map((element) {
                                                        return Text(
                                                            element.name);
                                                      }).toList(),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: data
                                                          .lstIngredients
                                                          .cast()
                                                          .map((e) => Text(
                                                              '${e.volume ?? ''}'))
                                                          .toList(),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 8, 0),
                                            child: ClipRRect(
                                              child: Image.network(
                                                  data.strDrinkThumb),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        )
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        const Text(
                                          "Directions:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(data.strInstructions),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ))),
            ),
          );
        });
  }
}
