part of 'issue_search_bloc.dart';

enum LoadStateStatus { empty, loading, loadMore, success, error, failed, hasReachMax }

class IssueSearchState extends Equatable {
  const IssueSearchState({
    this.status = LoadStateStatus.empty,
    this.items = const <IssueItem>[],
    this.hasReachedMax = false,
    this.searchTerm,
    this.page,
  });

  final String searchTerm;
  final LoadStateStatus status;
  final List<IssueItem> items;
  final bool hasReachedMax;
  final int page;

  IssueSearchState copyWith(
      {LoadStateStatus status,
      List<IssueItem> items,
      bool hasReachedMax,
      String searchTerm,
      int page,}) {
    return IssueSearchState(
      hasReachedMax: hasReachedMax,
      items: items,
      status: status,
      searchTerm: searchTerm,
      page: page,
    );
  }

  @override
  String toString() {
    return 'IssueSearchState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, searchTerm: $searchTerm, page: $page }';
  }

  @override
  List<Object> get props => [hasReachedMax, items, status, searchTerm, page];
}
