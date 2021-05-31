part of 'issue_search_body.dart';

class IssueSearchResultItem extends StatelessWidget {
  const IssueSearchResultItem({required this.item});

  final IssueItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
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
                  Text(
                    '${item.title}',
                    maxLines: 2,
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
