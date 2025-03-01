
import 'package:dio/dio.dart';
import 'core.dart';

/// Global instance of Dio, used for making network requests.
Dio dio = Dio();
/// Provides a configured Dio instance with the base URL set.
///
/// This ensures that all API requests use the predefined `apiUrl`
/// without the need to manually set it in every request.
///
/// Example usage:
/// ```dart
/// final response = await dioInstance.get("/endpoint");
/// `
Dio get dioInstance {
dio.options.baseUrl = apiUrl;
return dio;
}


