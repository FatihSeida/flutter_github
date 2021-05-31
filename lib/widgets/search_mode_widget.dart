import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/navigation_cubit.dart';
import '../enums/enums.dart';

class SearchModeWidget extends StatefulWidget {
  final NavigationState state;

  const SearchModeWidget({required this.state});
  @override
  _SearchModeWidgetState createState() => _SearchModeWidgetState();
}

class _SearchModeWidgetState extends State<SearchModeWidget> {
  void _handleRadioValueChange(var value) {
    BlocProvider.of<NavigationCubit>(context).changeSearchMode(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: SearchMode.repository,
          groupValue: widget.state.searchMode,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          'Repository',
          style: TextStyle(fontSize: 16.0),
        ),
        Radio(
          value: SearchMode.issue,
          groupValue: widget.state.searchMode,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          'Issue',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Radio(
          value: SearchMode.user,
          groupValue: widget.state.searchMode,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          'User',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
