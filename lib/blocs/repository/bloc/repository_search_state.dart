part of 'repository_search_bloc.dart';

enum LoadStateStatus { empty, loading, loadMore, success, error, failed}

class RepositorySearchState extends Equatable {
  const RepositorySearchState({
    this.status = LoadStateStatus.empty,
    this.items = const <RepositoryItem>[],
    this.hasReachedMax = false,
    this.searchTerm,
    this.page,
  });

  final String searchTerm;
  final LoadStateStatus status;
  final List<RepositoryItem> items;
  final bool hasReachedMax;
  final int page;

  RepositorySearchState copyWith(
      {LoadStateStatus status,
      List<RepositoryItem> items,
      bool hasReachedMax,
      String searchTerm,
      int page,}) {
    return RepositorySearchState(
      hasReachedMax: hasReachedMax,
      items: items,
      status: status,
      searchTerm: searchTerm,
      page: page,
    );
  }

  @override
  String toString() {
    return 'RepositorySearchState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, searchTerm: $searchTerm, page: $page }';
  }

  @override
  List<Object> get props => [hasReachedMax, items, status, searchTerm, page];
}
