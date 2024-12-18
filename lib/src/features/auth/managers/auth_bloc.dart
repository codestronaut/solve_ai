import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../shared/utils/result.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial()) {
    on<_WithApple>((event, emit) async {
      emit(const AuthState.loading());
      final result = await _authRepository.signInWithApple();
      switch (result) {
        case Ok<UserCredential>():
          emit(AuthState.success(credential: result.value));
        case Error<UserCredential>():
          emit(AuthState.error(message: result.error.toString()));
      }
    });

    on<_WithGoogle>((event, emit) async {
      emit(const AuthState.loading());
      final result = await _authRepository.signInWithGoogle();
      switch (result) {
        case Ok<UserCredential>():
          emit(AuthState.success(credential: result.value));
        case Error<UserCredential>():
          emit(AuthState.error(message: result.error.toString()));
      }
    });
  }
}
