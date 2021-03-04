part of 'record_cubit.dart';

@immutable
abstract class RecordState {
  const RecordState();
}

class RecordInitial extends RecordState {}

class RecordLoading extends RecordState {}

class RecordSuccess extends RecordState {
  const RecordSuccess({
    this.recordResponse,
  });

  final RecordResponseDTO recordResponse;
}

class RecordFailed extends RecordState {
  const RecordFailed({
    @required this.errorCode,
    @required this.message,
  });

  final String errorCode;
  final String message;
}
