import 'package:git_stars/modules/stargazers_finder/infrastructure/web/graphql/services/github_service.dart';
import 'package:git_stars/modules/stargazers_finder/models/git_user.dart';

class UserRepository {
  final GitHubService service;

  const UserRepository({required this.service});

  Future<GitUser?> fetchStarredReposFrom({required String username}) async {
    final userResponse =
        await service.fetchStarredReposFrom(username: username);

    if (userResponse.success) {
      // means userResponse.data should not be null
      return GitUser.fromJson(userResponse.data!);
    }

    // user not found
    return null;
  }
}
