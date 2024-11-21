import 'dart:convert';
import 'package:recipe_app/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular"
    });

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "fe8859efbcmshedf7ce6d9392a45p1a4ffdjsn97e2d84b85b5",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List temp = [];

      for (var i in data['feed']) {
        temp.add(i['content']['details']);
      }

      return Recipe.recipesFromSnapshot(temp);
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
