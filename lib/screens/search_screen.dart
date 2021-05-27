import 'package:flutter/material.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:sejutacita_flutter_github/widgets/custom_radio.dart';
import 'package:sejutacita_flutter_github/widgets/widgets.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  var _mode = SearchMode.Issue;
  var _loadMode = LoadMode.LazyLoading;

  void _handleRadioValueChange(var value) {
    setState(() {
      _mode = value;
    });
  }

  void _handleLoadModeValueChange(var value) {
    setState(() {
      _mode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Github Search')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              SearchBar(mode: _mode),
              Row(
                children: <Widget>[
                  Radio(
                    value: SearchMode.Repository,
                    groupValue: _mode,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(
                    'Repository',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: SearchMode.Issue,
                    groupValue: _mode,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(
                    'Issue',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Radio(
                    value: SearchMode.User,
                    groupValue: _mode,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(
                    'User',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  InkWell(
                      splashColor: Colors.blueAccent,
                      onTap: () => _handleLoadModeValueChange,
                      child: RadioItem(
                        buttonText: 'Lazy Loading',
                        isSelected:
                            _loadMode == LoadMode.LazyLoading ? true : false,
                      )),
                  InkWell(
                      splashColor: Colors.blueAccent,
                      onTap: () => _handleLoadModeValueChange,
                      child: RadioItem(
                        buttonText: 'With Index',
                        isSelected:
                            _loadMode == LoadMode.WithIndex ? true : false,
                      )),
                ],
              ),
            ],
          ),
          Expanded(
            child: _mode == SearchMode.Issue
                ? IssueSearchBody(mode: _loadMode)
                : _mode == SearchMode.Repository
                    ? RepositorySearchBody(mode: _loadMode)
                    : UserSearchBody(mode: _loadMode),
          )
        ],
      ),
    );
  }
}
