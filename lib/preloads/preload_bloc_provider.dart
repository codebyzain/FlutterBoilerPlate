import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreloadBlocProvider {
  static register(BuildContext context) {
    return [
      BlocProvider<GlobalBloc>(
        create: (BuildContext context) => GlobalBloc()
          ..add(
            const EvenLoadInitial(),
          ),
        lazy: false,
      ),
      // Register other providers here...
    ];
  }
}
