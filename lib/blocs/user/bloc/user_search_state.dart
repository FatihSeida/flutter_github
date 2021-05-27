part of 'user_search_bloc.dart';

abstract class UserSearchState extends Equatable {
  const UserSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends UserSearchState {}

class SearchStateLoading extends UserSearchState {}

class SearchStateSuccess extends UserSearchState {
  const SearchStateSuccess(this.items);

  final List<User> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends UserSearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
