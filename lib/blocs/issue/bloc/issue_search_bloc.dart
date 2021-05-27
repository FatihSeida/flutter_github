import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:sejutacita_flutter_github/repositories/repositories.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

part 'issue_search_event.dart';
part 'issue_search_state.dart';

class IssueSearchBloc extends Bloc<IssueSearchEvent, IssueSearchState> {
  IssueSearchBloc({@required this.githubIssue}) : super(SearchStateEmpty());

  final GithubIssue githubIssue;
  List<IssueItem> _items = [];
  int _currentLength;
  bool _isLastPage;
  int page = 1;
  var text;

  @override
  Stream<Transition<IssueSearchEvent, IssueSearchState>> transformEvents(
    Stream<IssueSearchEvent> events,
    Stream<Transition<IssueSearchEvent, IssueSearchState>> Function(
      IssueSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Stream<IssueSearchState> mapEventToState(IssueSearchEvent event) async* {
    if (event is TextChanged) {
      text = event.text;
      if (text.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results = await githubIssue.issueSearch(text, page);
          _items.addAll(results.items);
          yield SearchStateSuccess(items: _items, count: 0);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    } else if (event is LoadMore) {
      if (state is SearchStateSuccess) {
        _items = (state as SearchStateSuccess).items;
        _currentLength = (state as SearchStateSuccess).count;
        page++;
      }
      if (_currentLength == null || _isLastPage == null || !_isLastPage) {
        yield SearchStateLoading();
        try {
          final results = await githubIssue.issueSearch(text, page);
          if (results.isNotEmpty) {
            _items.addAll(results.items);
            if (_currentLength != null) {
              _currentLength += results.items.length;
            } else {
              _currentLength = results.items.length;
            }
          } else {
            _isLastPage = true;
          }
          yield SearchStateSuccess(items: _items, count: _currentLength);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}
