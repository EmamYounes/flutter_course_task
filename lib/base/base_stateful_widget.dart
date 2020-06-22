import 'package:flutter/material.dart';

import 'ErrorModel.dart';
import 'LayoutUtils.dart';
import 'api_bloc_mixin.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();

abstract class BaseStatefulWidget extends StatefulWidget {}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T>
    with RouteAware {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool resizeToAvoidBottomPadding = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutUtils.wrapWithtinLayoutDirection(Scaffold(
      floatingActionButton: getFloatingActionButton(),
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      key: getScreenKey,
      appBar: getAppbar(),
      drawer: getDrawer(),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: getBody(context)),
      bottomNavigationBar: getBottomNavigationBar(),
    ));
  }

  Stream listenForResponse(APIBlocMixin blocMixin) {
    _listenForError(blocMixin);
    return blocMixin.successStream;
  }

  _listenForError(APIBlocMixin blocMixin) {
    blocMixin.errorStream.listen((data) {
      ErrorModel error = data;
      showAppDialog('error', error.error.first);
    });
  }

  Future<void> showAppDialog(String title, String errorMessage) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return LayoutUtils.wrapWithtinLayoutDirection(AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMessage),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  Widget getDrawer() {
    return null;
  }

  Widget getBottomNavigationBar() {
    return null;
  }

  String getTitle() {
    return '';
  }

  Widget getFloatingActionButton() {
    return null;
  }

  Widget getAppbar() {
    return null;
  }

  Widget buildBackButton() {
    return null;
  }

  get getScreenKey {
    return _scaffoldKey;
  }

  Widget getBody(BuildContext context);

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void showSnack(String msg) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }
}
