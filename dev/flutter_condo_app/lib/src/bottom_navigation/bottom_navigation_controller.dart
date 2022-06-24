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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'condo_app_user_model.dart';
import '../dashboard/dashboard_view.dart';
import '../virtual_key/virtual_key_view.dart';
import '../about/about_view.dart';
import '../user/user_controller.dart';

class BottomNavigationController with ChangeNotifier {
  final UserController userController;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  BottomNavigationController(this.userController);

  CondoAppUser? user;
  bool isLoading = true;

  init() async {
    await userController.loadUserController();

    if (userController.user == null) {
      isLoading = false;
      notifyListeners();
      return;
    }
    user = userController.user;
    isLoading = false;
    if (user!.isAdmin() || user!.isResident()) {
      views.insert(0, const DashboardView());
    }
    isLoading = false;
    notifyListeners();
  }

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final List<PageModel> views = [
    if (kDebugMode) const VirtualKeyView(),
    const About(),
  ];

  List<BottomNavigationBarItem> getItems() => views
      .map<BottomNavigationBarItem>((PageModel page) => page.navigationButton)
      .toList();
  Widget getCurrentView() => isLoading
      ? const Center(child: CircularProgressIndicator.adaptive())
      : views[_selectedIndex] as Widget;
  Text get currentTitle =>
      isLoading ? const Text('') : Text(views[_selectedIndex].routeTitle);
  Widget get currentWidget =>
      isLoading ? Container() : views[_selectedIndex] as Widget;

  Widget? getFloatingButton(BuildContext context) =>
      isLoading ? null : views[_selectedIndex].getFloatingButton(context);
}

class PageModel {
  final String routeName;
  final String routeTitle;
  final BottomNavigationBarItem navigationButton;
  PageModel({
    required this.routeName,
    required this.routeTitle,
    required this.navigationButton,
  });

  Widget? getFloatingButton(BuildContext context) => null;
}
