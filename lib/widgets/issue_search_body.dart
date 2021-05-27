import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:sejutacita_flutter_github/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sejutacita_flutter_github/blocs/issue/bloc/issue_search_bloc.dart';

class IssueSearchBody extends StatefulWidget {
  IssueSearchBody({@required this.mode});

  final LoadMode mode;

  @override
  _IssueSearchBodyState createState() => _IssueSearchBodyState();
}

class _IssueSearchBodyState extends State<IssueSearchBody> {
  IssueSearchBloc _issueSearchBloc;
  int _currentLength;
  List<IssueItem> items = [];

  @override
  void initState() {
    super.initState();
    _issueSearchBloc = context.read<IssueSearchBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadMoreData() {
    _issueSearchBloc.add(LoadMore());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueSearchBloc, IssueSearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess || state is SearchStateLoadMore) {
          if (state is SearchStateSuccess) {
            items = state.items;
            _currentLength = state.count;
          }
          return items.isEmpty
              ? const Text('No Results')
              : _buildIssueSearch(state);
        }
        return const Text('Please enter a term to begin');
      },
    );
  }

  Widget _buildIssueSearch(IssueSearchState state) {
    return LazyLoadScrollView(
      child: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _IssueSearchResultItem(item: items[index]);
              }),
          (state is SearchStateLoadMore)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ],
      ),
      onEndOfPage: _loadMoreData,
    );
  }
}

class _IssueSearchResultItem extends StatelessWidget {
  const _IssueSearchResultItem({Key key, @required this.item})
      : super(key: key);

  final IssueItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: item.user.avatarUrl == null
            ? Image.asset('assets/images/profile.png')
            : Image.network(item.user.avatarUrl),
      ),
      title: item.title == null ? Text('No Title') : Text(item.title),
      onTap: () async {
        if (await canLaunch(item.url)) {
          await launch(item.url);
        }
      },
    );
  }
}
