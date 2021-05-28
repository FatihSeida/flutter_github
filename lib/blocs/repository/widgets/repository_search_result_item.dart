import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

import 'package:sejutacita_flutter_github/models/models.dart';

class RepositorySearchResultItem extends StatelessWidget {
  const RepositorySearchResultItem({Key key, @required this.item})
      : super(key: key);

  final RepositoryItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CircleAvatar(
                maxRadius: 32,
                child: Image.network(item.owner.avatarUrl),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AutoSizeText(
                    '${item.name}',
                    maxLines: 2,
                    minFontSize: 16,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMMMd().format(item.createdAt),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Watch',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${item.watchersCount}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Star',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${item.stargazersCount}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Fork',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${item.forksCount}'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
