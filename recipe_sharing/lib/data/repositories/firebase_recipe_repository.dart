import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_sharing/data/repositories/shared_prefs_storage.dart';
import 'package:recipe_sharing/domain/firestore_collections.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/filters/filter_model.dart';
import 'package:recipe_sharing/domain/models/filters/recipe_ordering.dart';
import 'package:recipe_sharing/domain/models/paged_result.dart';
import 'package:recipe_sharing/domain/models/recipes/recipe.dart';
import 'package:recipe_sharing/domain/repositories/recipe_repository.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import 'package:uuid_plus/uuid_plus.dart';

class FirebaseRecipesRepository implements RecipesRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Future<APIResult> addToFavorites({required String recipeID}) async {
    if (!(await SharedPreferencesService.isUserLoggedIn())) {
      return APIResultError(info: "Unauthorized");
    }
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      await _store
          .collection(FirestoreCollections.favorites.collectionName)
          .doc("${user["userId"]} - $recipeID")
          .set({"userId": user["userId"], "recipeId": recipeID});
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
  Future<APIResult> deleteRecipe({required String receiptID}) async {
    if (!(await SharedPreferencesService.isUserLoggedIn())) {
      return APIResultError(info: "Unauthorized");
    }
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      var existedDoc = await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(receiptID)
          .get();
      if (!existedDoc.exists) {
        return APIResultError(info: "Document with such id was not found");
      } else if (existedDoc.data()!["userId"] != user["userId"]) {
        return APIResultError(info: "Does not own");
      } else {
        await _store
            .collection(FirestoreCollections.recipes.collectionName)
            .doc(receiptID)
            .delete();
        return APIResultSucceed(data: null);
      }
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
  Future<APIResult<PagedResult<Recipe>>> getFilteredRecipes({
    String? name,
    FiltersModel? filtering,
    RecipeOrdering? ordering,
    bool ascending = true,
    required int page,
    required int pageSize,
    required RecipesLoadedDataType loadedType,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      late Query<Map<String, dynamic>> fitleringQuery;
      var initialCollection = _store.collection(
        FirestoreCollections.recipes.collectionName,
      );

      switch (loadedType) {
        case RecipesLoadedDataTypeOwn():
          if (user["userId"] != null) {
            fitleringQuery = initialCollection.where(
              "userId",
              isEqualTo: user["userId"],
            );
          } else {
            fitleringQuery = initialCollection.where(
              "userId",
              isNotEqualTo: user["userId"],
            );
          }
          break;
        case RecipesLoadedDataTypeCreator():
          fitleringQuery = initialCollection.where(
            "userId",
            isEqualTo: loadedType.creatorId,
          );
          break;
        case RecipesLoadedDataTypeFavorites():
          if (user["userId"] != null) {
            var favorites = await _store
                .collection(FirestoreCollections.favorites.collectionName)
                .where("userId", isEqualTo: user["userId"])
                .get();
            var favoritiesRecipesIds = favorites.docs
                .map((doc) => doc.data()["recipeId"] as String)
                .toList();
            if (favoritiesRecipesIds.isNotEmpty) {
              fitleringQuery = initialCollection.where(
                "id",
                whereIn: favoritiesRecipesIds,
              );
            } else {
              fitleringQuery = initialCollection.where("id", isEqualTo: "-1");
            }
          } else {
            fitleringQuery = initialCollection.where(
              "userId",
              isNotEqualTo: user["userId"],
            );
          }
          break;
        case RecipesLoadedDataTypeAll():
          fitleringQuery = initialCollection.where(
            "userId",
            isNotEqualTo: user["userId"],
          );
          break;
      }

      var collectionData = (await fitleringQuery.get()).docs.map(
        (e) => Recipe.fromMap(e.data(), user["userId"]),
      );
      if (name != null) {
        collectionData = collectionData.where(
          (r) => r.recipeName.contains(name),
        );
      }

      //filtering
      if (filtering != null) {
        if (filtering.ingredients?.isEmpty == false) {
          var searchedIngredients = filtering.ingredients!.join('|');
          collectionData = collectionData.where(
            (r) => r.ingredients
                .map((e) => e.name)
                .join("|")
                .contains(searchedIngredients),
          );
        }

        if (filtering.tags?.isEmpty == false) {
          var searchedFilters = filtering.tags!.join('|');
          collectionData = collectionData.where(
            (r) => r.filters.join("|").contains(searchedFilters),
          );
        }
        if (filtering.timeFrom != null) {
          collectionData = collectionData.where(
            (r) => r.timeMinutes >= filtering.timeFrom!,
          );
        }
        if (filtering.timeTo != null) {
          collectionData = collectionData.where(
            (r) => r.timeMinutes <= filtering.timeTo!,
          );
        }
      }

      //ordering
      switch (ordering) {
        case null:
          break;
        case RecipeOrdering.datePublished:
          collectionData.toList().sort(
            (a, b) => ascending
                ? a.datePublished.compareTo(b.datePublished)
                : b.datePublished.compareTo(a.datePublished),
          );
        case RecipeOrdering.rating:
          collectionData.toList().sort(
            (a, b) => ascending
                ? a.currentRating.compareTo(b.currentRating)
                : b.currentRating.compareTo(a.currentRating),
          );
        case RecipeOrdering.difficulty:
          collectionData.toList().sort(
            (a, b) => ascending
                ? a.difficulty.compareTo(b.difficulty)
                : b.difficulty.compareTo(a.difficulty),
          );
      }

      //paging
      var currentPage = -1;
      var totalCount = collectionData.length;
      totalCount = totalCount < 1 ? 1 : totalCount;
      var totalPages = (totalCount.toDouble() / pageSize.toDouble()).ceil();
      currentPage = totalPages < page ? totalPages : page;

      collectionData = collectionData
          .skip((currentPage - 1) * pageSize)
          .take(pageSize);

      return APIResultSucceed(
        data: PagedResult(
          result: collectionData.toList(),
          currentPage: currentPage,
          totalPages: totalPages,
          pageSize: pageSize,
        ),
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
  Future<APIResult<Recipe>> getRecipeByID({required String receiptID}) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      var doc = await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(receiptID)
          .get();
      if (!doc.exists) {
        return APIResultError(info: "Document not found");
      }
      return APIResultSucceed(
        data: Recipe.fromMap(doc.data()!, user["userId"]),
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
  Future<APIResult<bool>> isRecipeInFavorites({
    required String receiptID,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultSucceed(data: false);
      }
      var doc = await _store
          .collection(FirestoreCollections.favorites.collectionName)
          .doc("${user["userId"]} - $receiptID")
          .get();

      return APIResultSucceed(data: doc.exists);
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
  Future<APIResult<bool>> isRecipeOwn({required String receiptID}) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultSucceed(data: false);
      }
      var doc = await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(receiptID)
          .get();

      return APIResultSucceed(
        data: doc.exists && doc["userId"] == user["userId"],
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
  Future<APIResult<String>> postRecipe({required Recipe request}) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }

      var newId = UuidV4().generate();
      request.creatorID = user["userId"]!;
      request.recipeID = newId;
      await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(newId)
          .set(request.toMap());

      return APIResultSucceed(data: newId);
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
  Future<APIResult> removeFromFavorites({required String recipeID}) async {
    if (!(await SharedPreferencesService.isUserLoggedIn())) {
      return APIResultError(info: "Unauthorized");
    }
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      await _store
          .collection(FirestoreCollections.favorites.collectionName)
          .doc("${user["userId"]} - $recipeID")
          .delete();
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
  Future<APIResult> updateRecipe({required Recipe request}) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      } else if (request.recipeID.isEmpty) {
        return APIResultError(info: "Recipe id not found");
      }

      request.creatorID = user["userId"]!;
      await _store
          .collection(FirestoreCollections.recipes.collectionName)
          .doc(request.recipeID)
          .set(request.toMap());

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
  Future<APIResult<String>> uploadRecipeImage({required File imageFile}) async {
    return APIResultError(info: "Not implemented");
  }
}
