part of 'repository_search_bloc.dart';

abstract class RepositorySearchState extends Equatable {
  const RepositorySearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends RepositorySearchState {}

class SearchStateLoading extends RepositorySearchState {}

class SearchStateSuccess extends RepositorySearchState {
  const SearchStateSuccess(this.items);

  final List<RepositoryItem> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends RepositorySearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
