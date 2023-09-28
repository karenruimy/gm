
import 'failures.dart';

class HighPriorityException extends BaseFailure {
  @override
  final String message;

  const HighPriorityException([this.message = '']);
}
