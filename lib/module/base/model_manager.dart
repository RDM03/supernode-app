import 'base_model.dart';

/// model_manager
/// @author : linwentao
/// @date : 2019/10/24
class ModelManager {
  bool _isRegister = false;

  List<BaseModel> _models = [];

  bool get localLoadComplete => _models
      .map((BaseModel element) => element.localLoadComplete)
      .reduce((value, element) => value && element);

  bool get networkLoadComplete => _models
      .map((BaseModel element) => element.networkLoadComplete)
      .reduce((value, element) => value && element);

  void register({List<dynamic> models}) {
    if (_isRegister) return;
    _isRegister = true;
    if (models == null) return;
    for (var item in models) {
      if (!_models.contains(item)) {
        _models.add(item);
      }
    }
  }

  Future<void> onLocalLoading() async {
    for (BaseModel model in _models) {
      await model.localLoad();
    }
  }

  Future<void> onNetworkDataLoading() async {
    // 网络数据加载
    await networkLoad();
  }

  Future<void> networkLoad() async {
    for (var model in _models) {
      if (!(model.networkLoadComplete ?? false)) {
        await model.connectNetLoad();
      }
    }
  }

  /// 单例
  factory ModelManager() => _getInstance();

  static ModelManager get instance => _getInstance();
  static ModelManager _instance;

  ModelManager._internal();

  static ModelManager _getInstance() {
    if (_instance == null) {
      _instance = new ModelManager._internal();
    }
    return _instance;
  }
}
