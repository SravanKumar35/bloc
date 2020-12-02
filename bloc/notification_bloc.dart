import 'dart:async';
import 'package:colandian_mobile/blocs/base/base_bloc.dart';
import 'package:colandian_mobile/data/model/notification_response.dart';
import 'package:colandian_mobile/data/repo/repository.dart';
import 'package:colandian_mobile/di/injector.dart';
import 'package:dio/dio.dart';

import './bloc.dart';

class NotificationBloc
    extends BaseBloc<NotificationBlocEvent, NotificationBlocState> {
  Repository _repo = Injector.resolve<Repository>();

  String time;
  String msg;

  @override
  NotificationBlocState get initialState => NotificationBlocInitialState();

  Stream<NotificationBlocState> mapEventToState(
      NotificationBlocEvent event) async* {
    print('event --> $event');

    if (event is NotificationBlocLoadingEvent) {
      Response response;
      if (event.isNotifyLoad) {
        print('yeild NotificationBlocLoadingState ');
        yield NotificationBlocLoadingState(isNotifyLoad: event.isNotifyLoad);

        try {
          response = await Dio().get(
              'https://sravankumar35.github.io/JSON-DATA/notifications.json');

          if (response.statusCode == 200) {
            yield NotificationSuccessState(
                NotificationResponse.fromJson(response.data));
          } else {
            yield NotificationFailureState(error: response.data.toString());
          }
        } on DioError catch (e) {
          yield NotificationFailureState(error: e.response.data.toString());
        }
      }
    }
  }
}
