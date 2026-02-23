import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_sharing/data/repositories/shared_prefs_storage.dart';
import 'package:recipe_sharing/domain/firestore_collections.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/creators/creator_request.dart';
import 'package:recipe_sharing/domain/models/paged_result.dart';
import 'package:recipe_sharing/domain/repositories/creators_repository.dart';

class FirebaseCreatorsRepository implements CreatorsRepository {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Future<APIResult<dynamic>> addToFollows({required String creatorID}) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      } else if (user["userId"] == creatorID) {
        return APIResultError(info: "Self liked");
      }
      await _store
          .collection(FirestoreCollections.follows.collectionName)
          .doc("${user["userId"]}-$creatorID")
          .set({"userId": user["userId"], "creatorId": creatorID});
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
  Future<APIResult<bool>> doesFollow({required String creatorID}) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      } else if (user["userId"] == creatorID) {
        return APIResultError(info: "Self liked");
      }
      var exists = await _store
          .collection(FirestoreCollections.follows.collectionName)
          .doc("${user["userId"]}-$creatorID")
          .get();
      return APIResultSucceed(data: exists.exists);
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
  Future<APIResult<CreatorRequest>> getCreatorById({
    required String creatorId,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }
      var data = await _store
          .collection(FirestoreCollections.creators.collectionName)
          .doc(creatorId)
          .get();
      return APIResultSucceed(
        data: CreatorRequest(
          userID: data.data()!["userId"],
          nickname: data.data()!["nickname"],
          email: data.data()!["email"],
          aboutMe: data.data()!["aboutMe"],
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
  Future<APIResult<PagedResult<CreatorRequest>>> getCreators({
    required int page,
    required int pageSize,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }
      var data =
          (await _store
                  .collection(FirestoreCollections.creators.collectionName)
                  .where("userId", isNotEqualTo: user["userId"])
                  .get())
              .docs
              .map(
                (e) => CreatorRequest(
                  userID: e.data()["userId"],
                  nickname: e.data()["nickname"],
                  email: e.data()["email"],
                  aboutMe: e.data()["aboutMe"],
                ),
              );

      var currentPage = -1;
      var totalCount = data.length;
      totalCount = totalCount < 1 ? 1 : totalCount;
      var totalPages = (totalCount.toDouble() / pageSize.toDouble()).ceil();
      currentPage = totalPages < page ? totalPages : page;

      data = data.skip((currentPage - 1) * pageSize).take(pageSize);
      return APIResultSucceed(
        data: PagedResult(
          result: data.toList(),
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
  Future<APIResult<PagedResult<CreatorRequest>>> getOwnFollows({
    required int page,
    required int pageSize,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      }

      var follows =
          (await _store
                  .collection(FirestoreCollections.follows.collectionName)
                  .where("userId", isEqualTo: user["userId"])
                  .get())
              .docs
              .map((e) => e.data()["creatorId"] as String)
              .toList();

      var data =
          (await _store
                  .collection(FirestoreCollections.creators.collectionName)
                  .where("userId", whereIn: follows)
                  .get())
              .docs
              .map(
                (e) => CreatorRequest(
                  userID: e.data()["userId"],
                  nickname: e.data()["nickname"],
                  email: e.data()["email"],
                  aboutMe: e.data()["aboutMe"],
                ),
              );

      var currentPage = -1;
      var totalCount = data.length;
      totalCount = totalCount < 1 ? 1 : totalCount;
      var totalPages = (totalCount.toDouble() / pageSize.toDouble()).ceil();
      currentPage = totalPages < page ? totalPages : page;

      data = data.skip((currentPage - 1) * pageSize).take(pageSize);
      return APIResultSucceed(
        data: PagedResult(
          result: data.toList(),
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
  Future<APIResult<dynamic>> removeFromFollows({
    required String creatorID,
  }) async {
    try {
      var user = await SharedPreferencesService.getCurrentUser();
      if (user["userId"] == null) {
        return APIResultError(info: "Unauthorized");
      } else if (user["userId"] == creatorID) {
        return APIResultError(info: "Self liked");
      }
      await _store
          .collection(FirestoreCollections.follows.collectionName)
          .doc("${user["userId"]}-$creatorID")
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
}
