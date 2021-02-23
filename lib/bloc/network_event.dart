part of 'network_bloc.dart';

abstract class NetworkEvent {}

class ListenConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  final NetworkState connection;
  ConnectionChanged(this.connection);
}
