part of 'global_bloc.dart';

@immutable
class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class EventShowDebugger extends GlobalEvent {
  final bool value;
  const EventShowDebugger(this.value);
}

class EventShowBottomModal extends GlobalEvent {
  final bool value;
  const EventShowBottomModal(this.value);
}

class EventSetDarkMode extends GlobalEvent {
  final bool value;
  const EventSetDarkMode(this.value);
}

class EvenLoadInitial extends GlobalEvent {
  const EvenLoadInitial();
}
