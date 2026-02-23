import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_sharing/domain/models/recipes/recipe_difficulty.dart';

import 'ingredient.dart';
import 'step.dart';

class Recipe {
  String recipeID;
  String creatorID;
  String? imageUrl;
  String recipeName;
  String? description;
  List<Ingredient> ingredients;
  List<Step> steps;
  List<String> filters;
  double timeMinutes;
  double currentRating;
  int reviewsCount;
  int viewsCount;
  RecipeDifficulty difficulty;
  Timestamp datePublished;
  bool own;

  Recipe({
    required this.recipeID,
    required this.creatorID,
    this.imageUrl,
    required this.recipeName,
    this.description,
    required this.ingredients,
    required this.steps,
    required this.filters,
    required this.timeMinutes,
    required this.currentRating,
    required this.reviewsCount,
    required this.viewsCount,
    required this.datePublished,
    this.own = false,
    this.difficulty = RecipeDifficulty.common,
  });

  factory Recipe.fromMap(Map<String, dynamic> map, String? uidToCheck) {
    var ingredients = (map["ingredients"] ?? []) as List<dynamic>;
    var steps = (map["steps"] ?? []) as List<dynamic>;
    return Recipe(
      recipeID: map["id"],
      creatorID: map["userId"],
      recipeName: map["name"],
      description: map["description"],
      ingredients: ingredients
          .map((e) => Ingredient.fromMap(e as Map<String, dynamic>))
          .toList(),
      steps: steps.map((e) => Step.fromMap(e as Map<String, dynamic>)).toList(),
      timeMinutes: map["timeMinutes"] is int
          ? (map["timeMinutes"] as int).toDouble()
          : (map["timeMinutes"] as double),
      currentRating: map["currentRating"] is int
          ? (map["currentRating"] as int).toDouble()
          : (map["currentRating"] as double),
      reviewsCount: map["reviewsCount"] ?? 0,
      viewsCount: map["viewsCount"] ?? 0,
      datePublished: map["datePublished"] as Timestamp,
      own: uidToCheck == null || map["userId"] == uidToCheck,
      filters: (map["filters"] as List<dynamic>).isNotEmpty
          ? (map["filters"] as List<dynamic>).map((e) => e as String).toList()
          : List.empty(growable: true),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': recipeID,
      'userId': creatorID,
      'name': recipeName,
      'description': description,
      'ingredients': ingredients.map((e) => e.toMap()).toList(),
      'ingredients_string': ingredients.map((e) => e.name).join("|"),
      'steps': steps.map((e) => e.toMap()).toList(),
      'filters': filters,
      'filters_string': filters.join('|'),
      'timeMinutes': steps.fold(0.0, (s, e) => s + e.durationMinutes),
      'currentRating': currentRating,
      'reviewsCount': reviewsCount,
      'viewsCount': viewsCount,
      'datePublished': datePublished,
    };
  }
}
