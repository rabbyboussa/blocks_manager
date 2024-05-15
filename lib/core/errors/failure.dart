abstract class Failure {
  const Failure({
    required this.statusCode,
    required this.message,
  });
  final int statusCode;
  final String message;
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.statusCode,
    required super.message,
  });
}
