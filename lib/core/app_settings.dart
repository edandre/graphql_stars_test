import 'dart:convert';

import 'package:flutter/material.dart';

enum AppTheme { dark, light }

class AppSettings {
  AppTheme? _theme;
  String? _gqlGitHubApiUrl;
  String? _gqlGitHubApiToken;

  AppTheme? get theme => _theme;
  void setAppTheme({required AppTheme theme}) {
    _theme = theme;
  }

  String? get gqlGitHubApiUrl => _gqlGitHubApiUrl;
  String? get gqlGitHubApiToken => _gqlGitHubApiToken;

  Future init({
    required BuildContext context,
    required AppTheme theme,
  }) async {
    //load app settings file
    final appSettingsRawContent = await DefaultAssetBundle.of(context)
        .loadString('config/app_settings.json');

    final appSettings = json.decode(appSettingsRawContent);

    //github api section
    final gqlGitHubApiSection =
        appSettings["GitHubApi"] as Map<String, dynamic>;

    // setting up
    _theme = theme;
    _gqlGitHubApiUrl = gqlGitHubApiSection["URL"];
    _gqlGitHubApiToken = gqlGitHubApiSection["Token"];
  }
}
