import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/blocs/repository/bloc/repository_search_bloc.dart';
import '/cubits/cubit/navigation_cubit.dart';
import '/enums/enums.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

part 'repository_search_body_lazy_loading.dart';
part 'repository_search_body_with_index.dart';
part 'repository_search_result_item.dart';

class RepositorySearchBody extends StatefulWidget {
  final NavigationState state;

  RepositorySearchBody({Key key, @required this.state}) : super(key: key);
  @override
  _RepositorySearchBodyState createState() => _RepositorySearchBodyState();
}

class _RepositorySearchBodyState extends State<RepositorySearchBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositorySearchBloc, RepositorySearchState>(
      builder: (context, state) {
        switch (state.status) {
          case LoadStateStatus.failed:
            return const Center(child: Text('no result'));
          case LoadStateStatus.error:
            return const Center(child: Text('failed to fetch posts'));
          case LoadStateStatus.success:
            return widget.state.loadMode == LoadMode.lazyLoading
                ? RepositorySearchBodyLazyLoading(state: state)
                : RepositorySearchBodyWithIndex(state: state);
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
