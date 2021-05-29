part of 'repository_search_body.dart';

class RepositorySearchBodyLazyLoading extends StatefulWidget {
  final RepositorySearchState state;
  RepositorySearchBodyLazyLoading({Key key, this.state}) : super(key: key);

  @override
  _RepositorySearchBodyLazyLoadingState createState() =>
      _RepositorySearchBodyLazyLoadingState();
}

class _RepositorySearchBodyLazyLoadingState
    extends State<RepositorySearchBodyLazyLoading> {
  final _scrollController = ScrollController();
  RepositorySearchBloc _repositorySearchBloc;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _repositorySearchBloc = context.read<RepositorySearchBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _repositorySearchBloc.add((LoadMoreRepository(page: _page)));
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
            : RepositorySearchResultItem(item: widget.state.items[index]);
      },
      itemCount: widget.state.hasReachedMax
          ? widget.state.items.length
          : widget.state.items.length + 1,
      controller: _scrollController,
    );
  }
}
