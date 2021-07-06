import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

import 'dtos/default_response.dart';
import 'graphql/clients/github_client.dart';

class GitHubService {
  late final GitHubApi _gitHubApi;

  GitHubService({required BuildContext context}) {
    _gitHubApi = GitHubApi(context: context);
  }

  Future<DefaultResponse> fetchStarredReposFrom(
      {required String username}) async {
    if (_gitHubApi.client == null) {
      return DefaultResponse(
          success: false,
          data: {'message': 'Credenciais não configuradas corretamente'});
    }

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

    try {
      final response = await _gitHubApi.client!.query(QueryOptions(
        document: gql(query),
      ));

      if (response.hasException) {
        return DefaultResponse(success: false, data: {
          'message': response.exception?.graphqlErrors.first.message ??
              "Ops, ocorreu um erro"
        });
      }

      return DefaultResponse(success: true, data: response.data);
    } catch (e) {
      rethrow;
    }
  }
}
