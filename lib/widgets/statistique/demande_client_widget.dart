import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';

class DemandeClientWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const DemandeClientWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);

    return InkWell(
      onTap: onTap,
        customBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 66.w,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        margin: EdgeInsets.only(top: 20.w),
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
                    SvgPicture.asset('assets/icons/home/Document.svg'),
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
            clientProvider.isLoading
                ? const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                    ))
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/home/card.svg'),
                      const Icon(
                        IconlyBold.download,
                        color: Color(0xFF6171ba),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
