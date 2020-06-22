import 'package:dio/dio.dart';

class AppError extends Error {
  String errorMessage;
  AppError({this.errorMessage});
}

class NetworkError {
  AppError handleError(Exception excep) {
    String errorDescription;
    if (excep is DioError) {
      DioError error = excep;
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";

          break;

        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;

        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;

        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;

        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }

    return AppError(errorMessage: errorDescription);
  }
}
