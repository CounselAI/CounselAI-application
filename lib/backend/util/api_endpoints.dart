class ApiEndPoints {
  static const String baseUrl = "http://10.0.2.2:8080/v1/users";
  // integrating a CORS authentication service written in Go
  // ignore: library_private_types_in_public_api
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String sendOTP = '/send-otp';
  final String verifyOTP = '/verify-otp';
  final String resendOTP = '/resend-otp';
}
