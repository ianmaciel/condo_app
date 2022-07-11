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
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../user/user_controller.dart';
import '../bottom_navigation/bottom_navigation_controller.dart';
import 'create_key_view.dart';
import 'virtual_key_list_view.dart';

class VirtualKeyPage extends PageModel {
  const VirtualKeyPage({Key? key}) : super(key: key);

  @override
  String getRouteTitle(BuildContext context) =>
      AppLocalizations.of(context)!.virtualKeyPageTitle;

  @override
  String get pageId => 'virtualKeyPage';

  @override
  IconData get icon => Icons.key;

  @override
  Widget build(BuildContext context) => const VirtualKeyListView();

  @override
  Widget? getFloatingButton(BuildContext context) => Consumer<UserController>(
        builder: (context, userController, child) {
          if (userController.isAdmin || userController.isResident) {
            return FloatingActionButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const CreateKeyView(),
                ),
              ),
              child: const Icon(Icons.add),
            );
          }
          return Container();
        },
      );
}
