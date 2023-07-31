import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';

class HomerdWidget extends StatelessWidget {
  final String title;
  final bool showNumber;
  final void Function()? onTap;

  final IconData icon;
  const HomerdWidget(
      {super.key, required this.title, this.onTap, required this.icon , this.showNumber = false });

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
        final affectationProvider = Provider.of<AffectationProvider>(context);


    return Padding(
      padding: EdgeInsets.only(top: 20.w),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 66.w,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(251, 251, 251, 0.75),
              borderRadius: BorderRadius.all(Radius.circular(22))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/home/card.svg'),
                      Icon(icon, color: Theme.of(context).primaryColor)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [



                  Visibility(
                    visible: showNumber,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                            height: 29.w,
                            width: 29.w,
                            child:
                                SvgPicture.asset('assets/icons/home/card.svg')),
                        Text(affectationProvider.affectationsPromoteur.length.toString(),
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  clientProvider.loadingTest
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 6.0,
                          ))
                      : SvgPicture.asset(
                          'assets/icons/home/Arrow - Right Square.svg')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
