import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_user/widgets/statistique/statistique_list_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool show;

  AppBarWidget({
    Key? key,
    this.title,
    this.show = true,
  }) : super(key: key);
  final SvgPicture iconAdd = SvgPicture.asset(
    "assets/icons/home/Heart_added.svg",
    color: Colors.white,
  );
  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // here the desired height
        child: ClipPath(
            // clipper: BottomWaveClipper(),
            child: AppBar(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                )),
                leading: show
                    ? IconButton(
                        icon: SvgPicture.asset(
                            'assets/icons/blocage/Arrow - Left Circle.svg'),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.push('/home');
                          }
                        },
                      )
                    : const SizedBox(),
                centerTitle: false,
                title: Text(
                  title ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 23.sp,
                      color: Colors.white,
                      fontFamily: 'Lexend'),
                ),
                flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(1, 1.5),
                            end: Alignment(-0.94597145915031433, -0.8),
                            colors: [
                      Color.fromRGBO(89, 185, 255, 1),
                      Color.fromRGBO(97, 113, 186, 1)
                    ]))))));
  }
}
