part of 'issue_search_body.dart';

class IssueSearchBodyWithIndex extends StatefulWidget {
  final IssueSearchState state;

  const IssueSearchBodyWithIndex({Key key, this.state}) : super(key: key);
  @override
  _IssueSearchBodyWithIndexState createState() =>
      _IssueSearchBodyWithIndexState();
}

class _IssueSearchBodyWithIndexState extends State<IssueSearchBodyWithIndex> {
  IssueSearchBloc _issueSearchBloc;

  @override
  void initState() {
    super.initState();
    _issueSearchBloc = context.read<IssueSearchBloc>();
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
              return IssueSearchResultItem(
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
                    _issueSearchBloc.add((PreviousPage()));
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
                    _issueSearchBloc.add((NextPage()));
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
