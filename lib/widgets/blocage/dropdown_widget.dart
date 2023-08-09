import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/login/field_login_widget.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextFieldFormsEditProfileWidget(
        hint: "Choisir le type de blocage",
        onTap: () {
          blocageProvider.showDialog(
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff999999),
                          width: 0.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CupertinoButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 5.0,
                          ),
                          child: const Text('Cancel'),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            blocageProvider.getValueBlocageTechnicien(
                                blocageProvider.checkValueBlocageClient);
                            Navigator.pop(context);
                          },
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 5.0,
                          ),
                          child: const Text('Confirm'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              context);
        },
        // controller: userProvider.passwordController,
        prefixIcon: const Icon(Icons.password),
        // suffixIcon: const Icon(Icons.visibility),
        readOnly: true,
      ),
    );
  }
}
