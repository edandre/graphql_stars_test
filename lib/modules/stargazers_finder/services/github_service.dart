import 'package:graphql/client.dart';

import 'dtos/default_response.dart';
import 'graphql/clients/github_client.dart';

class GitHubService {
  late final GitHubApi _gitHubApi;

  GitHubService() {
    _gitHubApi = GitHubApi();
  }

  Future<DefaultResponse> fetchStarredReposFrom(
      {required String username}) async {
    final String query = '''
      {
        user(login: "$username") {
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
    ));

    if (response.hasException) {
      //! TODO: handle error data
      return DefaultResponse(success: false, data: null);
    }

    return DefaultResponse(success: true, data: response.data);
  }
}
