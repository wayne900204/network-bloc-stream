import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';

part 'network_state.dart';
part 'network_event.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitial());
  StreamSubscription _subscription;
  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event,) async* {
    // TODO: implement mapEventToState
    if (event is ListenConnection) {
      _subscription = DataConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status == DataConnectionStatus.disconnected
            ? ConnectionFailure()
            : ConnectionSuccess()));
      });
    }
    if (event is ConnectionChanged) yield event.connection;
  }


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
