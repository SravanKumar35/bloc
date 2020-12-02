import 'package:colandian_mobile/blocs/notification/bloc.dart';
import 'package:colandian_mobile/common/colors.dart';
import 'package:colandian_mobile/common/texts.dart';
import 'package:colandian_mobile/widget/app_image.dart';
import 'package:colandian_mobile/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colandian_mobile/common/images.dart';
import 'package:colandian_mobile/common/app_base_widget_state.dart';

class NotificationHome extends StatefulWidget {
  static const routeName = 'NotificationWidget';
  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  @override
  void initState() {
    super.initState();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    BlocProvider.of<NotificationBloc>(context)
        .add(NotificationBlocLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<NotificationBloc, NotificationBlocState>(
        listener: (cxt, state) {
          print("state $state");
          if (state is NotificationFailureState) {
            // showToast(state.error.toString());
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: _appBar(),
          body: _body(),
        ),
      ),
    );
  }

  _appBar() {
    return CustomAppBar.get(context, appBarType: AppBarType.Normal);
  }

  _body() {
    return BlocBuilder<NotificationBloc, NotificationBlocState>(
      builder: (cxt, state) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: new Column(
              children: <Widget>[_getBanner(), _content(state)],
            ),
          ),
        );
      },
    );
  }

  Widget _getBanner() {
    return Container(
      child: Stack(
        children: <Widget>[
          new Container(
            height: 340,
            child:
                AppImage.asset(AppImages.notificationBanner, fit: BoxFit.cover),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(65.0, 210.0, 64.0, 0),
            child: Center(
              child: FittedBox(
                child: Text(
                  'Notifications',
                  style: TextStyle(
                      fontSize: 42.7,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(72.0, 280.0, 71.0, 0.0),
            child: Center(
              child: Text(
                'Get to know everything happening in Colandian',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(state) {
    if (state is NotificationBlocInitialState) {
      return Container();
    }

    if (state is NotificationBlocLoadingState) {
      return _loaderView();
    }

    if (state is NotificationFailureState) {
      return Container(
        child: FlatButton(
          onPressed: () {
            init();
          },
          child: AppText.get(AppTextScale.paragraphTag, 'Try Again'),
        ),
      );
    }

    if (state is NotificationSuccessState) {
      return Container(
        margin: EdgeInsets.only(left: 23.0, right: 24.0),
        child: ListView.builder(
          itemCount: state.notificationResponse.notifications.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(16.0, 25.0, 25.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      state.notificationResponse.notifications[index].time,
                      style: TextStyle(
                        fontFamily: 'Nunito Sans Regular',
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 8.0, 40.0, 20.0),
                    child: Text(
                      state.notificationResponse.notifications[index].msg
                          .substring(0, 40),
                      style: TextStyle(
                        fontFamily: 'Nunito Sans Regular',
                        fontSize: 17.5,
                        height: 2,
                      ),
                    ),
                  ),
                  _horizontalLine(),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  _horizontalLine() {
    return Container(
      height: 1.0,
      color: Color(0xFFDBDBDB),
    );
  }

  _loaderView() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 40),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.primaryPictonBlue),
      ),
    );
  }
}
