import 'package:BusTracking_App/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'theme/themes.dart' as theme;
import 'views/components/betaBanner.dart';
import 'views/components/setup_dialog_ui.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
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
    return BetaBanner(
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: theme.appTheme,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
      ),
    );
  }
}
