import 'package:condo_app/firebase_options.dart';
import 'package:condo_app/src/dashboard/dashboard_view.dart';
import 'package:condo_app/src/gate_button/gate_button_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    const providerConfigs = [
      // TODO - Remove hardcoded client_id
      // This client id shouldn't be exposed here. This is just the development
      // instance/client id and must be removed before include the prodution
      // environment.
      // Remove alto these files:
      // - android/app/google-services.json
      // - ios/firebase_app_id_file.json
      // - lib/firebase_options.dart
      // - macos/firebase_app_id_file.json
      // EmailProviderConfiguration(),
      GoogleProviderConfiguration(clientId: oAuthClientId)
    ];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GateButtonController>(
          create: (_) => GateButtonController(),
          lazy: false,
        )
      ],

      // Glue the SettingsController to the MaterialApp.
      //
      // The AnimatedBuilder Widget listens to the SettingsController for changes.
      // Whenever the user updates their settings, the MaterialApp is rebuilt.
      child: AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? '/sign-in'
                : DashboardView.routeName,

            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',

            // Provide the generated AppLocalizations to the MaterialApp. This
            // allows descendant Widgets to display the correct translations
            // depending on the user's locale.
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
            ],

            // Use AppLocalizations to configure the correct application title
            // depending on the user's locale.
            //
            // The appTitle is defined in .arb files found in the localization
            // directory.
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,

            // Define a light and dark color theme. Then, read the user's
            // preferred ThemeMode (light, dark, or system default) from the
            // SettingsController to display the correct theme.
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,

            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case SampleItemDetailsView.routeName:
                      return const SampleItemDetailsView();
                    case '/profile':
                      return ProfileScreen(
                        providerConfigs: providerConfigs,
                        actions: [
                          SignedOutAction((context) {
                            Navigator.pushReplacementNamed(context, '/sign-in');
                          }),
                        ],
                      );
                    case SampleItemListView.routeName:
                      return const SampleItemListView();
                    case DashboardView.routeName:
                      return DashboardView();
                    case '/sign-in':
                    default:
                      return SignInScreen(
                        showAuthActionSwitch: false,
                        providerConfigs: providerConfigs,
                        actions: [
                          AuthStateChangeAction<SignedIn>((context, state) {
                            Navigator.pushReplacementNamed(
                                context, DashboardView.routeName);
                          }),
                        ],
                      );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
