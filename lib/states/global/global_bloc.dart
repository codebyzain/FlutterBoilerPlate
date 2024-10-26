// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/utils/util_logger.dart';
import 'package:flutter_application_1/utils/util_session.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:meta/meta.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalInitial()) {
    on<EventShowDebugger>(_handleOpenDebugger);
    on<EventShowBottomModal>(_handleOpenBottomModal);
    on<EventSetDarkMode>(_handleSetDarkMode);
    on<EvenLoadInitial>(_handleLoadInitial);
  }

  // Loaded Theme
  _handleLoadInitial(EvenLoadInitial event, emit) async {
    final darkMode = await AppSession.get(MainConfig.appThemeSessionName);
    AppLogger.log("isDarkMode : $darkMode");
    emit(state.copyWith(isDarkMode: darkMode == "true" ? true : false));
    // IMPORTANT: Remove splashscreen after
    // Remove splash screen
    FlutterNativeSplash.remove();
  }

  // Open app debugger
  _handleOpenDebugger(EventShowDebugger event, emit) {
    emit(state.copyWith(isShowDebugger: event.value));
  }

  // Open Bottom Modal
  _handleOpenBottomModal(EventShowBottomModal event, emit) {
    emit(state.copyWith(isShowBottomModal: event.value));
  }

  // Change Dark Mode
  _handleSetDarkMode(EventSetDarkMode event, emit) {
    AppSession.store(
      MainConfig.appThemeSessionName,
      event.value == true ? "true" : "false",
    );
    emit(state.copyWith(isDarkMode: event.value));
  }
}
