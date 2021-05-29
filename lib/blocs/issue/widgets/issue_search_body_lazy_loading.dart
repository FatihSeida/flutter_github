part of 'issue_search_body.dart';

class IssueSearchBodyLazyLoading extends StatefulWidget {
  final IssueSearchState state;
  IssueSearchBodyLazyLoading({Key key, this.state}) : super(key: key);

  @override
  _IssueSearchBodyLazyLoadingState createState() =>
      _IssueSearchBodyLazyLoadingState();
}

class _IssueSearchBodyLazyLoadingState
    extends State<IssueSearchBodyLazyLoading> {
  final _scrollController = ScrollController();
  IssueSearchBloc _issueSearchBloc;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _issueSearchBloc = context.read<IssueSearchBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _issueSearchBloc.add((LoadMoreIssue(page: _page)));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= widget.state.items.length
            ? BottomLoader()
            : IssueSearchResultItem(item: widget.state.items[index]);
      },
      itemCount: widget.state.hasReachedMax
          ? widget.state.items.length
          : widget.state.items.length + 1,
      controller: _scrollController,
    );
  }
}
