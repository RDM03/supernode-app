class Api {
  static String url(String url,String param){
    RegExp role = new RegExp(r'{.+}');
    return url.replaceAllMapped(role, (match){
      return param;
    });
  }
}