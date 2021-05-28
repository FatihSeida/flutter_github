import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:sejutacita_flutter_github/repositories/repositories.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

part 'repository_search_event.dart';
part 'repository_search_state.dart';

class RepositorySearchBloc
    extends Bloc<RepositorySearchEvent, RepositorySearchState> {
  RepositorySearchBloc({@required this.repositoryOfRepository})
      : super(const RepositorySearchState());

  final RepositoryOfRepository repositoryOfRepository;

  // List<RepositoryItem> _items = [];
  // int _currentLength;
  // bool _isLastPage;
  // var text;

  @override
  Stream<Transition<RepositorySearchEvent, RepositorySearchState>>
      transformEvents(
    Stream<RepositorySearchEvent> events,
    Stream<Transition<RepositorySearchEvent, RepositorySearchState>> Function(
      RepositorySearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Stream<RepositorySearchState> mapEventToState(
      RepositorySearchEvent event) async* {
    if (event is SearchRepository) {
      yield await _mapSearchRepositoryToState(state, event.text, event.page);
    } else if (event is LoadMoreRepository) {
      yield await _mapLoadMoreRepositoryToState(state);
    } else if (event is ClearRepository) {
      yield await _mapClearRepositoryToState(state);
    } else if (event is NextPage) {
      yield await _mapNextPageToState(state);
    } else if (event is PreviousPage) {
      yield await _mapPreviousPageToState(state);
    }
  }

  Future<RepositorySearchState> _mapSearchRepositoryToState(
      RepositorySearchState state, String searchTerm, int page) async {
    try {
      var results;
      if (searchTerm.isNotEmpty) {
        results = await repositoryOfRepository.repositorySearch(searchTerm);
      }
      return results.items.isEmpty
          ? state.copyWith(hasReachedMax: true, status: LoadStateStatus.failed)
          : state.copyWith(
              status: LoadStateStatus.success,
              items: results.items,
              searchTerm: searchTerm,
              hasReachedMax: false,
              page: page,
            );
    } on Exception {
      return state.copyWith(status: LoadStateStatus.error);
    }
  }

  Future<RepositorySearchState> _mapLoadMoreRepositoryToState(
      RepositorySearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await repositoryOfRepository.repositorySearch(
            state.searchTerm, page);
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

  Future<RepositorySearchState> _mapClearRepositoryToState(
      RepositorySearchState state) async {
    return state.copyWith(
        hasReachedMax: false,
        items: List.of(state.items)..clear(),
        searchTerm: '',
        status: LoadStateStatus.empty);
  }

  Future<RepositorySearchState> _mapNextPageToState(
      RepositorySearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await repositoryOfRepository.repositorySearch(
            state.searchTerm, page);
      }
      return results.items.isEmpty
          ? state.copyWith(
              items: state.items,
              hasReachedMax: true,
              status: LoadStateStatus.hasReachMax,
              page: state.page)
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

  Future<RepositorySearchState> _mapPreviousPageToState(
      RepositorySearchState state) async {
    try {
      var results;
      var page = state.page;
      page--;
      if (state.status == LoadStateStatus.success) {
        results = await repositoryOfRepository.repositorySearch(
            state.searchTerm, page);
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
