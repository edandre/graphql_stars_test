import 'package:graphql/client.dart';

class GitHubApi {
  final String _uri = 'https://api.github.com/graphql';
  final String _bearerToken = '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';
  late final GraphQLClient _client;

  GitHubApi() {
    final Link _link = HttpLink(_uri)
        .concat(AuthLink(getToken: () async => 'Bearer $_bearerToken'));

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  GraphQLClient get client => _client;
}
