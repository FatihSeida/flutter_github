import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejutacita_flutter_github/cache/cache.dart';
import 'package:sejutacita_flutter_github/blocs/issue/bloc/issue_search_bloc.dart';
import 'package:sejutacita_flutter_github/blocs/repository/bloc/repository_search_bloc.dart';
import 'package:sejutacita_flutter_github/blocs/user/bloc/user_search_bloc.dart';
import 'package:sejutacita_flutter_github/screens/search_screen.dart';

import 'cache/repository_cache.dart';
import 'clients/clients.dart';
import 'repositories/repositories.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // final GithubRepository githubRepository;
  // final GithubIssue githubIssue;
  // final GithubUser githubUser;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GithubRepository>(
          create: (_) => GithubRepository(
            cache: RepositoryCache(),
            client: GithubClient(),
          ),
        ),
        RepositoryProvider<GithubIssue>(
          create: (_) => GithubIssue(
            cache: IssueCache(),
            client: GithubClient(),
          ),
        ),
        RepositoryProvider<GithubUser>(
          create: (_) => GithubUser(
            cache: UserCache(),
            client: GithubClient(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RepositorySearchBloc>(
            create: (BuildContext context) => RepositorySearchBloc(
                githubRepository: context.read<GithubRepository>()),
          ),
          BlocProvider<IssueSearchBloc>(
            create: (BuildContext context) =>
                IssueSearchBloc(githubIssue: context.read<GithubIssue>()),
          ),
          BlocProvider<UserSearchBloc>(
            create: (BuildContext context) =>
                UserSearchBloc(githubUser: context.read<GithubUser>()),
          ),
        ],
        child: MaterialApp(
          title: 'Github Search',
          home: SearchForm(),
        ),
      ),
    );
  }
}
