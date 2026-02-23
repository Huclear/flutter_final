import 'package:bloc/bloc.dart';
import 'package:recipe_sharing/data/repositories/firebase_auth_repository.dart';
import 'package:recipe_sharing/presentation/auth/auth_page_state.dart';
import 'package:recipe_sharing/presentation/auth/auth_viewModel.dart';

class AuthCubit extends Cubit<AuthPageState> {
  final AuthViewModel _viewModel = AuthViewModel(
    authRepo: FirebaseAuthRepository(),
  );
  AuthCubit() : super(AuthPageState());

  void updateState({
    String? login,
    String? email,
    String? password,
    bool? showPassword,
    String? repeatPassword,
    String? infoMessage,
  }) {
    _viewModel.refresh(
      login: login,
      email: email,
      password: password,
      showPassword: showPassword,
      repeatPassword: repeatPassword,
      infoMessage: infoMessage,
    );
    emit(_viewModel.build());
  }

  void clearResult() {
    _viewModel.clearResult();
    emit(_viewModel.build());
  }

  Future<void> confirmLogin() async {
    _viewModel.startLoading();
    emit(_viewModel.build());

    await _viewModel.confirmLogin();
    emit(_viewModel.build());
  }

  Future<void> confirmRegister() async {
    _viewModel.startLoading();
    emit(_viewModel.build());

    await _viewModel.confirmRegister();
    emit(_viewModel.build());
  }

  Future<void> authorize() async {
    _viewModel.startLoading();
    emit(_viewModel.build());

    await _viewModel.authorize();
    emit(_viewModel.build());
  }
}
