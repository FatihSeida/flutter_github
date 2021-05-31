part of 'user_search_bloc.dart';

abstract class UserSearchEvent extends Equatable {
  const UserSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUser extends UserSearchEvent {
  const SearchUser({required this.text, required this.page});

  final String text;
  final int page;

  @override
  List<Object> get props => [text, page];

  @override
  String toString() => 'SearchUser {text: $text, page: $page}';
}

class LoadMoreUser extends UserSearchEvent {
  const LoadMoreUser({required this.page});

  final int page;

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'LoadMoreUser { page: $page }';
}

class ClearUser extends UserSearchEvent {}

class NextPage extends UserSearchEvent {}

class PreviousPage extends UserSearchEvent {}
