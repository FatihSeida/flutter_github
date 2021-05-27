part of 'issue_search_bloc.dart';

abstract class IssueSearchState extends Equatable {
  const IssueSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends IssueSearchState {}

class SearchStateLoading extends IssueSearchState {}

class SearchStateLoadMore extends IssueSearchState {}

class SearchStateSuccess extends IssueSearchState {
  const SearchStateSuccess(
      {this.items = const <IssueItem>[], @required this.count});

  final List<IssueItem> items;
  final int count;

  @override
  List<Object> get props => [items, count];

  @override
  String toString() =>
      'SearchStateSuccess { items: ${items.length} , count: $count }';
}

class SearchStateError extends IssueSearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
