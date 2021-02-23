import 'package:Flirt/module/record/repository/record_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:NuximartPOS/module/auth/service/cubit/login/login_dto.dart';
import 'package:NuximartPOS/module/auth/repository/auth_repository.dart';
import 'package:NuximartPOS/infrastructures/api/api_response.dart';
import 'package:NuximartPOS/module/auth/models/auth_request.dart';
import 'package:NuximartPOS/module/auth/models/auth_response.dart';

part 'record_state.dart';

/// Cubit for general Login
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthRepository _authRepository = AuthRepository();

  /// User login
  Future<void> login(LoginRequestDTO data, String deviceId) async {
    try {
      emit(LoginLoading());

      final LoginRequest payload =
          LoginRequest(code: data.code, password: data.password);
      final APIResponse<LoginResponse> response =
          await _authRepository.login(payload, deviceId);

      // save to secure storage
      try {
        storeAccessToken(response.data);
      } catch (e) {
        emit(LoginFailed('STORAGE_ERROR', e as String));
        return;
      }

      emit(LoginSuccess(
          LoginResponseDTO(accessToken: response.data.accessToken)));
    } catch (e) {
      final APIResponse<LoginResponse> error = e as APIResponse<LoginResponse>;
      emit(LoginFailed(error.errorCode, error.message));
    }
  }

  /// Stores access token to Keystore using FlutterSecureStorage() package
  Future<void> storeAccessToken(LoginResponse data) async {
    try {
      const FlutterSecureStorage _storage = FlutterSecureStorage();
      await _storage.write(key: 'accessToken', value: data.accessToken);
    } catch (err) {
      throw 'Error while saving token';
    }
  }
}
