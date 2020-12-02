class NotificationModel {
  final String time;
  final String msg;

  const NotificationModel({this.time, this.msg});

  @override
  List<Object> get props => [time, msg];
}
