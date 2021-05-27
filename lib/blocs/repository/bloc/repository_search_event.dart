part of 'repository_search_bloc.dart';

abstract class RepositorySearchEvent extends Equatable {
  const RepositorySearchEvent();
}

class TextChanged extends RepositorySearchEvent {
  const TextChanged({@required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
