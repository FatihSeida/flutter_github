import 'package:flutter/material.dart';
import 'package:sejutacita_flutter_github/enums/enums.dart';
import 'package:sejutacita_flutter_github/widgets/custom_radio.dart';
import 'package:sejutacita_flutter_github/widgets/widgets.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  var _mode = SearchMode.issue;
  var _loadMode = LoadMode.lazyLoading;

  void _handleRadioValueChange(var value) {
    setState(() {
      _mode = value;
    });
  }

  void _handleLoadModeValueChange(var value) {
    setState(() {
      _loadMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Text('Github Search'),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              SearchBar(mode: _mode),
              Row(
                children: <Widget>[
                  Radio(
                    value: SearchMode.repository,
                    groupValue: _mode,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(
                    'Repository',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                    value: SearchMode.issue,
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
                    value: SearchMode.user,
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
                      onTap: () =>
                          _handleLoadModeValueChange(LoadMode.lazyLoading),
                      child: RadioItem(
                        buttonText: 'Lazy Loading',
                        isSelected:
                            _loadMode == LoadMode.lazyLoading ? true : false,
                      )),
                  InkWell(
                      splashColor: Colors.blueAccent,
                      onTap: () =>
                          _handleLoadModeValueChange(LoadMode.withIndex),
                      child: RadioItem(
                        buttonText: 'With Index',
                        isSelected:
                            _loadMode == LoadMode.withIndex ? true : false,
                      )),
                ],
              ),
            ],
          ),
          Expanded(
            child: _mode == SearchMode.issue
                ? IssueSearchBody(mode: _loadMode)
                : _mode == SearchMode.repository
                    ? RepositorySearchBody(mode: _loadMode)
                    : UserSearchBody(mode: _loadMode),
          )
        ],
      ),
    );
  }
}
