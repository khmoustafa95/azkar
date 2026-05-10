part of 'duaa_cubit.dart';

@immutable
abstract class DuaaState {}

class DuaaInitial extends DuaaState {}

class DuaaSuccess extends DuaaState {
  final List<DuaaModel> duaas;

  DuaaSuccess(this.duaas);
}
