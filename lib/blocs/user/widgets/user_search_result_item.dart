part of 'user_search_body.dart';

class UserSearchResultItem extends StatelessWidget {
  const UserSearchResultItem({required this.item});

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
