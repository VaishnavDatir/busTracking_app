import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'theme/themes.dart' as theme;
import 'views/components/setup_dialog_ui.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // await LocatorInjector.setupLocator();
    await setupLocator();
    setupDialogUi();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      theme.setSystemTheme();
      runApp(MyApp());
    });
  } catch (error) {
    print(error.toString());
    print('Initial Setup Failed');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SafeWay",
      theme: theme.appTheme,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
