import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/pallete_color.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:tracking_user/widgets/login/button_login_widget.dart';
import 'package:tracking_user/widgets/login/field_login_widget.dart';

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return LoadingOverlay(
      isLoading: userProvider.loading,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: userProvider.formKeyLogin,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 70.w),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.asset(
                    "assets/imgs/login/logo.png",
                    height: 200.r,
                  ),
                  Container(
                    margin: EdgeInsets.all(8.r),
                    padding:
                        EdgeInsets.symmetric(vertical: 30.w, horizontal: 2),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(0, 3), // Offset from the top
                        ),
                      ],
                      // color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 0.5, // Border width
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Connexion",
                                  style: TextStyle(
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Palette.kToDark,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "Email",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    TextFieldFormsEditProfileWidget(
                                      validator: (value) {
                                        if (EmailValidator.validate(
                                            value!.replaceAll(" ", ""))) {
                                          userProvider.checkErrorEmail("");
                                          return null;
                                        } else {
                                          userProvider.checkErrorEmail(
                                              "Adresse mail obligatoire");
                                          return "";
                                        }
                                      },
                                      hint: "user@neweracom.com",
                                      fontSize: 16.0.sp,
                                      controller: userProvider.emailController,
                                      prefixIcon:
                                          const Icon(IconlyBroken.message),
                                      readOnly: false,
                                    ),
                                    Visibility(
                                      visible: userProvider
                                          .errorEmailTxtField.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          userProvider.errorEmailTxtField,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "Mots de passe",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    TextFieldFormsEditProfileWidget(
                                      validator: (value) {
                                        userProvider.checkErrorPassword(
                                            userProvider.password(
                                                value, context));

                                        return null;
                                      },
                                      hint: '✹✹✹✹✹✹✹✹',
                                      fontSize: 10.0.sp,
                                      controller:
                                          userProvider.passwordController,
                                      prefixIcon: const Icon(IconlyBroken.lock),
                                      suffixIcon: InkWell(
                                          onTap: () =>
                                              {userProvider.showPassword()},
                                          child: Icon(userProvider.show
                                              ? IconlyBroken.hide
                                              : IconlyBroken.show)),
                                      readOnly: false,
                                      obscureText: !userProvider.show,
                                    ),
                                    Visibility(
                                      visible: userProvider
                                          .errorPasswordTxtField.isNotEmpty,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          userProvider.errorPasswordTxtField,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const ButtonLoginWidget(),
                            InkWell(
                              onTap: () {
                                launchUrl(userProvider.emailLaunchUri);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 18.w),
                                child: Text(
                                  "Contacter le support",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Palette.kToDark,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
