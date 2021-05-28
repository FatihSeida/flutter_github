import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  void changeSearchMode(SearchMode searchMode) {}

  void changeLoadMode(LoadMode loadMode) {}
}
