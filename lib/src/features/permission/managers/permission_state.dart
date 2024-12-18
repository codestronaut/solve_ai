part of 'permission_bloc.dart';

@freezed
class PermissionState with _$PermissionState {
  const PermissionState._();
  const factory PermissionState({
    @Default(false) bool isCameraAccessGranted,
    @Default(false) bool isGalleryAccessGranted,
    @Default(false) bool isMicrophoneAccessGranted,
    @Default(false) bool isComplete,
  }) = _PermissionState;

  bool get isAllGranted {
    return isCameraAccessGranted &&
        isGalleryAccessGranted &&
        isMicrophoneAccessGranted;
  }
}
