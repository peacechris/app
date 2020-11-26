import 'package:flutter/material.dart';

// import '../design_course/course_info_screen.dart';
import '../fitness_app/post_detail/post_detail.dart';


//配置路由
final routes={
  //无参数：
  // '/course':(context)=>CourseInfoScreen(),
  //有参数：
  '/post-detail':(context, {arguments})=>PostDetail(arguments: arguments),
};

//固定写法
var onGenerateRoute=(RouteSettings settings) {
      // 统一处理
      final String name = settings.name; 
      final Function pageContentBuilder = routes[name];
      if (pageContentBuilder != null) {
        if (settings.arguments != null) {
          final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context, arguments: settings.arguments));
          return route;
        }else{
            final Route route = MaterialPageRoute(
              builder: (context) =>
                  pageContentBuilder(context));
            return route;
        }
      }
};