import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../loginpage/login.dart';
import '../viewmodel/auth_view_model.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late AuthViewModel _authViewModel;

  @override
  void initState() {
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/home");
                },
                icon: Icon(Icons.arrow_back),
              ),
              backgroundColor: Colors.black,
              title: Text('My Profile'),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('assets/images/Logo.jpg'),
                        // backgroundColor: Colors.red,
                      ),
                      Text(
                        _authViewModel.loggedInUser!.username.toString(),
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _authViewModel.loggedInUser!.email.toString(),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Source Sans Pro',
                            color: Colors.black,
                            letterSpacing: 1.5,
                            wordSpacing: 3,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.black,
                        label: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/editProfile");
                        },
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      // GestureDetector(
                      //   child: Container(
                      //     margin: EdgeInsets.all(15),
                      //     decoration: BoxDecoration(
                      //         color: Colors.black54,
                      //         borderRadius: BorderRadius.circular(30)),
                          // child: ListTile(
                          //   leading: Icon(
                          //     Icons.people,
                          //     color: Colors.white,
                          //   ),
                          //   title: Text(
                          //     "Order History",
                          //     style: TextStyle(fontSize: 20, color: Colors.black),
                          //   ),
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => OrderHistoryDetail(),
                          //         ));
                          //   },
                      //       trailing: Padding(
                      //         padding: const EdgeInsets.only(right: 12.0),
                      //         child: Icon(
                      //           Icons.arrow_forward_ios_outlined,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       contentPadding: EdgeInsets.only(left: 40),
                      //     ),
                      //   ),
                      // ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            leading: Icon(
                              Icons.help_outline,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Help & Support",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => HelpSupport(),
                              //     ));
                            },
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            leading: Icon(
                              Icons.alarm_sharp,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Reviews",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => Feedbacks(),
                              //     ));
                            },
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            leading: Icon(
                              Icons.people_alt_rounded,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Change Password",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ChangePassword(),
                              //     ));
                            },
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Logout",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 40),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Logout'),
                                      content: const Text(
                                          'Are you sure you want to logout?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreens(),
                                                ));
                                          },
                                          child: Text(
                                            "Sign Out",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'No',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                      ),
                    ]))));
  }
}
