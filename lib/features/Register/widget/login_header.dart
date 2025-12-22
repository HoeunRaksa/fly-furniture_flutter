import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget implements PreferredSizeWidget {
  const LoginHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top:1),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.2 * 255).round()),
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(
                          width: 1,
                          color: Colors.white.withAlpha((0.5 * 255).round()),
                        ),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Text(
                      "Welcome back",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 40,)
                ],
              ),
              const SizedBox(height: 60,)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Icon(Icons.favorite, color: Colors.white,size: 40,),
            SizedBox(height: 15,),
            Text("FLY STYLE", style: Theme.of(context).textTheme.headlineLarge,)
          ]),
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(230);
}
