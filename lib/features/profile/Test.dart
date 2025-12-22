import 'package:flutter/material.dart';
import 'package:fly/core/widgets/e_button.dart';
import '../../config/app_config.dart';
import 'getButton.dart';

class Test extends StatelessWidget {
  const Test({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80)
              ),
              child: Image.asset("${AppConfig.imageUrl}/character.png"),
            ),
            SizedBox(height: 10,),
            Text("Lily", style: TextStyle(color: Colors.grey[800], fontSize: 29, fontWeight: FontWeight.bold),),
            Text("MobileApp Developer", style: TextStyle(color: Colors.grey[700], fontSize: 17, fontWeight: FontWeight.normal),),
            SizedBox(height: 30,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                     children: [
                       Text("152", style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.bold),),
                       Text("Post", style: TextStyle(color: Colors.grey[700], fontSize: 17, fontWeight: FontWeight.normal),),
                     ],
                ),
                Column(
                  children: [
                    Text("1.2K", style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.bold),),
                    Text("Follower", style: TextStyle(color: Colors.grey[700], fontSize: 17, fontWeight: FontWeight.normal),),
                  ],
                ),
                Column(
                  children: [
                    Text("180", style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.bold),),
                    Text("Following", style: TextStyle(color: Colors.grey[700], fontSize: 17, fontWeight: FontWeight.normal),),
                  ],
                )
              ],
            ),
            SizedBox(height: 30,),
            FollowButtonExample()
          ],
        ),
      ),
    );
  }
}
