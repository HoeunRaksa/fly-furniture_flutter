import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/button_header.dart';

class DetailHeader extends StatelessWidget implements PreferredSizeWidget{
      const DetailHeader({super.key});
     @override
  Widget build(BuildContext context){
       return ButtonHeader(onClickedBack: () => context.go('/home'),);
     }
     @override
    Size get preferredSize => const Size.fromHeight(140);
}