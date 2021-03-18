import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/design/dark_theme_provider.dart';
import 'package:the_ranch_app/design/styles.dart';
import 'package:the_ranch_app/providers/add_memory_manager.dart';
import 'package:the_ranch_app/providers/edit_profile_manager.dart';
import 'package:the_ranch_app/providers/login_screen_provider.dart';
import 'package:the_ranch_app/providers/select_avatar_manager.dart';
import 'package:the_ranch_app/screens/landing_screen.dart';
import 'package:the_ranch_app/services/auth.dart';
import 'package:the_ranch_app/services/database.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(create: (context) => Auth()),
        Provider<Database>(create: (context) => Database()),
        Provider<MemoryProvider>(create: (context) => MemoryProvider()),
        ChangeNotifierProvider<EditProfileProvider>(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider<LoadingStateManager>(create: (context) => LoadingStateManager()),
        ChangeNotifierProvider<SelectAvatarManager>(create: (context) => SelectAvatarManager())
      ],
      child: ChangeNotifierProvider<DarkThemeProvider>(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
            return MaterialApp(
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home: LandingScreen(),
            );
          },
        ),
      ),
    );
  }
}
