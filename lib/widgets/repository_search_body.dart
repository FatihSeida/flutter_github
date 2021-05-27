import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:sejutacita_flutter_github/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sejutacita_flutter_github/blocs/repository/bloc/repository_search_bloc.dart'
    as repository;

class RepositorySearchBody extends StatelessWidget {
  RepositorySearchBody({@required this.mode});

  final LoadMode mode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<repository.RepositorySearchBloc,
        repository.RepositorySearchState>(
      builder: (context, state) {
        if (state is repository.SearchStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is repository.SearchStateError) {
          return Text(state.error);
        }
        if (state is repository.SearchStateSuccess) {
          return state.items.isEmpty
              ? const Text('No Results')
              : Expanded(
                  child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _RepositorySearchResultItem(
                            item: state.items[index]);
                      }),
                );
        }
        return const Text('Please enter a term to begin');
      },
    );
  }
}

class _RepositorySearchResultItem extends StatelessWidget {
  const _RepositorySearchResultItem({Key key, @required this.item})
      : super(key: key);

  final RepositoryItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.owner.avatarUrl),
      ),
      title: Text(item.name),
      onTap: () async {
        if (await canLaunch(item.htmlUrl)) {
          await launch(item.htmlUrl);
        }
      },
    );
  }
}
