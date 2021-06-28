import 'package:git_stars/modules/stargazers_finder/services/github_service.dart';
import 'package:git_stars/modules/stargazers_finder/models/git_user.dart';

class UserRepository {
  late final GitHubService service;

  UserRepository() {
    service = GitHubService();
  }

  Future<GitUser?> fetchStarredReposFrom({required String username}) async {
    final userResponse =
        await service.fetchStarredReposFrom(username: username);

    if (userResponse.success) {
      // means that GitHub account was retreived successfully and, therefore, "userResponse.data" variable shall not be null
      return GitUser.fromJson(userResponse.data!["user"]);
    }

    // user not found
    return null;
  }
}
