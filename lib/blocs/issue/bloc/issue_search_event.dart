part of 'issue_search_bloc.dart';

abstract class IssueSearchEvent extends Equatable {
  const IssueSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchIssue extends IssueSearchEvent {
  const SearchIssue({required this.text, required this.page});

  final String text;
  final int page;

  @override
  List<Object> get props => [text, page];

  @override
  String toString() => 'SearchIssue {text: $text, page: $page}';
}

class LoadMoreIssue extends IssueSearchEvent {
  const LoadMoreIssue({required this.page});

  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'LoadMoreIssue { page: $page }';
}

class ClearIssue extends IssueSearchEvent {}

class NextPage extends IssueSearchEvent {}

class PreviousPage extends IssueSearchEvent {}
