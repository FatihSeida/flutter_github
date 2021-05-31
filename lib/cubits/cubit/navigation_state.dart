part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  const NavigationState({required this.searchMode, required this.loadMode});

  final SearchMode searchMode;
  final LoadMode loadMode;

  NavigationState copyWith({
    required SearchMode searchMode,
    required LoadMode loadMode,
  }) {
    return NavigationState(
      loadMode: loadMode,
      searchMode: searchMode,
    );
  }

  @override
  List<Object> get props => [searchMode, loadMode];
}
