import 'package:dio/dio.dart';
import 'dart:async';

/*
 * 封装 dio 请求
 * 
 * 参考1：https://www.jianshu.com/p/4e00399f580a
 * 参考2：https://github.com/flutterchina/dio/blob/master/example/test.dart
 */
class HttpUtil {

  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'http://192.168.43.57:8091';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Future request(String url, { data, method }) async {
    try {
      // clear ();
      Dio dio = createInstance();
      // dio.interceptors.add(LogInterceptor(responseBody: true));

      data = data ?? {};
      method = method ?? 'GET';

      var response = await dio.request(url, 
          queryParameters: data,
          // data: data,
          options: new Options(method: method)
          // options: Options(contentType: Headers.jsonContentType, headers: {"Content-Type": "application/json"})
      );
      return response; 
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }
  }

  /// 创建 dio 实例对象
  static Dio createInstance () {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions options = new BaseOptions(
          baseUrl: API_PREFIX,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = new Dio(options);
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear () {
    dio = null;
  }

}