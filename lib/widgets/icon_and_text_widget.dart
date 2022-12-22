import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/utils/dimensions.dart';
import 'package:fooddelivery/widgets/small_text.dart';

class IconAndTeztWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconcolor;
  const IconAndTeztWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconcolor, size: Dimensions.iceonSize24),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
