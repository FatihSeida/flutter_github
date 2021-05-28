import 'package:flutter/material.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class UserSearchResultItem extends StatelessWidget {
  const UserSearchResultItem({Key key, @required this.item}) : super(key: key);

  final User item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: CircleAvatar(
                maxRadius: 32,
                child: Image.network(item.avatarUrl),
              ),
            ),
            Text(
              item.login,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
