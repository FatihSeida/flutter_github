part of 'issue_search_bloc.dart';

abstract class IssueSearchEvent extends Equatable {
  const IssueSearchEvent();

  @override
  List<Object> get props => [];
}

class TextChanged extends IssueSearchEvent {
  const TextChanged({@required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}

class Load extends IssueSearchEvent {}

class LoadMore extends IssueSearchEvent {}
