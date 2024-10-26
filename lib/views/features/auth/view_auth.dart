import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_application_1/views/shared/button/widget_button.dart';
import 'package:flutter_application_1/views/shared/layout/view_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAuth extends StatelessWidget {
  const ViewAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Button(
            "Open Debugger",
            marginVertical: 10,
            shape: ButtonShape.round,
            iconName: Icons.opacity,
            marginHorizontal: 20,
            onPress: () {
              context.read<GlobalBloc>().add(const EventShowDebugger(true));
            },
          ),
        ],
      ),
    );
  }
}
