import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import '/repositories/repositories.dart';
import '/models/models.dart';

part 'issue_search_event.dart';
part 'issue_search_state.dart';

class IssueSearchBloc extends Bloc<IssueSearchEvent, IssueSearchState> {
  IssueSearchBloc({required this.issueRepository})
      : super(const IssueSearchState(searchTerm: "", page: 1,));

  final IssueRepository issueRepository;

  @override
  Stream<Transition<IssueSearchEvent, IssueSearchState>> transformEvents(
    Stream<IssueSearchEvent> events,
    Stream<Transition<IssueSearchEvent, IssueSearchState>> Function(
      IssueSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Stream<IssueSearchState> mapEventToState(IssueSearchEvent event) async* {
    if (event is SearchIssue) {
      yield await _mapSearchIssueToState(state, event.text, event.page);
    } else if (event is LoadMoreIssue) {
      yield await _mapLoadMoreIssueToState(state);
    } else if (event is ClearIssue) {
      yield await _mapClearIssueToState(state);
    } else if (event is NextPage) {
      yield await _mapNextPageToState(state);
    } else if (event is PreviousPage) {
      yield await _mapPreviousPageToState(state);
    }
  }

  Future<IssueSearchState> _mapSearchIssueToState(
      IssueSearchState state, String searchTerm, int page) async {
    try {
      var results;
      if (searchTerm.isNotEmpty && searchTerm != "") {
        results = await issueRepository.issueSearch(searchTerm);
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

  Future<IssueSearchState> _mapLoadMoreIssueToState(IssueSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await issueRepository.issueSearch(state.searchTerm!, page);
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

  Future<IssueSearchState> _mapClearIssueToState(IssueSearchState state) async {
    return state.copyWith(
      hasReachedMax: false,
      searchTerm: '',
      status: LoadStateStatus.empty,
      items: [],
      page: 0,
    );
  }

  Future<IssueSearchState> _mapNextPageToState(IssueSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await issueRepository.issueSearch(state.searchTerm!, page);
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

  Future<IssueSearchState> _mapPreviousPageToState(IssueSearchState state) async {
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
        results = await issueRepository.issueSearch(state.searchTerm!, page);
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
