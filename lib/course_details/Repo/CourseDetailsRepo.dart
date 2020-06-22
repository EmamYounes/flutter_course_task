import 'package:flutter_course_task/Network/api_constants.dart';
import 'package:flutter_course_task/Network/network.dart';
import 'package:flutter_course_task/base/BaseModel.dart';
import 'package:flutter_course_task/base/ErrorModel.dart';
import 'package:flutter_course_task/course_details/Model/CourseDetailsModel.dart';

class CourseDetailsRepo {
  Future<BaseModel> getCourseData() async {
    try {
      var response = await Network()
          .performRequest(GET_COURSE_DATA_MOCK, {}, ServerMethods.GET);
      return CourseDetailsModel.fromJson(response.data);
    } catch (e) {
      return ErrorModel().fromJson(e);
    }
  }
}
