enum AppTheme { dark, light }

class AppSettings {
  static const gqlGitHubApiUrl = 'https://api.github.com/graphql';
  static AppTheme currentAppTheme = AppTheme.light;
}
