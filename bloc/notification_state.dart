import 'package:colandian_mobile/blocs/base/base_bloc_state.dart';
import 'package:colandian_mobile/data/model/notification_model.dart';
import 'package:colandian_mobile/data/model/notification_response.dart';

abstract class NotificationBlocState extends BaseBlocState {}

class NotificationBlocInitialState extends NotificationBlocState {
  @override
  List<Object> get props => [];
}

class NotificationBlocLoadingState extends NotificationBlocState {
  final bool isNotifyLoad;
  NotificationBlocLoadingState({this.isNotifyLoad = false});
  @override
  List<Object> get props => [];
}

class NotificationSuccessState extends NotificationBlocState {
  final NotificationResponse notificationResponse;
  NotificationSuccessState(
    this.notificationResponse,
  );

  @override
  List<Object> get props => [notificationResponse];
}

class NotificationFailureState extends NotificationBlocState {
  final String error;

  NotificationFailureState({this.error});
  @override
  List<Object> get props => [];
}
