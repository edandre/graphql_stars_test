import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_stars/core/enums/view_state.dart';
import 'package:git_stars/modules/stargazers_finder/view_models/git_user_view_model.dart';
import 'package:provider/provider.dart';

class FindUserView extends StatelessWidget {
  final TextEditingController _usernameTextController = TextEditingController();
  late final GitUserViewModel _gitUserViewModel;

  @override
  Widget build(BuildContext context) {
    _gitUserViewModel = context.read();

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
        ),
        elevation: 0.00,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Image.asset(
              'lib/assets/git.png',
              height: 200,
              color: Colors.blueGrey[800],
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 15, right: 15),
              child: Text(
                'Seja bem-vindo(a)! Para começar, insira o nome do usuário git abaixo (:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey.shade800),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _usernameTextController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey[900],
                      labelText: 'Nome de usuário(a)',
                      hintText: 'e.g. \'torvalds\''),
                  cursorColor: Colors.grey[900],
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.grey.shade900),
                ),
              ),
            ),
            Consumer<GitUserViewModel>(
              builder: (context, _gitUserViewModel, child) {
                if (_gitUserViewModel.viewState != ViewState.loading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    child: ElevatedButton(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'BUSCAR REPOSITÓRIOS ESTRELADOS',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        await _gitUserViewModel.fetchStarredReposFrom(
                            username: _usernameTextController.text);

                        if (_gitUserViewModel.viewState ==
                            ViewState.action_success) {
                          Navigator.of(context).pushNamed('user-view');
                        }
                      },
                    ),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
