import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9F9F9),
      scrolledUnderElevation: 0,
      leading: SvgPicture.asset(
        'assets/arrow_back.svg',
        height: 24,
        width: 9,
        fit: BoxFit.scaleDown,
      ),
      title: Text("Notifications", style: Theme.of(context).textTheme.labelMedium,),
      centerTitle: true,
      actions: <Widget>[
        Text("Mark all read", style: Theme.of(context).textTheme.labelMedium,),
        const SizedBox(width: 20,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

