import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sejutacita_flutter_github/models/error.dart';
import 'package:sejutacita_flutter_github/models/models.dart';
import 'package:sejutacita_flutter_github/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

part 'user_search_event.dart';
part 'user_search_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc({@required this.githubUser}) : super(SearchStateEmpty());

  final GithubUser githubUser;

  @override
  Stream<Transition<UserSearchEvent, UserSearchState>> transformEvents(
    Stream<UserSearchEvent> events,
    Stream<Transition<UserSearchEvent, UserSearchState>> Function(
      UserSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<UserSearchState> mapEventToState(UserSearchEvent event) async* {
    if (event is TextChanged) {
      final searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
           
          final results = await githubUser.userSearch(searchTerm);
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
