// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:cocktail_app/hero_dialog_route.dart';
import 'dart:convert';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Ingredient extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? volume;

  Ingredient.hive(this.name);
  Ingredient(this.name, this.volume);
}

@HiveType(typeId: 1)
class Cocktail extends HiveObject {
  @HiveField(0)
  String strIdDrink = 'null';
  @HiveField(1)
  String strDrink = "null";
  @HiveField(2)
  String strDrinkThumb = "null";
  @HiveField(3)
  String strInstructions = "null";
  @HiveField(4)
  String strMainIngredient = "null";
  @HiveField(5)
  bool isFavorite = false;

  @HiveField(6)
  late HiveList lstIngredients;

  void fillIngredients(json) async {
    strMainIngredient = json['strIngredient1'];
    var ingredients = Hive.box('ingredients');
    lstIngredients = HiveList(ingredients);
    for (int i = 1; json['strIngredient$i'] != null && i <= 15; i++) {
      Ingredient newI =
          Ingredient(json['strIngredient$i'], json['strMeasure$i']);

      ingredients.put(newI.name, newI);
      lstIngredients.add(newI);
    }
    //this.save();
  }

  Cocktail.hive(this.strIdDrink);

  Cocktail.fromJson(Map<String, dynamic> json) {
    strIdDrink = json['idDrink'];
    strDrink = json['strDrink'];
    strDrinkThumb = json['strDrinkThumb'];
    strInstructions = json['strInstructions'];
    fillIngredients(json);
  }
}

Future<List<Cocktail>> fetchDrinksByName(String cocktail) async {
  final Box<Cocktail> cocktails = Hive.box('persistent-cache');

  http.Response res = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$cocktail'));

  final Map parsed = json.decode(res.body);
  if (parsed['drinks'] == null) return [];
  List<Cocktail> list = parsed["drinks"].map((val) {
    Cocktail newC = Cocktail.fromJson(val);
    cocktails.put(newC.strIdDrink, newC);
    return newC;
  }).toList();
  return list;
}

Future<List<dynamic>> fetchDrinksByFirstLetter(String letter) async {
  http.Response res = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/search.php?f=$letter'));

  final Map parsed = json.decode(res.body);

  if (parsed['drinks'] == null) return [];
  List<dynamic> list =
      parsed["drinks"].map((val) => Cocktail.fromJson(val)).toList();

  return list;
}

Future<dynamic> fetchDrinkById(String id) async {
  // www.thecocktaildb.com/api/json/v1/1/lookup.php?i=11007
  final http.Response res = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));

  if (res.body.isNotEmpty) {
    final Map parsed = json.decode(res.body);
    if (parsed['drinks'] == null) {
      return null;
    }
    Cocktail drink = Cocktail.fromJson(parsed['drinks'][0]);
    return drink;
  } else {
    return null;
  }
}

Future<List<Cocktail>> fetchDrinksByIngredient(String ingredient) async {
  final Box<Cocktail> cocktails = Hive.box('persistent-cache');
  final http.Response res = await http.get(Uri.parse(
      'www.thecocktaildb.com/api/json/v1/1/filter.php?i=$ingredient'));

  final Map parsed = json.decode(res.body);

  if (parsed['drinks'] == null) return [];
  List<Cocktail> list = parsed["drinks"].map((val) {
    Cocktail newC = Cocktail.fromJson(val);
    cocktails.put(newC.strIdDrink, newC);
    return newC;
  }).toList();

  return list;
}


// List the categories, glasses, ingredients or alcoholic filters
// www.thecocktaildb.com/api/json/v1/1/list.php?c=list
// www.thecocktaildb.com/api/json/v1/1/list.php?g=list
// www.thecocktaildb.com/api/json/v1/1/list.php?i=list
// www.thecocktaildb.com/api/json/v1/1/list.php?a=list