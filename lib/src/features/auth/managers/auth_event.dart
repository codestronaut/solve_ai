part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.withApple() = _WithApple;
  const factory AuthEvent.withGoogle() = _WithGoogle;
}
