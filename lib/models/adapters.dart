import 'package:hive_flutter/hive_flutter.dart';
import 'package:cocktail_app/models/cocktail.dart';

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final typeId = 0;

  @override
  Ingredient read(BinaryReader reader) {
    return Ingredient.hive(reader.read())..volume = reader.read();
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer.write(obj.name);
    writer.write(obj.volume);
  }
}

class CocktailAdapter extends TypeAdapter<Cocktail> {
  @override
  final typeId = 1;

  @override
  Cocktail read(BinaryReader reader) {
    return Cocktail.hive(reader.read())
      ..strDrink = reader.read()
      ..strDrinkThumb = reader.read()
      ..strInstructions = reader.read()
      ..strMainIngredient = reader.read()
      ..isFavorite = reader.read()
      ..lstIngredients = reader.read();
  }

  @override
  void write(BinaryWriter writer, Cocktail obj) {
    writer.write(obj.strIdDrink);
    writer.write(obj.strDrink);
    writer.write(obj.strDrinkThumb);
    writer.write(obj.strInstructions);
    writer.write(obj.strMainIngredient);
    writer.write(obj.isFavorite);
    writer.write(obj.lstIngredients);
  }
}
