import 'package:another_flushbar/flushbar.dart';
import 'package:iconly/iconly.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/model/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_user/widgets/affectations/icon_cercle_widget.dart';
import 'package:tracking_user/widgets/affectations/client_info_modal_widget.dart';
import 'package:intl/intl.dart';

class AffectationItemWidget extends StatelessWidget {
  final Affectations affectation;
  final bool showInfoIcon;
  final void Function()? onTap;
  const AffectationItemWidget(
      {super.key,
      required this.affectation,
      required this.showInfoIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120.w,
        alignment: Alignment.center,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconCercleWidgt(icon: IconlyBold.profile, size: 55.w),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Id client : ',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SizedBox(
                    
                            child: SelectableText(
                              affectation.client!.clientId ?? '',
                              textAlign: TextAlign.start,
                               toolbarOptions: const ToolbarOptions(
                              copy: true,
                              selectAll: true,
                            ),
                            showCursor: true,
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
                        Text(
                          'Client : ',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SizedBox(
              
                            child: Text(
                              affectation.client!.name ?? '',
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
                        Text(
                          'SIP : ',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SelectableText(
                            affectation.client!.sip ?? '',
                            // overflow: TextOverflow.ellipsis,
                            toolbarOptions: const ToolbarOptions(
                              copy: true,
                              selectAll: true,
                            ),
                            showCursor: true,
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    affectation.datePlanification!.isNotEmpty
                        ? Visibility(
                            visible: affectation.status != 'Bloqué' &&
                                affectation.status != 'Terminé' &&     affectation.status != 'En cours',
                            child: Row(
                              children: [
                                Text(
                                  'Planifié : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: Text(
                                    affectation.datePlanification!.isNotEmpty
                                        ? DateFormat('dd/MM/yyyy HH:mm').format(
                                            DateTime.parse(affectation.datePlanification!))
                                        : '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Visibility(
                visible: showInfoIcon,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 1,
                    color: const Color.fromARGB(255, 212, 208, 208),
                  ),
                ),
              ),
              Visibility(
                  visible: showInfoIcon,
                  child: IconCercleWidgt(icon: IconlyBroken.show, size: 55.w)),
            ],
          ),
        ),
      ),
    );
  }
}
