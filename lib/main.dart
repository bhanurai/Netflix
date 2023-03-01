import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:netflix/screens/home_screen.dart';
import 'package:netflix/viewmodel/auth_view_model.dart';
import 'package:netflix/viewmodel/global_ui_viewmodel.dart';
import 'package:provider/provider.dart';

import 'cubits/app_bar/app_bar_cubit.dart';
import 'loading/loading.dart';
import 'loginpage/forgetpassword.dart';
import 'loginpage/login.dart';
import 'loginpage/register_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          BlocProvider<AppBarCubit>(
            create: (context) => AppBarCubit(),
          ),
          ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ],
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(
            child: Image.asset(
              "assets/images/loader.gif",
              height: 100,
              width: 100,
            ),
          ),
          child: Consumer<GlobalUIViewModel>(
              builder: (context, loader, child) {
                if (loader.isLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                return MaterialApp(
                  title: 'Netflix',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.purple,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    scaffoldBackgroundColor: Colors.black,
                  ),
                  initialRoute: "/LoadingScreen",
                  routes: {
                    "/LoadingScreen": (BuildContext context) =>
                        LoadingScreen(),
                    "/forgotpassword": (BuildContext context) =>
                        ForgotScreen(),
                    "/login": (BuildContext context) => LoginScreens(),
                    "/register": (BuildContext context) => RegisterScreen(),
                    "/home": (BuildContext context) => HomeScreen(),
                  },
                );
              }),
        ),
      );
  }
}
