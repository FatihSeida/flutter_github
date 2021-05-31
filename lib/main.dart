import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cache/cache.dart';
import '../blocs/issue/bloc/issue_search_bloc.dart';
import '../blocs/repository/bloc/repository_search_bloc.dart';
import '../blocs/user/bloc/user_search_bloc.dart';
import '../cubits/cubit/navigation_cubit.dart';
import '../screens/search_screen.dart';

import 'blocs/simple_bloc_observer.dart';
import 'cache/repository_cache.dart';
import 'clients/clients.dart';
import 'repositories/repositories.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RepositoryOfRepository>(
          create: (_) => RepositoryOfRepository(
            cache: RepositoryCache(),
            client: GithubClient(),
          ),
        ),
        RepositoryProvider<IssueRepository>(
          create: (_) => IssueRepository(
            cache: IssueCache(),
            client: GithubClient(),
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(
            cache: UserCache(),
            client: GithubClient(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RepositorySearchBloc>(
            create: (BuildContext context) => RepositorySearchBloc(
                repositoryOfRepository: context.read<RepositoryOfRepository>()),
          ),
          BlocProvider<IssueSearchBloc>(
            create: (BuildContext context) => IssueSearchBloc(
                issueRepository: context.read<IssueRepository>()),
          ),
          BlocProvider<UserSearchBloc>(
            create: (BuildContext context) =>
                UserSearchBloc(userRepository: context.read<UserRepository>()),
          ),
          BlocProvider<NavigationCubit>(
              create: (BuildContext context) => NavigationCubit()),
        ],
        child: MaterialApp(
          title: 'Github Search',
          theme: ThemeData(fontFamily: 'SourceSansPro'),
          home: SearchForm(),
        ),
      ),
    );
  }
}
