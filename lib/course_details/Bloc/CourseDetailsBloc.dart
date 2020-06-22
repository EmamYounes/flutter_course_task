import 'package:flutter_course_task/base/ErrorModel.dart';
import 'package:flutter_course_task/base/api_bloc_mixin.dart';
import 'package:flutter_course_task/base/bloc_provider.dart';
import 'package:flutter_course_task/course_details/Model/CourseDetailsModel.dart';
import 'package:flutter_course_task/course_details/Repo/CourseDetailsRepo.dart';

class CourseDetailsBloc extends BlocBase
    with APIBlocMixin<CourseDetailsModel, ErrorModel> {
  Stream<CourseDetailsModel> get successResponseStream =>
      super.successSubject.map((onData) {
        return onData;
      });

  getDataResponse() async {
    var model = await CourseDetailsRepo().getCourseData();
    if (model is CourseDetailsModel) {
      super.successSubject.sink.add(model);
    } else {
      super.errorSubject.sink.add(model);
    }
  }

  @override
  void dispose() {}
}
