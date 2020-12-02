import 'dart:convert';

import 'package:colandian_mobile/data/model/notification_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationResponse {
  NotificationResponse({@required this.notifications});

  List<NotificationModel> notifications;

  factory NotificationResponse.fromJson(json) {
    List<NotificationModel> notifications;
    var jsonbody = jsonDecode(json);
    for (var v in jsonbody) {
      NotificationModel notification =
          NotificationModel(time: v['time'], msg: v['msg']);
      notifications.add(notification);
    }
    return NotificationResponse(notifications: notifications);
  }
}
