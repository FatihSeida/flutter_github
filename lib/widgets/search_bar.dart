import 'package:flutter/material.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sejutacita_flutter_github/blocs/repository/bloc/repository_search_bloc.dart'
    as repository;
import 'package:sejutacita_flutter_github/blocs/issue/bloc/issue_search_bloc.dart'
    as issue;
import 'package:sejutacita_flutter_github/blocs/user/bloc/user_search_bloc.dart'
    as user;

class SearchBar extends StatefulWidget {
  const SearchBar({@required this.mode});

  final SearchMode mode;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  repository.RepositorySearchBloc _repositorySearchBloc;
  issue.IssueSearchBloc _issueSearchBloc;
  user.UserSearchBloc _userSearchBloc;

  void _submit(String text) {
    if (widget.mode == SearchMode.Repository) {
      _repositorySearchBloc.add(
        repository.TextChanged(text: text),
      );
    } else if (widget.mode == SearchMode.Issue) {
      _issueSearchBloc.add(
        issue.TextChanged(text: text),
      );
    } else if (widget.mode == SearchMode.User) {
      _userSearchBloc.add(
        user.TextChanged(text: text),
      );
    }
  }

  void _onClearTapped() {
    _textController.text = '';
    if (widget.mode == SearchMode.Repository) {
      _repositorySearchBloc.add(const repository.TextChanged(text: ''));
    } else if (widget.mode == SearchMode.Issue) {
      _issueSearchBloc.add(const issue.TextChanged(text: ''));
    } else if (widget.mode == SearchMode.User) {
      _userSearchBloc.add(const user.TextChanged(text: ''));
    }
  }

  @override
  void initState() {
    super.initState();
    _repositorySearchBloc = context.read<repository.RepositorySearchBloc>();
    _issueSearchBloc = context.read<issue.IssueSearchBloc>();
    _userSearchBloc = context.read<user.UserSearchBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _submit(text);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: InputBorder.none,
        hintText: 'Enter a search term',
      ),
    );
  }
}
