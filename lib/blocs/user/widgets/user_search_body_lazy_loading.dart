part of 'user_search_body.dart';

class UserSearchBodyLazyLoading extends StatefulWidget {
  final UserSearchState state;
  UserSearchBodyLazyLoading({required this.state});

  @override
  _UserSearchBodyLazyLoadingState createState() =>
      _UserSearchBodyLazyLoadingState();
}

class _UserSearchBodyLazyLoadingState
    extends State<UserSearchBodyLazyLoading> {
  final _scrollController = ScrollController();
  late UserSearchBloc _userSearchBloc;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _userSearchBloc = context.read<UserSearchBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _userSearchBloc.add((LoadMoreUser(page: _page)));
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
        return index >= widget.state.items!.length
            ? BottomLoader()
            : UserSearchResultItem(item: widget.state.items![index]);
      },
      itemCount: widget.state.hasReachedMax!
          ? widget.state.items!.length
          : widget.state.items!.length + 1,
      controller: _scrollController,
    );
  }
}
