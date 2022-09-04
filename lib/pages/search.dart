import 'package:cocktail_app/models/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_app/widgets/cocktail_card.dart';
// import 'package:cocktail_app/models/custom_widgets.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Widget> cards = [];

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
                customSearchBar = ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                  title: TextField(
                    onSubmitted: (value) {
                      customIcon = const Icon(Icons.search);
                      customSearchBar = const Text('Search');
                      fetchDrinksByName(value).then((cocktails) {
                        setState(() {
                          cards = cocktails
                              .map((c) => CocktailCard(
                                    data: c,
                                  ))
                              .toList();
                        });
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'type in cocktail name...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                customIcon = const Icon(Icons.search);
                customSearchBar = const Text('Search');
              }
              setState(() {});
            },
            icon: customIcon,
          )
        ],
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: (cards.isNotEmpty)
              ? cards
              : [
                  const Text("No cocktails found\n"
                      "Please try searching for something else.")
                ],
        ),
      ),
    );
  }
}
