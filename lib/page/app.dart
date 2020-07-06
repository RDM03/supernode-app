import 'package:flutter/widgets.dart';
import 'package:flutter_appcenter/comment/dao.dart';

class AppPage extends StatefulWidget {
  final Widget child;

  AppPage({Key key, this.child}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with WidgetsBindingObserver {  
	@override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("-didChangeAppLifecycleState-" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: 
        break;
      case AppLifecycleState.resumed:
        Dao().dio.unlock();
        break;
      case AppLifecycleState.paused:
        Dao().dio.lock();
        // Dao().dio.clear();
        // Dao().dio.close(force: true);
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
  
  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}