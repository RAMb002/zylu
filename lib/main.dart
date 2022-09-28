import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zylu/view/screens/add_details/detail_screen.dart';
import 'package:zylu/view/screens/home_screen.dart';
import 'package:zylu/view_model/providers/gender.dart';
import 'package:zylu/view_model/providers/image_provider.dart';
import 'package:zylu/view_model/providers/loader.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoadingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Zylu',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


