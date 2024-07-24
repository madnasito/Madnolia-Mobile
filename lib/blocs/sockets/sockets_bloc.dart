import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sockets_event.dart';
part 'sockets_state.dart';

class SocketsBloc extends Bloc<SocketsEvent, SocketsState> {
  SocketsBloc() : super(SocketsInitial()) {
    on<SocketsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
