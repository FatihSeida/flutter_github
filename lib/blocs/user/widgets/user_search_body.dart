import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/user/bloc/user_search_bloc.dart';
import '/cubits/cubit/navigation_cubit.dart';
import '/enums/enums.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

part 'user_search_body_lazy_loading.dart';
part 'user_search_body_with_index.dart';
part 'user_search_result_item.dart';

class UserSearchBody extends StatefulWidget {
  final NavigationState state;

  UserSearchBody({Key key, @required this.state}) : super(key: key);
  @override
  _UserSearchBodyState createState() => _UserSearchBodyState();
}

class _UserSearchBodyState extends State<UserSearchBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSearchBloc, UserSearchState>(
      builder: (context, state) {
        switch (state.status) {
          case LoadStateStatus.failed:
            return const Center(child: Text('no result'));
          case LoadStateStatus.error:
            return const Center(child: Text('failed to fetch posts'));
          case LoadStateStatus.success:
            return widget.state.loadMode == LoadMode.lazyLoading
                ? UserSearchBodyLazyLoading(state: state)
                : UserSearchBodyWithIndex(state: state);
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
