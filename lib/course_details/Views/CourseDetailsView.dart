import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_task/base/base_stateful_widget.dart';
import 'package:flutter_course_task/base/bloc_provider.dart';
import 'package:flutter_course_task/course_details/Bloc/CourseDetailsBloc.dart';
import 'package:flutter_course_task/course_details/Model/CourseDetailsModel.dart';

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
    listenForResponse(_courseDetailsBloc).listen((onData) {
      CourseDetailsModel response = onData;
      print(response.toJson());
    });
  }

  @override
  Widget getBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder(
          stream: _courseDetailsBloc.successResponseStream,
          builder: (context, snapshot) {
            CourseDetailsModel response = snapshot.data;
            return snapshot.hasData
                ? Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        buildImageViewer(response),
                        buildInterestText(response),
                        buildTitleText(response),
                        buildDateCard(response),
                        buildAddressText(response),
                        buildDivider(),
                        buildTrainerCard(response),
                        buildTrainerInfoText(response),
                        buildDivider(),
                        buildAboutCourseTitle(),
                        buildOccasionDetailDetails(response),
                        buildDivider(),
                        addCostText(),
                        buildReserveList(response),
                        SizedBox(
                          height: 10,
                        ),
                        buildAddButton()
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildImageViewer(CourseDetailsModel response) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: response.img.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    image: new DecorationImage(
                      image: new NetworkImage(response.img[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.deepPurpleAccent,
              size: 30,
            )),
      ],
    );
  }

  Padding buildInterestText(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Text(
        response.interest,
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Padding buildTitleText(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Text(
        response.title,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Padding buildDateCard(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10.0, 0),
      child: Row(
        children: <Widget>[
          Icon(Icons.calendar_today),
          SizedBox(
            width: 5,
          ),
          Text(response.date,
              style: TextStyle(fontSize: 13, color: Colors.grey))
        ],
      ),
    );
  }

  Padding buildAddressText(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 10.0, 0),
      child: Row(
        children: <Widget>[
          Icon(Icons.place),
          SizedBox(
            width: 5,
          ),
          Text(response.address,
              style: TextStyle(fontSize: 13, color: Colors.grey))
        ],
      ),
    );
  }

  Padding buildTrainerCard(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              image: new DecorationImage(
                image: new NetworkImage(response.trainerImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(response.trainerName,
              style: TextStyle(fontSize: 13, color: Colors.grey))
        ],
      ),
    );
  }

  Padding buildTrainerInfoText(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Text(response.trainerInfo,
          style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }

  Padding buildAboutCourseTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Text(
        'عن الدورة',
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Padding buildOccasionDetailDetails(CourseDetailsModel response) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Text(response.occasionDetail,
          style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }

  Divider buildDivider() {
    return Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  Padding addCostText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
      child: Text(
        'تكلفة الدورة',
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Padding buildReserveList(CourseDetailsModel response) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 10.0, 0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: response.reservTypes.length,
            itemBuilder: (BuildContext context, int index) {
              return buildReserveItem(response, index);
            }));
  }

  Padding buildReserveItem(CourseDetailsModel response, int index) {
    ReservTypes reserveTypes = response.reservTypes[index];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 0, 0),
      child: Row(
        children: <Widget>[
          Text(reserveTypes.name),
          Spacer(),
          Text(reserveTypes.price.toString(),
              style: TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget buildAddButton() {
    return RaisedButton(
      color: Colors.deepPurpleAccent,
      child: Text(
        'قم بالحجز الان',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
