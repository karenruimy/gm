import '../failures.dart';

class ServerFailure extends BaseFailure {
  @override
  final String message;

  ServerFailure([this.message = 'Something went wrong, Please try again']) : super(message);
}
