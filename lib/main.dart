import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/routes/router.dart' as router;
import 'core/routes/router_path.dart';
import 'core/services/dialog_service.dart';
import 'core/services/navigator_service.dart';
import 'theme/themes.dart' as theme;
import 'views/components/dialog.dart';
import 'widgets/app_retain_widget.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await LocatorInjector.setupLocator();
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
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: AppRetainWidget(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "SafeWay",
          theme: theme.appTheme,
          builder: (context, widget) => Navigator(
            key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(
                child: widget,
              ),
            ),
          ),
          navigatorKey: locator<NavigationService>().navigationKey,
          onGenerateRoute: router.generateRoute,
          initialRoute: kHomeScreen,
        ),
      ),
    );
  }
}
