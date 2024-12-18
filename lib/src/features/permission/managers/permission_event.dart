part of 'permission_bloc.dart';

@freezed
class PermissionEvent with _$PermissionEvent {
  const factory PermissionEvent.get() = _Get;
  const factory PermissionEvent.ask() = _Ask;
  const factory PermissionEvent.complete() = _Complete;
}
