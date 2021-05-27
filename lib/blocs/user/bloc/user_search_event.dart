part of 'user_search_bloc.dart';

abstract class UserSearchEvent extends Equatable {
  const UserSearchEvent();
}

class TextChanged extends UserSearchEvent {
  const TextChanged({@required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
