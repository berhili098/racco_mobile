import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';


class LoadingAffectationWidget extends StatelessWidget {
  const LoadingAffectationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
        itemCount:10,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                   highlightColor: Colors.grey.shade100,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                  ),
          );
        },
      );
   
  }
}