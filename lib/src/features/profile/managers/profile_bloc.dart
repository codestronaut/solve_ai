import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/auth/auth_repository.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;
  final SharedPreferences _preferences;
  ProfileBloc({
    required AuthRepository authRepository,
    required SharedPreferences preferences,
  })  : _authRepository = authRepository,
        _preferences = preferences,
        super(const ProfileState()) {
    on<_Get>((event, emit) {
      final currentUser = _authRepository.getCurrentUser();
      final themeModeName = _preferences.getString('solve-ai-theme-mode') ?? '';
      emit(state.copyWith(
        currentUser: currentUser,
        themeMode: ThemeMode.values.firstWhere(
          (e) => e.name == themeModeName,
          orElse: () => ThemeMode.system,
        ),
      ));
    });

    on<_UpdateThemeMode>((event, emit) async {
      await preferences.setString('solve-ai-theme-mode', event.themeMode.name);
      emit(state.copyWith(themeMode: event.themeMode));
    });
  }
}
