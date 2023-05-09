import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:vacancies_app/notification.dart';
import 'package:vacancies_app/profile.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 70.0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      // leading: Builder(builder: (context) => // Ensure Scaffold is in context
      //       IconButton(
      //          icon: Icon(Icons.menu),
      //          onPressed: () => Scaffold.of(context).openDrawer()
      //    )),

      // title: Text('Recruitment Portal', 
      //     style: TextStyle(fontSize: 16, color: Colors.black) ,
      // ),
      actions: [
        
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width - 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                

                Builder(builder: (context) => // Ensure Scaffold is in context
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer()
                )),


                Text('Recruitment Portal', 
                  style: TextStyle(fontSize: 16, color: Colors.black) ,
                ),

                Row(
                  children: [
                    

                    Padding(
                      padding: const EdgeInsets.only(top: 4, right: 8.0),
                      child: Stack(
                        children: [
                          
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotificationScreen()));
                            },
                            icon: const Image(
                              height: 24,
                              image: AssetImage("assets/notificon3.png"),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: badge.Badge(
                              badgeContent: Text(
                                '0',
                                style: const TextStyle(color: Colors.white),
                              ),
                              badgeColor: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),


                    // Padding(
                    //   padding: const EdgeInsets.only(top: 4, right: 8.0),
                    //   child: IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => ProfileScreen()));
                    //     },
                    //     icon: const Image(
                    //       height: 24,
                    //       image: AssetImage("assets/user.png"),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                

                
              ],
            ),
          ),
        )
      ],
    );
  }
}
