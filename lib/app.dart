import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/preloads/preload_bloc_provider.dart';
import 'package:flutter_application_1/routes/router.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_application_1/style/themes/theme.dart';
import 'package:flutter_application_1/views/shared/layout/view_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: PreloadBlocProvider.register(context),
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: mainRouters,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return Layout(child: child ?? Container());
            },
            title: MainConfig.appName,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
