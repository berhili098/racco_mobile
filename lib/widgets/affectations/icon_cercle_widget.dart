import 'package:flutter/material.dart';

class IconCercleWidgt extends StatelessWidget {
  final IconData icon;
  final double size;


  const IconCercleWidgt({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(97, 113, 186, 0.2199999988079071),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFF6171ba),
          ),
          child: Icon(
            icon,
            // color: Color.fromRGBO(151, 72, 150, 1),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
