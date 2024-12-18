import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_bloc.freezed.dart';
part 'permission_event.dart';
part 'permission_state.dart';

@injectable
class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(const PermissionState()) {
    on<_Get>((event, emit) async {
      final cameraGranted = await Permission.camera.isGranted;
      final photosGranted = await Permission.photos.isGranted;
      final microphoneGranted = await Permission.microphone.isGranted;

      emit(state.copyWith(
        isCameraAccessGranted: cameraGranted,
        isGalleryAccessGranted: photosGranted,
        isMicrophoneAccessGranted: microphoneGranted,
        isComplete: cameraGranted && photosGranted && microphoneGranted,
      ));
    });

    on<_Ask>((event, emit) async {
      final camera = await Permission.camera.request();
      emit(state.copyWith(isCameraAccessGranted: camera.isGranted));

      final photos = await Permission.photos.request();
      emit(state.copyWith(isGalleryAccessGranted: photos.isGranted));

      final microphone = await Permission.microphone.request();
      emit(state.copyWith(isMicrophoneAccessGranted: microphone.isGranted));
    });

    on<_Complete>((event, emit) {
      emit(state.copyWith(isComplete: true));
    });
  }
}
