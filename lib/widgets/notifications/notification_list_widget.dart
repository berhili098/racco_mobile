import 'package:flutter/material.dart';
import 'package:tracking_user/widgets/notifications/notification_item.dart';
import 'package:tracking_user/model/notification.dart' as notifs;

class NotificationListWidget extends StatelessWidget {
  final List<notifs.Notifications> notificationsList;

  const NotificationListWidget({
    super.key,
    required this.notificationsList,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (notificationsList.isEmpty) {
        return const Center(
            child: Text(
          "Aucune notification trouvée",
          style: TextStyle(color: Colors.black38),
        ));
      }
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notificationsList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                NotificationItemWidget(notification: notificationsList[index]),
          );
        },
      );
    });
  }
}
