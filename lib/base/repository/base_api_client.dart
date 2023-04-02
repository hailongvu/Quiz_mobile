import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/AppConstant.dart';

abstract class BaseAPIClient {
  final httpClient = http.Client();
  final addUrl = Uri.parse('$baseUrl/lesson');
  final updateOrGetUrl = '$baseUrl/lesson/';
  final courseUrl = Uri.parse('$baseUrl/course');
  final updateOrGetUrlCourse = '$baseUrl/course/';

  Future<Map<String, String>> getHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Map<String, String> headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    return headers;
  }

  Uri urlAccessLessonWithId(int id) {
    return Uri.parse(updateOrGetUrl + id.toString());
  }

  Uri urlAccessCourseWithId(int id) {
    return Uri.parse(updateOrGetUrlCourse + id.toString());
  }
//
// final queryParameters = {
//   'param1': 'one',
//   'param2': 'two',
// };
// final uri =
// Uri.https('www.myurl.com', '/api/v1/test', queryParameters);
// http.Client httpClient = Uri.http(authority);
// httpClient.get(url)
// final response = await http.get(uri, headers: {
//   HttpHeaders.authorizationHeader: 'Token $token',
//   HttpHeaders.contentTypeHeader: 'application/json',
// });
// }
}
