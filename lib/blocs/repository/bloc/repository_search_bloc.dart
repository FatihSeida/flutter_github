import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import '/repositories/repositories.dart';
import '/models/models.dart';

part 'repository_search_event.dart';
part 'repository_search_state.dart';

class RepositorySearchBloc
    extends Bloc<RepositorySearchEvent, RepositorySearchState> {
  RepositorySearchBloc({@required this.repositoryOfRepository})
      : super(const RepositorySearchState());

  final RepositoryOfRepository repositoryOfRepository;

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
      if (searchTerm.isNotEmpty && searchTerm != "") {
        results = await repositoryOfRepository.repositorySearch(searchTerm);
      } else {
        return state.copyWith(status: LoadStateStatus.empty, items: []);
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
      searchTerm: '',
      status: LoadStateStatus.empty,
      items: [],
      page: 0,
    );
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
      return state.copyWith(status: LoadStateStatus.error);
    }
  }

  Future<RepositorySearchState> _mapPreviousPageToState(
      RepositorySearchState state) async {
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
        results = await repositoryOfRepository.repositorySearch(
            state.searchTerm, page);
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
      return state.copyWith(status: LoadStateStatus.error);
    }
  }
}
