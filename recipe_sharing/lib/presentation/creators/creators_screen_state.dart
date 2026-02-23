import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/paged_result.dart';
import 'package:recipe_sharing/presentation/creators/creators_load_data_type.dart';

import '../../domain/models/creators/creator_request.dart';

part 'creators_screen_state.freezed.dart';

@freezed
class CreatorsScreenState with _$CreatorsScreenState {
  factory CreatorsScreenState({
    @Default('Unknown name') String currentUserName,
    @Default('Unknown @') String currentUserEmail,

    @Default(APIResultLoading())
    APIResult<PagedResult<CreatorRequest>> creators,
    @Default(1) int currentPage,
    @Default(1) int maxPages,
    @Default(10) int pageSize,
    @Default(CreatorsLoadDataType.all)
    CreatorsLoadDataType creatorsLoadDataType,
  }) = _CreatorsScreenState;
}
