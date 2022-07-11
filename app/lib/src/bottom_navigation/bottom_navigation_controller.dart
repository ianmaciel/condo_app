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
import '../dashboard/dashboard_page.dart';
import '../virtual_key/virtual_key_page.dart';
import '../about/about_page.dart';
import '../user/user_controller.dart';
import '../guest/guest_page.dart';

class BottomNavigationController with ChangeNotifier {
  final UserController userController;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  BottomNavigationController(this.userController);

  CondoAppUser? get user => userController.user;
  bool isLoading = true;
  bool get isGuest => user?.isGuest() ?? true;
  List<PageModel> get views => isGuest ? guestViews : residentViews;

  init({Widget? initialPage}) async {
    await userController.loadUserController();
    isLoading = false;

    if (initialPage != null) {
      _selectedIndex = findPageIndex(initialPage, views);
    }
    notifyListeners();
  }

  int findPageIndex(Widget widget, List<PageModel> listOfWidgets) {
    if (widget is! PageModel) {
      return _selectedIndex;
    }
    PageModel page = widget as PageModel;
    int fondIndex =
        listOfWidgets.indexWhere((element) => element.pageId == page.pageId);
    return fondIndex < 0 ? _selectedIndex : fondIndex;
  }

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final List<PageModel> guestViews = [
    const GuestPage(),
    const AboutPage(),
  ];

  final List<PageModel> residentViews = [
    const DashboardPage(),
    if (kDebugMode) const VirtualKeyPage(),
    const AboutPage(),
  ];

  List<BottomNavigationBarItem> getItems(BuildContext context) => views
      .map<BottomNavigationBarItem>(
          (PageModel page) => page.buildNavigationButton(context))
      .toList();

  Widget getCurrentView() => isLoading
      ? const Center(child: CircularProgressIndicator.adaptive())
      : views[_selectedIndex] as Widget;

  Text getCurrentTitle(BuildContext context) => isLoading
      ? const Text('')
      : Text(views[_selectedIndex].getRouteTitle(context));
  Widget get currentWidget =>
      isLoading ? Container() : views[_selectedIndex] as Widget;

  Widget? getFloatingButton(BuildContext context) =>
      isLoading ? null : views[_selectedIndex].getFloatingButton(context);
}

abstract class PageModel extends StatelessWidget {
  const PageModel({Key? key}) : super(key: key);
  String get pageId;
  String getRouteTitle(BuildContext context);

  IconData get icon => Icons.abc;

  BottomNavigationBarItem buildNavigationButton(BuildContext context) =>
      BottomNavigationBarItem(
        icon: Icon(icon),
        label: getRouteTitle(context),
      );

  Widget? getFloatingButton(BuildContext context);
}
