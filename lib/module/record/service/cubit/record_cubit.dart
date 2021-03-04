import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

import 'package:Flirt/module/record/service/cubit/record_dto.dart';
import 'package:Flirt/module/record/repository/record_repository.dart';
import 'package:Flirt/infrastructures/api/api_response.dart';
import 'package:Flirt/module/record/models/record_request.dart';
import 'package:Flirt/module/record/models/record_response.dart';

part 'record_state.dart';

/// Cubit for general Record
class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordInitial());

  final RecordRepository _recordRepository = RecordRepository();

  /// Get Record
  Future<void> fetchRecord(String id) async {
    try {
      emit(RecordLoading());

      final APIResponse<RecordResponse> response =
          await _recordRepository.fetchRecordData(id);

      emit(RecordSuccess(
          recordResponse: RecordResponseDTO(
        id: response.data.id,
        data: response.data.data,
        createdAt: response.data.createdAt,
      )));
    } catch (e) {
      final APIResponse<RecordResponse> error =
          e as APIResponse<RecordResponse>;
      emit(RecordFailed(
        errorCode: error.errorCode,
        message: error.message,
      ));
    }
  }

  /// Create Record
  Future<void> recordData(RecordRequestDTO data) async {
    try {
      emit(RecordLoading());

      final RecordRequest payload = RecordRequest(
        id: data.id,
        data: data.data,
      );

      final APIResponse<RecordResponse> response =
          await _recordRepository.createRecordData(payload);

      emit(RecordSuccess(
          recordResponse: RecordResponseDTO(
        id: response.data.id,
        data: response.data.data,
        createdAt: response.data.createdAt,
      )));
    } catch (e) {
      final APIResponse<RecordResponse> error =
          e as APIResponse<RecordResponse>;
      emit(RecordFailed(
        errorCode: error.errorCode,
        message: error.message,
      ));
    }
  }

  /// Reset State
  void resetState() {
    emit(RecordInitial());
  }
}
