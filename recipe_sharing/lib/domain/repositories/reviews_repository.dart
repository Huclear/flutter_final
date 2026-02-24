import 'dart:async';

import '../models/paged_result.dart';
import '../models/reviews/revipe_review.dart';

abstract class ReviewsRepository {
  Future<PagedResult<RecipeReview>> getReviewsByRecipe({
    required String token,
    required String recipeID,
    required int page,
    required int pageSize,
  });

  Future<RecipeReview> getTopReviewsByRecipe({
    required String token,
    required String recipeID,
  });

  Future<PagedResult<RecipeReview>> getOrderedReviewsByRecipe({
    required String token,
    required String recipeID,
    required int page,
    required int pageSize,
  });

  Future<RecipeReview> getOwnReviewByRecipe({
    required String token,
    required String recipeID,
  });

  Future<int> getReviewsCountByRecipe({
    required String token,
    required String id,
  });

  Future<double> getRecipeRating({
    required String token,
    required String id,
  });

  Future<PagedResult<RecipeReview>> getPosReviewsByRecipe({
    required String token,
    required String id,
    required int page,
    required int pageSize,
  });

  Future<PagedResult<RecipeReview>> getOrderedPosReviewsByRecipe({
    required String token,
    required String id,
    required int page,
    required int pageSize,
  });

  Future<PagedResult<RecipeReview>> getNegReviewsByRecipe({
    required String token,
    required String id,
    required int page,
    required int pageSize,
  });

  Future<PagedResult<RecipeReview>> getOrderedNegReviewsByRecipe({
    required String token,
    required String id,
    required int page,
    required int pageSize,
  });

  Future<RecipeReview> getReviewByID({
    required String token,
    required String id,
  });

  Future<bool> getIsOwnReview({
    required String token,
    required String id,
  });

  Future<void> postReview({
    required String token,
    required RecipeReview reviewRequest,
  });

  Future<void> updateReview({
    required String token,
    required RecipeReview reviewRequest,
  });

  Future<void> deleteReview({
    required String token,
    required String id,
  });
}