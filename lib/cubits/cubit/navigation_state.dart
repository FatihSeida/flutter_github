part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  const NavigationState({this.searchMode, this.loadMode});

  final SearchMode searchMode;
  final LoadMode loadMode;

  NavigationState copyWith({
    SearchMode searchMode,
    LoadMode loadMode,
  }) {
    return NavigationState(
      loadMode: loadMode,
      searchMode: searchMode,
    );
  }

  @override
  List<Object> get props => [searchMode, loadMode];
}
