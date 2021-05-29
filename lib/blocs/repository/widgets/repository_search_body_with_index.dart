part of 'repository_search_body.dart';

class RepositorySearchBodyWithIndex extends StatefulWidget {
  final RepositorySearchState state;

  const RepositorySearchBodyWithIndex({Key key, this.state}) : super(key: key);
  @override
  _RepositorySearchBodyWithIndexState createState() =>
      _RepositorySearchBodyWithIndexState();
}

class _RepositorySearchBodyWithIndexState extends State<RepositorySearchBodyWithIndex> {
  RepositorySearchBloc _repositorySearchBloc;

  @override
  void initState() {
    super.initState();
    _repositorySearchBloc = context.read<RepositorySearchBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return RepositorySearchResultItem(
                item: widget.state.items[index],
              );
            },
            itemCount:
                widget.state.items.length < 10 ? widget.state.items.length : 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                  ),
                  onTap: () {
                    _repositorySearchBloc.add((PreviousPage()));
                  }),
              InkWell(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                  ),
                  onTap: () {
                    _repositorySearchBloc.add((NextPage()));
                  }),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(10)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.state.page}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
