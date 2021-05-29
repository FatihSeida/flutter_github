import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/blocs/issue/bloc/issue_search_bloc.dart';
import '/cubits/cubit/navigation_cubit.dart';
import '/enums/enums.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

part 'issue_search_body_lazy_loading.dart';
part 'issue_search_body_with_index.dart';
part 'issue_search_result_item.dart';

class IssueSearchBody extends StatefulWidget {
  final NavigationState state;

  IssueSearchBody({Key key, @required this.state}) : super(key: key);
  @override
  _IssueSearchBodyState createState() => _IssueSearchBodyState();
}

class _IssueSearchBodyState extends State<IssueSearchBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueSearchBloc, IssueSearchState>(
      builder: (context, state) {
        switch (state.status) {
          case LoadStateStatus.failed:
            return const Center(child: Text('no result'));
          case LoadStateStatus.error:
            return const Center(child: Text('failed to fetch posts'));
          case LoadStateStatus.success:
            return widget.state.loadMode == LoadMode.lazyLoading
                ? IssueSearchBodyLazyLoading(state: state)
                : IssueSearchBodyWithIndex(state: state);
          default:
            if (state.items.isEmpty) {
              return Text('Please enter term to begin');
            }
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
