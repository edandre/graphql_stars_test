import 'package:flutter/widgets.dart';
import 'package:git_stars/core/enums/view_state.dart';
import 'package:git_stars/modules/stargazers_finder/models/git_user.dart';
import 'package:git_stars/modules/stargazers_finder/repositories/user_repository.dart';
import 'package:provider/provider.dart';

class GitUserViewModel with ChangeNotifier {
  late final BuildContext context;
  late final UserRepository _userRepository;
  ViewState _viewState = ViewState.idle;
  String? _actionFeedbackMessage;
  GitUser? _gitUser;

  GitUserViewModel({required this.context}) {
    _userRepository = Provider.of<UserRepository>(context, listen: false);
  }

  ViewState get viewState => _viewState;
  GitUser? get gitUser => _gitUser;
  String? get actionFeedbackMessage => _actionFeedbackMessage;

  Future fetchStarredReposFrom({required String username}) async {
    switchViewState(to: ViewState.loading);

    final user =
        await _userRepository.fetchStarredReposFrom(username: username);

    if (user == null) {
      switchViewState(
          to: ViewState.action_error, message: 'Usuário não encontrado');
    } else {
      _gitUser = user;
      switchViewState(to: ViewState.action_success);
    }
  }

  void switchViewState({required ViewState to, String? message}) {
    _viewState = to;
    _actionFeedbackMessage = message;
    notifyListeners();
  }

  void clear() {
    _viewState = ViewState.idle;
    _actionFeedbackMessage = null;
    _gitUser = null;
    notifyListeners();
  }
}
