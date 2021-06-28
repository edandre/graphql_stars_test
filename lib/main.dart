import 'package:flutter/material.dart';
import 'package:git_stars/core/themes/light_theme.dart';
import 'package:git_stars/modules/stargazers_finder/view_models/git_user_view_model.dart';
import 'package:git_stars/modules/stargazers_finder/views/find_user_view.dart';
import 'package:git_stars/modules/stargazers_finder/views/user_view.dart';
import 'package:provider/provider.dart';

import 'core/themes/dark_theme.dart';
import 'modules/stargazers_finder/repositories/user_repository.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => LightTheme()),
      Provider(create: (context) => DarkTheme()),
      Provider(create: (context) => UserRepository()),
      ChangeNotifierProvider(
          create: (context) => GitUserViewModel(context: context)),
    ],
    child: GitStarsApp(),
  ));
}

class GitStarsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Git Stars',
      routes: {
        'find-user-view': (context) => FindUserView(),
        'user-view': (context) => UserView(),
      },
      theme: ThemeData(
        fontFamily: 'Segoe UI',
        backgroundColor: Colors.grey[600],
        accentColor: Colors.lime[400],
        primaryIconTheme: IconThemeData(color: Colors.orange[400]),
        primarySwatch: Colors.blueGrey,
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2, color: Colors.grey)),
          labelColor: Colors.blueGrey[800],
        ),
        hintColor: Colors.blueGrey.shade600,
      ),
      home: FindUserView(),
    );
  }
}
