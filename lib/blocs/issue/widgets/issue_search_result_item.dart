import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:sejutacita_flutter_github/models/models.dart';

class IssueSearchResultItem extends StatelessWidget {
  const IssueSearchResultItem({Key key, @required this.item}) : super(key: key);

  final IssueItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CircleAvatar(
                maxRadius: 32,
                child: Image.network(item.user.avatarUrl),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    '${item.title}',
                    maxLines: 2,
                    minFontSize: 16,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMMMd().format(item.updatedAt),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Text(
                  item.state,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
