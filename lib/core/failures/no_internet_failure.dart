import 'failures.dart';

class NoInternetFailure extends ConnectionFailure {
  @override
  final String message;

  NoInternetFailure([this.message = 'No Internet Available, Please try again!']) : super(message);
}
