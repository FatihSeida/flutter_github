import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/navigation_cubit.dart';
import '../enums/enums.dart';
import '../widgets/widgets.dart';

class LoadModeWidget extends StatefulWidget {
  final NavigationState state;

  LoadModeWidget({required this.state});

  @override
  _LoadModeWidgetState createState() => _LoadModeWidgetState();
}

class _LoadModeWidgetState extends State<LoadModeWidget> {
  void _handleLoadModeValueChange(var value) {
    BlocProvider.of<NavigationCubit>(context).changeLoadMode(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            InkWell(
                splashColor: Colors.blueAccent,
                onTap: () => _handleLoadModeValueChange(LoadMode.lazyLoading),
                child: RadioItem(
                  buttonText: 'Lazy Loading',
                  isSelected: widget.state.loadMode == LoadMode.lazyLoading
                      ? true
                      : false,
                )),
            InkWell(
                splashColor: Colors.blueAccent,
                onTap: () => _handleLoadModeValueChange(LoadMode.withIndex),
                child: RadioItem(
                  buttonText: 'With Index',
                  isSelected: widget.state.loadMode == LoadMode.withIndex
                      ? true
                      : false,
                )),
          ],
        );
      },
    );
  }
}
