import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/creators/creator_request.dart';
import '../models/paged_result.dart';

abstract class CreatorsRepository {
  // Get creators
  Future<APIResult<PagedResult<CreatorRequest>>> getCreators({
    required int page,
    required int pageSize,
  });

  Future<APIResult<CreatorRequest>> getCreatorById({
    required String creatorId,
  });

  // Follows
  Future<APIResult<PagedResult<CreatorRequest>>> getOwnFollows({
    required int page,
    required int pageSize,
  });

  Future<APIResult> addToFollows({
    required String creatorID,
  });

  Future<APIResult> removeFromFollows({
    required String creatorID,
  });

  Future<APIResult<bool>> doesFollow({
    required String creatorID,
  });
}
