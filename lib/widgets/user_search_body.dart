import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:sejutacita_flutter_github/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sejutacita_flutter_github/blocs/user/bloc/user_search_bloc.dart'
    as user;

class UserSearchBody extends StatelessWidget {
  UserSearchBody({@required this.mode});

  final LoadMode mode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<user.UserSearchBloc, user.UserSearchState>(
      builder: (context, state) {
        if (state is user.SearchStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is user.SearchStateError) {
          return Text(state.error);
        }
        if (state is user.SearchStateSuccess) {
          return state.items.isEmpty
              ? const Text('No Results')
              : Expanded(
                  child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _UserSearchResultItem(item: state.items[index]);
                      }),
                );
        }
        return const Text('Please enter a term to begin');
      },
    );
  }
}

class _UserSearchResultItem extends StatelessWidget {
  const _UserSearchResultItem({Key key, @required this.item}) : super(key: key);

  final User item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.avatarUrl),
      ),
      title: Text(item.login),
      onTap: () async {
        if (await canLaunch(item.url)) {
          await launch(item.url);
        }
      },
    );
  }
}
