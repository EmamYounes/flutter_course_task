
import 'package:flutter/cupertino.dart';
import 'package:flutter_course_task/base/base_stateful_widget.dart';
import 'package:flutter_course_task/base/bloc_provider.dart';
import 'package:flutter_course_task/course_details/Bloc/CourseDetailsBloc.dart';

class CourseDetailsView extends BaseStatefulWidget {
  @override
  _CourseDetailsViewState createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends BaseState<CourseDetailsView> {

  CourseDetailsBloc _courseDetailsBloc;
  @override
  void initState() {
    super.initState();
    _courseDetailsBloc = BlocProvider.of<CourseDetailsBloc>(context);
    _courseDetailsBloc.getDataResponse();
    listenForResponse(_courseDetailsBloc).listen((onData){
      print(onData);
    });
  }
  @override
  Widget getBody(BuildContext context) {
    return Container();
  }
}
