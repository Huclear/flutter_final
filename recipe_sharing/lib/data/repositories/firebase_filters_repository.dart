import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_sharing/data/repositories/shared_prefs_storage.dart';
import 'package:recipe_sharing/domain/firestore_collections.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/recipes/recipe.dart';
import 'package:recipe_sharing/domain/repositories/filters_repository.dart';

class FirebaseFiltersRepository implements FiltersRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Future<APIResult<dynamic>> attachFiltersToRecipe({
    required String recipeID,
    required List<String> filters,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }

      var doc = await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(recipeID)
          .get();

      if (!doc.exists) {
        return APIResultError(info: "Document not found");
      }

      var recipe = Recipe.fromMap(doc.data()!, user["userId"]);
      if (!recipe.own) {
        return APIResultError(info: "Recipe is not yours");
      }

      recipe.filters.addAll(filters);
      recipe.filters = recipe.filters.toSet().toList();

      await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(recipeID)
          .set(recipe.toMap());

      return APIResultSucceed(data: null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return APIResultError(
          info:
              'Error: User does not have permission to write to this document.',
        );
      } else if (e.code == 'unavailable') {
        return APIResultError(
          info: 'Error: The service is currently unavailable.',
        );
      }
      return APIResultError(info: "Unexpected error.");
    } catch (e) {
      return APIResultError(info: "Unexpected error.");
    }
  }

  @override
  Future<APIResult<dynamic>> clearRecipeFilters({
    required String recipeID,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }

      var doc = await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(recipeID)
          .get();

      if (!doc.exists) {
        return APIResultError(info: "Document not found");
      }

      var recipe = Recipe.fromMap(doc.data()!, user["userId"]);
      if (!recipe.own) {
        return APIResultError(info: "Recipe is not yours");
      }

      recipe.filters.clear();
      await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(recipeID)
          .set(recipe.toMap());

      return APIResultSucceed(data: null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return APIResultError(
          info:
              'Error: User does not have permission to write to this document.',
        );
      } else if (e.code == 'unavailable') {
        return APIResultError(
          info: 'Error: The service is currently unavailable.',
        );
      }
      return APIResultError(info: "Unexpected error.");
    } catch (e) {
      return APIResultError(info: "Unexpected error.");
    }
  }

  @override
  Future<APIResult<List<String>>> getCategories() async {
    try {
      var categories = await _store
          .collection(FirestoreCollections.categories.collectionName)
          .get();

      var result = categories.docs.map((e) => e["name"] as String).toList();
      return APIResultSucceed(data: result);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return APIResultError(
          info:
              'Error: User does not have permission to write to this document.',
        );
      } else if (e.code == 'unavailable') {
        return APIResultError(
          info: 'Error: The service is currently unavailable.',
        );
      }
      return APIResultError(info: "Unexpected error.");
    } catch (e) {
      return APIResultError(info: "Unexpected error.");
    }
  }

  @override
  Future<APIResult<Map<String, List<String>>>> getCategorizedFilters() async {
    try {
      var categories = await _store
          .collection(FirestoreCollections.categories.collectionName)
          .get();

      Map<String, List<String>> categorizedFilters = {};
      for (var category in categories.docs) {
        var fitlers = await _store
            .collection(FirestoreCollections.filters.collectionName)
            .where("categoryId", isEqualTo: category["id"])
            .get();
        categorizedFilters.addAll({
          category["name"] as String: fitlers.docs
              .map((e) => e["name"] as String)
              .toList(),
        });
      }
      return APIResultSucceed(data: categorizedFilters);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return APIResultError(
          info:
              'Error: User does not have permission to write to this document.',
        );
      } else if (e.code == 'unavailable') {
        return APIResultError(
          info: 'Error: The service is currently unavailable.',
        );
      }
      return APIResultError(info: "Unexpected error.");
    } catch (e) {
      return APIResultError(info: "Unexpected error.");
    }
  }

  @override
  Future<APIResult<List<String>>> getFiltersByCategory({
    required String category,
  }) async {
    try {
      var fitlers = await _store
          .collection(FirestoreCollections.filters.collectionName)
          .where("categoryId", isEqualTo: category)
          .get();

      return APIResultSucceed(
        data: fitlers.docs.map((e) => e["name"] as String).toList(),
      );
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return APIResultError(
          info:
              'Error: User does not have permission to write to this document.',
        );
      } else if (e.code == 'unavailable') {
        return APIResultError(
          info: 'Error: The service is currently unavailable.',
        );
      }
      return APIResultError(info: "Unexpected error.");
    } catch (e) {
      return APIResultError(info: "Unexpected error.");
    }
  }

  @override
  Future<APIResult<dynamic>> removeFiltersFromRecipe({
    required String recipeID,
    required List<String> filters,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }

      var doc = await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(recipeID)
          .get();

      if (!doc.exists) {
        return APIResultError(info: "Document not found");
      }

      var recipe = Recipe.fromMap(doc.data()!, user["userId"]);
      if (!recipe.own) {
        return APIResultError(info: "Recipe is not yours");
      }

      recipe.filters.removeWhere((e) => filters.contains(e));
      recipe.filters = recipe.filters.toSet().toList();

      await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(recipeID)
          .set(recipe.toMap());

      return APIResultSucceed(data: null);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return APIResultError(
          info:
              'Error: User does not have permission to write to this document.',
        );
      } else if (e.code == 'unavailable') {
        return APIResultError(
          info: 'Error: The service is currently unavailable.',
        );
      }
      return APIResultError(info: "Unexpected error.");
    } catch (e) {
      return APIResultError(info: "Unexpected error.");
    }
  }
}
