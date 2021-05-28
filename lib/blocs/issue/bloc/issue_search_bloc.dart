import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:sejutacita_flutter_github/repositories/repositories.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

part 'issue_search_event.dart';
part 'issue_search_state.dart';

class IssueSearchBloc extends Bloc<IssueSearchEvent, IssueSearchState> {
  IssueSearchBloc({@required this.issueRepository})
      : super(const IssueSearchState());

  final IssueRepository issueRepository;

  // List<IssueItem> _items = [];
  // int _currentLength;
  // bool _isLastPage;
  // var text;

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
      if (searchTerm.isNotEmpty) {
        results = await issueRepository.issueSearch(searchTerm);
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

  Future<IssueSearchState> _mapLoadMoreIssueToState(
      IssueSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await issueRepository.issueSearch(state.searchTerm, page);
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

  Future<IssueSearchState> _mapClearIssueToState(IssueSearchState state) async {
    return state.copyWith(
        hasReachedMax: false,
        items: List.of(state.items)..clear(),
        searchTerm: '',
        status: LoadStateStatus.empty);
  }

  Future<IssueSearchState> _mapNextPageToState(IssueSearchState state) async {
    try {
      var results;
      var page = state.page;
      page++;
      if (state.status == LoadStateStatus.success) {
        results = await issueRepository.issueSearch(state.searchTerm, page);
      }
      return results.items.isEmpty
          ? state.copyWith(
              hasReachedMax: true,
              status: LoadStateStatus.hasReachMax,
              page: state.page,
              items: state.items
              )
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

  Future<IssueSearchState> _mapPreviousPageToState(
      IssueSearchState state) async {
    try {
      var results;
      var page = state.page;
      page--;
      if (state.status == LoadStateStatus.success) {
        results = await issueRepository.issueSearch(state.searchTerm, page);
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
