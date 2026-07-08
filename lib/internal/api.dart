enum APIErrorStatus {
  unauthorized,
  serverError,
  typeCastingError,
  socketExceptionError,
  timeoutError,
}

extension APIErrorStatusExtension on APIErrorStatus {
  String get errorTemplate {
    switch (this) {
      case APIErrorStatus.unauthorized:
        return 'UNAUTHORIZED_ACCESS';
      case APIErrorStatus.serverError:
        return 'SERVER_ERROR';
      case APIErrorStatus.typeCastingError:
        return 'TYPE_CASTING_ERROR';
      case APIErrorStatus.socketExceptionError:
        return 'NO_INTERNET_CONNECTION';
      case APIErrorStatus.timeoutError:
        return 'REQUEST_TIMEOUT';
    }
  }

  String get errorMessage {
    switch (this) {
      case APIErrorStatus.unauthorized:
        return 'Access is unauthorized. (ERR-AUTH-1)';
      case APIErrorStatus.serverError:
        return 'Server error occurred. (ERR-NET-1)';
      case APIErrorStatus.typeCastingError:
        return 'Type casting error occurred. (ERR-DAT-1)';
      case APIErrorStatus.socketExceptionError:
        return 'No Internet Connection. (ERR-NET-3)';
      case APIErrorStatus.timeoutError:
        return 'Request timed out. Please try again. (ERR-NET-2)';
    }
  }
}

final Map<String, String> httpRequestHeaders = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};
