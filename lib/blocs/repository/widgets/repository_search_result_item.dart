part of 'repository_search_body.dart';

class RepositorySearchResultItem extends StatelessWidget {
  const RepositorySearchResultItem({required this.item});

  final RepositoryItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
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
                  Text(
                    '${item.name}',
                    maxLines: 2,
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
