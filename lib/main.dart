import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportx/common/widgets/bottom_bar.dart';
import 'package:sportx/common/widgets/custom_button.dart';
import 'package:sportx/common/widgets/loader.dart';
import 'package:sportx/constants/global_variables.dart';
import 'package:sportx/features/admin/screens/admin_screen.dart';
import 'package:sportx/features/auth/screens/auth_screen.dart';
import 'package:sportx/features/auth/services/auth_service.dart';
import 'package:sportx/firebase_options.dart';
import 'package:sportx/providers/user_provider.dart';
import 'package:sportx/router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  ConnectivityResult? connectivityResult;
  @override
  void initState() {
    super.initState();
    getConnectionStatus();
  }

  void getConnectionStatus({bool fromRetry = false}) async {
    if (fromRetry) {
      Provider.of<UserProvider>(context, listen: false).setStartedStatus(false);
    }
    connectivityResult = await Connectivity().checkConnectivity();
    setState(() {});
    getUserData();
  }

  void getUserData() {
    authService.getUserData(context).then((value) =>
        Provider.of<UserProvider>(context, listen: false)
            .setStartedStatus(true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SportX',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.remiseBlueColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariables.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          color: GlobalVariables.secondaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: connectivityResult == ConnectivityResult.none
          ? Scaffold(
              body: Column(
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'Check your Internet Connection Bro!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Image.asset(
                      'assets/images/fencing_offline.png',
                      height: 300,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: CustomButton(
                      text: 'Retry',
                      onTap: () {
                        getConnectionStatus(fromRetry: true);
                      },
                    ),
                  ),
                ],
              ),
            )
          : !Provider.of<UserProvider>(context).hasStarted
              ? const Scaffold(body: Loader())
              : Provider.of<UserProvider>(context).user.token.isNotEmpty
                  ? Provider.of<UserProvider>(context).user.type == 'user'
                      ? const BottomBar()
                      : const AdminScreen()
                  : const AuthScreen(),
    );
  }
}
