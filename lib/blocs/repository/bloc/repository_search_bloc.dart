import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sejutacita_flutter_github/models/error.dart';
import 'package:sejutacita_flutter_github/models/models.dart';
import 'package:sejutacita_flutter_github/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

part 'repository_search_event.dart';
part 'repository_search_state.dart';

class RepositorySearchBloc
    extends Bloc<RepositorySearchEvent, RepositorySearchState> {
  RepositorySearchBloc({@required this.githubRepository})
      : super(SearchStateEmpty());

  final GithubRepository githubRepository;

  @override
  Stream<Transition<RepositorySearchEvent, RepositorySearchState>>
      transformEvents(
    Stream<RepositorySearchEvent> events,
    Stream<Transition<RepositorySearchEvent, RepositorySearchState>> Function(
      RepositorySearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<RepositorySearchState> mapEventToState(
      RepositorySearchEvent event) async* {
    if (event is TextChanged) {
      final searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results = await githubRepository.repositorySearch(searchTerm);
          yield SearchStateSuccess(results.items);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}
