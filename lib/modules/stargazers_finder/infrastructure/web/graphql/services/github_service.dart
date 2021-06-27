import 'package:flutter/cupertino.dart';
import 'package:git_stars/modules/stargazers_finder/infrastructure/web/clients/github_client.dart';
import 'package:git_stars/modules/stargazers_finder/infrastructure/web/dto/default_response.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

class GitHubService {
  late final GitHubApi _gitHubApi;

  GitHubService({required BuildContext context}) {
    _gitHubApi = Provider.of<GitHubApi>(context);
  }

  Future<DefaultResponse> fetchStarredReposFrom(
      {required String username}) async {
    const String query = r'''
      {
        user(login: $userName) {
          name,
          avatarUrl,
          bio,
          location,
          email,
          url,
          starredRepositories{
            nodes{
              nameWithOwner,
              description,
              stargazerCount
            }
          }
        }
      }
    ''';

    final response = await _gitHubApi.client.query(QueryOptions(
        document: gql(query),
        variables: <String, dynamic>{'userName': username}));

    if (response.hasException) {
      //! TODO: handle error data
      return DefaultResponse(success: false, data: null);
    }

    return DefaultResponse(success: true, data: response.data);
  }
}
