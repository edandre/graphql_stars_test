import 'package:git_stars/core/app_settings.dart';
import 'package:graphql/client.dart';

class GitHubApi {
  final String _uri = AppSettings.gqlGitHubApiUrl;
  //TODO: secure token
  final String _bearerToken = '';
  late final GraphQLClient _client;

  GitHubApi() {
    final Link _link = AuthLink(getToken: () async => 'Bearer $_bearerToken')
        .concat(HttpLink(_uri));

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  GraphQLClient get client => _client;
}
