import 'dart:ffi' as ffi;

import 'package:flutter/cupertino.dart';
import 'package:git_stars/core/app_settings.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

class GitHubApi {
  late final String _uri;
  late final String _bearerToken;
  late final BuildContext _context;
  GraphQLClient? _client;

  GitHubApi({required BuildContext context}) {
    _context = context;
    init();
  }

  void init() {
    final appConfig = Provider.of<AppSettings>(_context, listen: false);

    // if settings isn't done properly, client will be null
    if ((appConfig.gqlGitHubApiUrl ?? "").isNotEmpty &&
        (appConfig.gqlGitHubApiToken ?? "").isNotEmpty) {
      _uri = appConfig.gqlGitHubApiUrl!;
      _bearerToken = appConfig.gqlGitHubApiToken!;

      final Link _link = AuthLink(getToken: () async => 'Bearer $_bearerToken')
          .concat(HttpLink(_uri));

      _client = GraphQLClient(
        cache: GraphQLCache(),
        link: _link,
      );
    }
  }

  GraphQLClient? get client {
    if (_client == null) {
      init();
    }

    return _client;
  }
}
