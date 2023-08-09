import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


class OptionListWidget extends StatelessWidget {
  const OptionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 428.w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(1, 1.5),
                end: Alignment(-0.94597145915031433, -0.8),
                colors: [
                  Color.fromRGBO(88, 185, 255, 1),
                  Color.fromRGBO(151, 72, 150, 1)
                ]),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 80.w, bottom: 10.w),
            child: SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(
                      'assets/icons/blocage/Arrow - Left Circle.svg'),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )),
          ),
        ),

        Expanded(
          child: 
          
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 2,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 10),
                    child: Container(
                      height: 0.5,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // annoncePageProvider.setEtat(
                      //   localeProvider.countryCode == 'FR'
                      //   ?
                      //     annoncePageProvider.etatlist[index].titre

                      //     :   annoncePageProvider.etatlist[index].titreArabe
                      //     ,
                      //     annoncePageProvider.etatlist[index].id);
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 8, top: 10, bottom: 10),

                      width: MediaQuery.of(context).size.width,
                      // height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: etatText("okkkk", 'rfrfr'))),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Radio<String>(
                                value: "",
                                groupValue: "",
                                activeColor: const Color.fromRGBO(151, 72, 150, 1),
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
     
     
     
        ),

        //  Container(
        //   alignment: Alignment.center,
        //   child: ButtonCreateAnnonceWidget(
        //     title:S.of(context)!.confirmer,
        //     width: MediaQuery.of(context).size.width * .9,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget etatText(String name, String text) {
    return Text(
      name,
      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
    );
  }
}
