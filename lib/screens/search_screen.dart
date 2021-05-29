import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/navigation_cubit.dart';

import '../enums/enums.dart';
import '../widgets/widgets.dart';

import '../blocs/issue/widgets/issue_search_body.dart';
import '../blocs/repository/widgets/repository_search_body.dart';
import '../blocs/user/widgets/user_search_body.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Github Search'),
                )
              ],
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SearchBar(state: state),
                  SearchModeWidget(state: state),
                  LoadModeWidget(state: state),
                ],
              ),
              Expanded(
                child: state.searchMode == SearchMode.issue
                    ? IssueSearchBody(state: state)
                    : state.searchMode == SearchMode.repository
                        ? RepositorySearchBody(state: state)
                        : UserSearchBody(state: state),
              ),
            ],
          ),
        );
      },
    );
  }
}
