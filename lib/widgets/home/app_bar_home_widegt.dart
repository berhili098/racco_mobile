import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool returnVisible;
  const AppBarHomeWidget({Key? key, required this.returnVisible})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              leadingWidth: 30,
              automaticallyImplyLeading: false,
              elevation: 0,
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.home, color: Colors.black, size: 35),
              ), // you can put Icon as well, it accepts any widget.
              title: Text("Page d'accueil",
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),

              actions: [
                IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 30,
                    ))
              ],
              // leading: Icon(Icons.home ,color: Colors.black,size: 30,),
            ),
            const SizedBox(
              height: 50,
              child: Center(child: Text("zakaria")),
            ),
          ],
        ),
      ),
    );
  }
}
