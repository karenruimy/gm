

import 'failures.dart';

class LowPriorityException extends BaseFailure {
  @override
  final String message;

  LowPriorityException([this.message = '']) : super(message);
}
