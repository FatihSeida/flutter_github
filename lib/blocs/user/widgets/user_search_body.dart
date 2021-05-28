import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejutacita_flutter_github/blocs/user/widgets/user_search_result_item.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:sejutacita_flutter_github/models/models.dart';
import 'package:sejutacita_flutter_github/widgets/bottom_loader.dart';

import 'package:sejutacita_flutter_github/blocs/user/bloc/user_search_bloc.dart';

class UserSearchBody extends StatefulWidget {
  UserSearchBody({@required this.mode});

  final LoadMode mode;

  @override
  _UserSearchBodyState createState() => _UserSearchBodyState();
}

class _UserSearchBodyState extends State<UserSearchBody> {
  final _scrollController = ScrollController();
  UserSearchBloc _userSearchBloc;
  int page = 1;

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
      _userSearchBloc.add((LoadMoreUser(page: page)));
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
    return BlocBuilder<UserSearchBloc, UserSearchState>(
      builder: (context, state) {
        switch (state.status) {
          case LoadStateStatus.error:
            return const Center(child: Text('failed to fetch posts'));
          case LoadStateStatus.success:
            if (state.items.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return widget.mode == LoadMode.lazyLoading
                ? ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.items.length
                          ? BottomLoader()
                          : UserSearchResultItem(item: state.items[index]);
                    },
                    itemCount: state.hasReachedMax
                        ? state.items.length
                        : state.items.length + 1,
                    controller: _scrollController,
                  )
                : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return UserSearchResultItem(
                              item: state.items[index],
                            );
                          },
                          itemCount:
                              state.items.length < 10 ? state.items.length : 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(10)),
                                  ),
                                ),
                                onTap: () {
                                  _userSearchBloc.add((PreviousPage()));
                                }),
                            InkWell(
                                child: Container(
                                  margin: EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(10)),
                                  ),
                                ),
                                onTap: () {
                                  _userSearchBloc.add((NextPage()));
                                }),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              padding: EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(10)),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${state.page}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          default:
            if (state.items.isEmpty) {
              return Text('Please enter term to begin');
            }
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
