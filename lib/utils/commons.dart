import 'package:vacancies_app/api/api.dart';

url_format(String url) {
  return url.replaceFirst(CallApi.url, '');
}