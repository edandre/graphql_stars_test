import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_stars/modules/stargazers_finder/models/git_user.dart';
import 'package:git_stars/modules/stargazers_finder/view_models/git_user_view_model.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GitUserViewModel _gitUserViewModel = context.watch();

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
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.network(
                      _gitUserViewModel.gitUser?.avatarUrl ??
                          'https://www.inbounder.com.br/wp-content/themes/inbounder/images/no-image/No-Image-Found-400x264.png',
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, left: 16.0),
                              child: Icon(
                                Icons.account_circle_sharp,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, left: 8.0),
                              child: Text(
                                _gitUserViewModel.gitUser?.name ??
                                    'Não identificado',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, right: 5),
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 16),
                              child: Text(
                                _gitUserViewModel.gitUser?.location ??
                                    'Sem localização',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 16.0),
                              child: Icon(
                                Icons.mail,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14, left: 9.0),
                              child: Text(
                                (_gitUserViewModel.gitUser?.email ?? '')
                                            .length ==
                                        0
                                    ? 'Nenhum e-mail registrado'
                                    : _gitUserViewModel.gitUser!.email!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 16.0),
                              child: Icon(
                                Icons.note_alt_rounded,
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14, left: 9.0),
                              child: Text(
                                _gitUserViewModel.gitUser?.bio ??
                                    'Nenhum conteúdo na bio',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 0.75,
                  color: Colors.grey.shade900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Icon(Icons.star, color: Colors.blueGrey[600]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 12.0),
                      child: Text(
                        'Repositórios Estrelados',
                        style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
              if ((_gitUserViewModel.gitUser?.starredRepositories ??
                          <StarredRepository>[])
                      .length ==
                  0)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Nenhum repositório estrelado por este(a) usuário(a).',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.00),
                  child: Column(
                    children: ListTile.divideTiles(
                            context: context,
                            tiles: _gitUserViewModel
                                .gitUser!.starredRepositories!
                                .map(
                                  (repo) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(repo.nameWithOwner),
                                      subtitle: Text(repo.description ??
                                          'Sem descrição disponível'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.lime[700],
                                            size: 18,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2.0, left: 5),
                                            child: Text(
                                              repo.stargazerCount.toString(),
                                              style: TextStyle(
                                                  color: Colors.blueGrey[800],
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            color: Colors.blueGrey[800])
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _gitUserViewModel.clear();
          Navigator.of(context).pop();
        },
        child: Icon(Icons.search, color: Colors.blueGrey[500], size: 28),
      ),
    );
  }
}
