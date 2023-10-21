import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';

class CardPlanificationWidget extends StatelessWidget {
  final String title;
  final String nbItem;
  final Icon icon;
  final double percent;
  final bool useProgress;
  final Function()? onTap;

  const CardPlanificationWidget(
      {Key? key,
      required this.title,
      required this.icon,
      this.onTap,
      required this.useProgress,
      required this.nbItem,
      required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 170.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: Colors.black),
                      ),
                      const Icon(
                        IconlyLight.calendar,
                        // color: Color.fromRGBO(151, 72, 150, 1),
                        size: 40,
                      ),
                    ],
                  ),
                  nbItem == '0'
                      ? const Text('Il ne vous reste aucun client')
                      : Text('Il vous reste $nbItem Clients'),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 19.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                          'assets/icons/home/Arrow - Right Square.svg'),
                    ],
                  ),
                  !useProgress
                      ? Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 1),
                          // width: 40,
                          // color: Colors.red,
                          child: Text(
                            nbItem,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 40.sp,
                                color: const Color(0XFF6171ba)),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
