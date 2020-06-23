/// base_data
/// @author : linwentao
/// @date : 2019/11/22
abstract class AbstractBaseData<T> {
  T clone();

  void jsonConvert(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  String toJsonStr();
}
