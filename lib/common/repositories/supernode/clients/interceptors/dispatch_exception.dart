import 'package:supernodeapp/common/repositories/shared/clients/client.dart';

class PermissionDeniedException extends HttpException {
  PermissionDeniedException(message, code, [innerStack])
      : super(message, code, innerStack);

  @override
  String toString() {
    return '$message';
  }
}

class UnAuthorizedException extends HttpException {
  UnAuthorizedException(message, code, [innerStack])
      : super(message, code, innerStack);

  @override
  String toString() {
    return '$message';
  }
}

class UnHandleException extends HttpException {
  UnHandleException(message, code, [innerStack])
      : super(message, code, innerStack);
}

Exception dispatchException(String message, int code, StackTrace innerStack) {
  switch (code) {
    case 7: //Gateway already registered
      return PermissionDeniedException(message, code, innerStack);
    case 13: // username can not be found
    case 16: // password is wrong
      // 2FA totp-status
      return UnAuthorizedException(message, code, innerStack);
    default:
      return UnHandleException(message, code, innerStack);
  }
}
