import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import '/repositories/repositories.dart';
import '/models/models.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc({required this.userRepository})
      : super(const UserSearchState(searchTerm: "", page: 1,));

  final UserRepository userRepository;

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
      if (searchTerm.isNotEmpty && searchTerm != "") {
        results = await userRepository.userSearch(searchTerm);
      } else {
        return state.copyWith(status: LoadStateStatus.empty, items: [], searchTerm: "",page: 1,);
      }
      return results.items.isEmpty
          ? state.copyWith(hasReachedMax: true, status: LoadStateStatus.failed, items: [], page: 1, searchTerm: '')
          : state.copyWith(
              status: LoadStateStatus.success,
              items: List.of(state.items!)..addAll(results.items),
              searchTerm: searchTerm,
              hasReachedMax: false,
              page: page,
            );
    } on Exception {
      return state.copyWith(status: LoadStateStatus.error, page: 1);
    }
  }

  Future<UserSearchState> _mapLoadMoreUserToState(UserSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await userRepository.userSearch(state.searchTerm!, page);
      }
      return state.copyWith(
        status: LoadStateStatus.success,
        items: List.of(state.items!)..addAll(results.items),
        hasReachedMax: false,
        page: page,
        searchTerm: state.searchTerm,
      );
    } catch (error) {
      return state.copyWith(status: LoadStateStatus.error, page: 1);
    }
  }

  Future<UserSearchState> _mapClearUserToState(UserSearchState state) async {
    return state.copyWith(
      hasReachedMax: false,
      searchTerm: '',
      status: LoadStateStatus.empty,
      items: [],
      page: 0,
    );
  }

  Future<UserSearchState> _mapNextPageToState(UserSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await userRepository.userSearch(state.searchTerm!, page);
      }
      return results.items.isEmpty
          ? state.copyWith(
              hasReachedMax: true,
              status: LoadStateStatus.success,
              page: state.page,
              items: state.items,
              searchTerm: state.searchTerm,
            )
          : state.copyWith(
              status: LoadStateStatus.success,
              items: results.items,
              page: page,
              searchTerm: state.searchTerm,
              hasReachedMax: true);
    } catch (error) {
      return state.copyWith(status: LoadStateStatus.error, page: 1);
    }
  }

  Future<UserSearchState> _mapPreviousPageToState(UserSearchState state) async {
    try {
      var results;
      var page = state.page;
      if (page <= 1) {
        return state.copyWith(
          hasReachedMax: true,
          status: LoadStateStatus.success,
          page: state.page,
          items: state.items,
          searchTerm: state.searchTerm,
        );
      }
      if (state.status == LoadStateStatus.success && page > 1) {
        page--;
        results = await userRepository.userSearch(state.searchTerm!, page);
      }
      return results.items.isEmpty
          ? state.copyWith(
              hasReachedMax: true,
              status: LoadStateStatus.success,
              page: state.page,
              items: state.items,
              searchTerm: state.searchTerm,
            )
          : state.copyWith(
              status: LoadStateStatus.success,
              items: results.items,
              page: page,
              searchTerm: state.searchTerm,
              hasReachedMax: true);
    } catch (error) {
      return state.copyWith(status: LoadStateStatus.error, items: [], page: 1, searchTerm: '');
    }
  }
}
