import 'package:colandian_mobile/blocs/base/base_bloc_event.dart';

abstract class NotificationBlocEvent extends BaseBlocEvent {}

class NotificationBlocLoadingEvent extends NotificationBlocEvent {
  final bool isNotifyLoad;

  NotificationBlocLoadingEvent({this.isNotifyLoad = false});
  @override
  List<Object> get props => [];
}

// class NotificationEventFetch extends BaseBlocEvent {
//   final String time;
//   final String msg;

//   NotificationEventFetch({this.time, this.msg});

//   @override
//   List<Object> get props => [
//         this.time,
//         this.msg,
//       ];
// }
