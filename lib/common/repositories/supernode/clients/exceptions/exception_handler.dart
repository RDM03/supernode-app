import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/exceptions/un_authorized_exception.dart';

class ExceptionHandler {
  static ExceptionHandler _singleton;

  static ExceptionHandler getInstance() {
    if (_singleton == null) {
      _singleton = ExceptionHandler._();
    }
    return _singleton;
  }

  ExceptionHandler._();

  void showError(e) {
    if (e is UnAuthorizedException) {
      tip(e.message);
    }
  }
}
