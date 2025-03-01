import 'package:dio/dio.dart';

/// Handles Dio exceptions and returns user-friendly error messages.
///
/// This function categorizes Dio exceptions into different types
/// and provides appropriate messages to improve error handling.
///
/// - **Connection Timeout:** When the request times out.
/// - **Receive Timeout:** When the response takes too long.
/// - **Connection Error:** When there's no internet connection.
/// - **Server Error:** When the API returns an error response.
/// - **Unexpected Error:** Any other unexpected issue.
///
/// ### Parameters:
/// - [e]: The `DioException` object representing the encountered error.
///
/// ### Returns:
/// - A `String` containing a user-friendly error message.
String handleDioError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return "Connection timed out. Please try again.";
  } else if (e.type == DioExceptionType.connectionError) {
    return "No internet connection. Please check your network.";
  } else if (e.response != null) {
    return "Server error: ${e.response?.statusCode}. Try again later.";
  } else {
    return "Unexpected error occurred. Please try again.";
  }
}
