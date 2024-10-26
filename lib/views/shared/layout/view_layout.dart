import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_application_1/views/shared/app_debugger/view_app_debugger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Layout extends StatelessWidget {
  final Widget? child;
  final AppBar? appBar;
  const Layout({
    Key? key,
    this.child,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iShowDebugger = context.watch<GlobalBloc>().state.isShowDebugger;
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider.value(
        value: BlocProvider.of<GlobalBloc>(context),
        child: SafeArea(
          child: child ?? Container(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MainConfig.debugMode && iShowDebugger
          ? const InAppDebuggerSharedWidget()
          : null,
    );
  }
}
