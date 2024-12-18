part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    User? currentUser,
    @Default(ThemeMode.system) ThemeMode themeMode,
  }) = _ProfileState;
}
