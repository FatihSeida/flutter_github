import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:sejutacita_flutter_github/repositories/repositories.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc({@required this.userRepository})
      : super(const UserSearchState());

  final UserRepository userRepository;

  // List<UserItem> _items = [];
  // int _currentLength;
  // bool _isLastPage;
  // var text;

  @override
  Stream<Transition<UserSearchEvent, UserSearchState>> transformEvents(
    Stream<UserSearchEvent> events,
    Stream<Transition<UserSearchEvent, UserSearchState>> Function(
      UserSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Stream<UserSearchState> mapEventToState(UserSearchEvent event) async* {
    if (event is SearchUser) {
      yield await _mapSearchUserToState(state, event.text, event.page);
    } else if (event is LoadMoreUser) {
      yield await _mapLoadMoreUserToState(state);
    } else if (event is ClearUser) {
      yield await _mapClearUserToState(state);
    } else if (event is NextPage) {
      yield await _mapNextPageToState(state);
    } else if (event is PreviousPage) {
      yield await _mapPreviousPageToState(state);
    }
  }

  Future<UserSearchState> _mapSearchUserToState(
      UserSearchState state, String searchTerm, int page) async {
    try {
      var results;
      if (searchTerm.isNotEmpty) {
        results = await userRepository.userSearch(searchTerm);
      }
      return results.items.isEmpty
          ? state.copyWith(hasReachedMax: true, status: LoadStateStatus.failed)
          : state.copyWith(
              status: LoadStateStatus.success,
              items: List.of(state.items)..addAll(results.items),
              searchTerm: searchTerm,
              hasReachedMax: false,
              page: page,
            );
    } on Exception {
      return state.copyWith(status: LoadStateStatus.error);
    }
  }

  Future<UserSearchState> _mapLoadMoreUserToState(
      UserSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await userRepository.userSearch(state.searchTerm, page);
      }
      return state.copyWith(
        status: LoadStateStatus.success,
        items: List.of(state.items)..addAll(results.items),
        hasReachedMax: false,
        page: page,
        searchTerm: state.searchTerm,
      );
    } catch (error) {
      return state.copyWith(status: LoadStateStatus.error);
    }
  }

  Future<UserSearchState> _mapClearUserToState(UserSearchState state) async {
    return state.copyWith(
      hasReachedMax: false,
      items: List.of(state.items)..clear(),
      searchTerm: '',
      status: LoadStateStatus.empty
    );
  }

  Future<UserSearchState> _mapNextPageToState(UserSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await userRepository.userSearch(state.searchTerm, page);
      }
      return results.items.isEmpty
          ? state.copyWith(hasReachedMax: true,
              status: LoadStateStatus.hasReachMax,
              page: state.page,
              items: state.items)
          : state.copyWith(
              status: LoadStateStatus.success,
              items: results.items,
              page: page,
              searchTerm: state.searchTerm,
            );
    } catch (error) {
      return state.copyWith(status: LoadStateStatus.error);
    }
  }

  Future<UserSearchState> _mapPreviousPageToState(
      UserSearchState state) async {
    try {
      var results;
      var page = state.page;
      page--;
      if (state.status == LoadStateStatus.success) {
        results = await userRepository.userSearch(state.searchTerm, page);
      }
      return results.items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: LoadStateStatus.success,
              items: results.items,
              page: page,
              searchTerm: state.searchTerm,
            );
    } catch (error) {
      return state.copyWith(status: LoadStateStatus.error);
    }
  }
}
