import 'package:flutter/foundation.dart';
import 'package:recipe_sharing/domain/repositories/creators_repository.dart';
import 'package:recipe_sharing/presentation/creators/creators_load_data_type.dart';
import 'package:recipe_sharing/presentation/creators/creators_screen_state.dart';

import '../../data/repositories/shared_prefs_storage.dart';
import '../../domain/models/api_result.dart';
import '../../domain/models/creators/creator_request.dart';
import '../../domain/models/paged_result.dart';

class CreatorsScreenViewModel extends ChangeNotifier {
  final CreatorsRepository _creatorsRepo;

  CreatorsScreenViewModel({required CreatorsRepository creatorsRepo})
    : _creatorsRepo = creatorsRepo;

  String _currentUserName = 'Unknown name';
  String _currentUserEmail = 'Unknown @';

  APIResult<PagedResult<CreatorRequest>> _creators = APIResultLoading();
  int _currentPage = 1;
  int _maxPages = 1;
  int _pageSize = 10;
  CreatorsLoadDataType _creatorsLoadDataType = CreatorsLoadDataType.all;

  CreatorsScreenState build() {
    return CreatorsScreenState(
      creators: _creators,
      currentPage: _currentPage,
      maxPages: _maxPages,
      pageSize: _pageSize,
      creatorsLoadDataType: _creatorsLoadDataType,
      currentUserEmail: _currentUserEmail,
      currentUserName: _currentUserName,
    );
  }

  Future<void> loadCurrentUser() async {
    var user = await SharedPreferencesService.getCurrentUser();
    _currentUserEmail = user["userEmail"] ?? 'Unknown @';
    _currentUserName = user["userNickname"] ?? 'Unknown name';
  }

  Future<void> triggerFollowsForCreator(String creatorId) async {
    var isCreatorInFollows = await _creatorsRepo.doesFollow(
      creatorID: creatorId,
    );
    if (isCreatorInFollows is APIResultSucceed) {
      if (isCreatorInFollows.data!) {
        await _creatorsRepo.removeFromFollows(creatorID: creatorId);
      } else {
        await _creatorsRepo.addToFollows(creatorID: creatorId);
      }
    }
  }

  void startLoadingCreators() {
    _creators = APIResultLoading();
  }

  void setLoadDataType(CreatorsLoadDataType dataType) {
    _creatorsLoadDataType = dataType;
  }

  Future<void> loadData({required int page, int pageSize = 10}) async {
    late APIResult<PagedResult<CreatorRequest>> result;
    switch (_creatorsLoadDataType) {
      case CreatorsLoadDataType.all:
        result = await _creatorsRepo.getCreators(
          page: page,
          pageSize: pageSize,
        );
        break;
      case CreatorsLoadDataType.follows:
        result = await _creatorsRepo.getOwnFollows(
          page: page,
          pageSize: pageSize,
        );
        break;
    }

    _creators = result;
    if (result is APIResultSucceed) {
      _currentPage = result.data!.currentPage;
      _pageSize = result.data!.pageSize;
      _maxPages = result.data!.totalPages;
    }
  }
}
