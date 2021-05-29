import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/enums/enums.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(NavigationState(
            loadMode: LoadMode.lazyLoading, searchMode: SearchMode.issue));

  void changeSearchMode(SearchMode searchMode) {
    if (searchMode != state.searchMode) {
      emit(state.copyWith(searchMode: searchMode, loadMode: state.loadMode));
    }
  }

  void changeLoadMode(LoadMode loadMode) {
    if (loadMode != state.loadMode) {
      emit(state.copyWith(searchMode: state.searchMode, loadMode: loadMode));
    }
  }
}
