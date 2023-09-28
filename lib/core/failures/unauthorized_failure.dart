import 'failures.dart';

class UnauthorizedException extends ServerFailure {
  @override
  final String message;

  UnauthorizedException([this.message = 'Session Expired, Please login again']) : super(message);
}
