import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:recipe_sharing/data/repositories/firebase_creators_repository.dart';
import 'package:recipe_sharing/presentation/creators/creators_load_data_type.dart';
import 'package:recipe_sharing/presentation/creators/creators_screen_state.dart';
import 'package:recipe_sharing/presentation/creators/creators_viewModel.dart';

class CreatorsScreenCubit extends Cubit<CreatorsScreenState> {
  final CreatorsScreenViewModel _viewModel = CreatorsScreenViewModel(
    creatorsRepo: FirebaseCreatorsRepository(),
  );

  CreatorsScreenCubit() : super(CreatorsScreenState());

  Future<void> loadData({required int page, int pageSize = 10}) async {
    _viewModel.startLoadingCreators();
    emit(_viewModel.build());
    await _viewModel.loadData(page: page, pageSize: pageSize);
    emit(_viewModel.build());
  }

  Future<void> setLoadDataType(CreatorsLoadDataType dataType) async {
    _viewModel.startLoadingCreators();
    emit(_viewModel.build());
    _viewModel.setLoadDataType(dataType);
    await _viewModel.loadData(page: 1);
    emit(_viewModel.build());
  }

  Future<void> triggerFollowsForCreator(String creatorId) async {
    await _viewModel.triggerFollowsForCreator(creatorId);
    emit(_viewModel.build());
  }
}
