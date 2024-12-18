part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.get() = _Get;
  const factory ProfileEvent.updateThemeMode(ThemeMode themeMode) =
      _UpdateThemeMode;
}
