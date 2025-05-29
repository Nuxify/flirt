enum APIErrorStatus {
  unauthorized,
  typeCastingError,
  socketExceptionError,
}

extension APIErrorStatusExtension on APIErrorStatus {
  String get errorTemplate {
    switch (this) {
      case APIErrorStatus.unauthorized:
        return 'UNAUTHORIZED_ACCESS';
      case APIErrorStatus.typeCastingError:
        return 'TYPE_CASTING_ERROR';
      case APIErrorStatus.socketExceptionError:
        return 'NO_INTERNET_CONNECTION';
    }
  }

  String get errorMessage {
    switch (this) {
      case APIErrorStatus.unauthorized:
        return 'Access is unauthorized.';
      case APIErrorStatus.typeCastingError:
        return 'Type casting error occurred.';
      case APIErrorStatus.socketExceptionError:
        return 'No Internet Connection.';
    }
  }
}

final Map<String, String> httpRequestHeaders = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};
