part of 'repository_search_bloc.dart';

abstract class RepositorySearchEvent extends Equatable {
  const RepositorySearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRepository extends RepositorySearchEvent {
  const SearchRepository({@required this.text, @required this.page});

  final String text;
  final int page;

  @override
  List<Object> get props => [text, page];

  @override
  String toString() => 'SearchRepository {text: $text, page: $page}';
}

class LoadMoreRepository extends RepositorySearchEvent {
  const LoadMoreRepository({@required this.page});

  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'LoadMoreRepository { page: $page }';
}

class ClearRepository extends RepositorySearchEvent {}

class NextPage extends RepositorySearchEvent {}

class PreviousPage extends RepositorySearchEvent {}
