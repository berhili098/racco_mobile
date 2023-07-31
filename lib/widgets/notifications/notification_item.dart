import 'package:another_flushbar/flushbar.dart';
import 'package:iconly/iconly.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/model/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_user/widgets/affectations/icon_cercle_widget.dart';
import 'package:tracking_user/widgets/affectations/client_info_modal_widget.dart';
import 'package:tracking_user/model/notification.dart' as notifs;

class NotificationItemWidget extends StatelessWidget {
  final notifs.Notifications notification;

  const NotificationItemWidget({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // height: 120.w,

        padding: EdgeInsets.symmetric(vertical: 15.w),

        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                offset: Offset(0, 0),
                blurRadius: 15)
          ],
          color: Color.fromRGBO(251, 251, 251, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconCercleWidgt(icon: IconlyBold.notification, size: 55.w),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          notification.title ?? '',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 15,
                            child: Text(
                              '',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.data ?? '',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),


                        Visibility(
                          visible:            notification.title == "Modification"
                            ,
                          child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child:  Icon(
                                  IconlyBroken.edit_square,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
