import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/login/form_login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getDeviceIdentifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(          resizeToAvoidBottomInset: false,
body: FormLoginWidget());
  }
}
