// MIT License
//
// Copyright (c) 2022 Ian Koerich Maciel
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:provider/provider.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_page.dart';
import 'bottom_navigation/protected_bottom_navigation.dart';
import 'gate_button/ewelink_button_controller.dart';
import 'bottom_navigation/bottom_navigation_controller.dart';
import 'user/user_controller.dart';
import 'configs/authentication_provider.dart';
import 'guest/public_view.dart';
import 'guest/guest_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
    required this.userController,
    required this.guestController,
  }) : super(key: key);

  final SettingsController settingsController;
  final UserController userController;
  final GuestController guestController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (_) => userController,
          lazy: false,
        ),
        ChangeNotifierProvider<BottomNavigationController>(
          create: (_) => BottomNavigationController(userController),
          lazy: false,
        ),
        ChangeNotifierProvider<EwelinkButtonController>(
          create: (_) => EwelinkButtonController(),
          lazy: false,
        ),
        ChangeNotifierProvider<GuestController>(
          create: (_) => guestController,
          lazy: false,
        ),
      ],

      // Glue the SettingsController to the MaterialApp.
      //
      // The AnimatedBuilder Widget listens to the SettingsController for changes.
      // Whenever the user updates their settings, the MaterialApp is rebuilt.
      child: AnimatedBuilder(
        animation: settingsController,
        builder: (BuildContext context, Widget? child) {
          return Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: MaterialApp(
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'condo_app',

              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                FlutterFireUILocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('pt', 'BR'),
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
                    final String? route = routeSettings.name?.split('?').first;

                    switch (route) {
                      case SettingsPage.routeName:
                        return SettingsPage(controller: settingsController);
                      case PublicView.routeName:
                        guestController
                            .loadKeyByUrlParameters(routeSettings.name!);
                        return const PublicView();
                      case ProtectedBottomNavigation.routeName:
                      default:
                        return const ProtectedBottomNavigation();
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
