part of 'global_bloc.dart';

@immutable
class GlobalState extends Equatable {
  final bool isShowDebugger;
  final bool isShowBottomModal;
  final bool isDarkMode;

  const GlobalState({
    this.isShowDebugger = false,
    this.isShowBottomModal = false,
    this.isDarkMode = false,
  });

  GlobalState copyWith({
    bool? isShowDebugger,
    bool? isShowBottomModal,
    bool? isDarkMode,
  }) =>
      GlobalState(
        isShowDebugger: isShowDebugger ?? this.isShowDebugger,
        isShowBottomModal: isShowBottomModal ?? this.isShowBottomModal,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  @override
  List<Object?> get props => [isShowDebugger, isShowBottomModal, isDarkMode];
}

final class GlobalInitial extends GlobalState {}
