part of 'user_search_bloc.dart';

enum LoadStateStatus { empty, loading, loadMore, success, error, failed, hasReachMax }

class UserSearchState extends Equatable {
  const UserSearchState({
    this.status = LoadStateStatus.empty,
    this.items = const <User>[],
    this.hasReachedMax = false,
    this.searchTerm,
    this.page,
  });

  final String searchTerm;
  final LoadStateStatus status;
  final List<User> items;
  final bool hasReachedMax;
  final int page;

  UserSearchState copyWith(
      {LoadStateStatus status,
      List<User> items,
      bool hasReachedMax,
      String searchTerm,
      int page,}) {
    return UserSearchState(
      hasReachedMax: hasReachedMax,
      items: items,
      status: status,
      searchTerm: searchTerm,
      page: page,
    );
  }

  @override
  String toString() {
    return 'UserSearchState { status: $status, hasReachedMax: $hasReachedMax, items: ${items.length}, searchTerm: $searchTerm, page: $page }';
  }

  @override
  List<Object> get props => [hasReachedMax, items, status, searchTerm, page];
}
