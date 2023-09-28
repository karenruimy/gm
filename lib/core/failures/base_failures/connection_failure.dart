import '../failures.dart';

class ConnectionFailure extends BaseFailure {
  @override
  final String message;

  ConnectionFailure([this.message = 'Please check your connection and try again']) : super(message);
}
