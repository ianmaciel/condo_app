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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import '../configs/authentication_provider.dart';
import '../settings/settings_page.dart';
import '../bottom_navigation/bottom_navigation_controller.dart';

class ProtectedBottomNavigation extends StatefulWidget {
  const ProtectedBottomNavigation({this.child, Key? key}) : super(key: key);
  final Widget? child;

  static const routeName = '/';

  @override
  State<ProtectedBottomNavigation> createState() =>
      _ProtectedBottomNavigationState();
}

class _ProtectedBottomNavigationState extends State<ProtectedBottomNavigation> {
  late BottomNavigationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        Provider.of<BottomNavigationController>(context, listen: false);
    controller.init(initialPage: widget.child);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: controller.currentTitle,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Navigate to the settings page. If the user leaves and returns
                  // to the app after it has been killed while running in the
                  // background, the navigation stack is restored.
                  Navigator.restorablePushNamed(
                      context, SettingsPage.routeName);
                },
              ),
            ],
          ),
          bottomNavigationBar: FirebaseAuth.instance.currentUser == null
              ? null
              : const _BottomNavigationBar(),
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            initialData: FirebaseAuth.instance.currentUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData) {
                return SignInScreen(
                  showAuthActionSwitch: false,
                  providerConfigs: providerConfigs,
                  actions: [
                    AuthStateChangeAction<SignedIn>((context, state) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          ProtectedBottomNavigation.routeName,
                          (Route<dynamic> route) => false);
                    }),
                  ],
                );
              }
              return const _Body();
            },
          ),
          floatingActionButton: const _FloatingButton(),
        ),
      );

  Future<bool> _onWillPop() {
    if (controller.selectedIndex == 0) {
      return Future.value(true);
    }

    controller.onItemTapped(0);
    return Future.value(false);
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<BottomNavigationController>(
        builder: (context, controller, child) {
          return BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: controller.onItemTapped,
            items: controller.getItems(),
          );
        },
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<BottomNavigationController>(
        builder: (context, controller, child) {
          return controller.getCurrentView();
        },
      );
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<BottomNavigationController>(
        builder: (context, controller, child) {
          return controller.getFloatingButton(context) ?? Container();
        },
      );
}
