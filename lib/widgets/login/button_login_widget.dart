import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/login/button_widget.dart';

class ButtonLoginWidget extends StatelessWidget {
  const ButtonLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return

        // userProvider.isLoading
        //     ? Container(
        //         alignment: Alignment.center,
        //         margin:  EdgeInsets.only(left :23.0.w,right: 19.w,top:35.h),
        //            height: 53.h,
        //         child: const LoadingIndicator(
        //             indicatorType: Indicator.ballSpinFadeLoader,
        //             colors: [
        //       Color.fromRGBO(5,119,130,1),
        //             ],
        //             strokeWidth: 1,
        //             pathBackgroundColor: Colors.black

        //             /// Optional, the stroke backgroundColor
        //             ),
        //       )
        //     :

        Padding(
      padding: EdgeInsets.only(left: 23.0.w, right: 19.w, top: 35.h),
      child: ButtonAuthWiget(
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final form = userProvider.formKeyLogin.currentState;

          if (form!.validate()) {
            await userProvider.login(userProvider.emailController.text,
                userProvider.passwordController.text, context);
          }
        },
        title: "Connexion",
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
