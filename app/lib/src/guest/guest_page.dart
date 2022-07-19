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

import '../bottom_navigation/bottom_navigation_controller.dart';
import '../virtual_key/key_detail_view.dart';
import 'guest_error_view.dart';
import 'guest_controller.dart';

class GuestPage extends PageModel {
  const GuestPage({Key? key}) : super(key: key);

  @override
  String getRouteTitle(BuildContext context) =>
      AppLocalizations.of(context)!.guestPageTitle;

  @override
  String get pageId => 'guestPage';

  @override
  IconData get icon => Icons.person;

  @override
  Widget? getFloatingButton(BuildContext context) => null;

  @override
  Widget build(BuildContext context) => const _GuestContent();
}

class _GuestContent extends StatefulWidget {
  const _GuestContent({Key? key}) : super(key: key);

  @override
  State<_GuestContent> createState() => _GuestContentState();
}

class _GuestContentState extends State<_GuestContent> {
  @override
  void initState() {
    super.initState();
    GuestController controller =
        Provider.of<GuestController>(context, listen: false);
    controller.loadUserKeys();
  }

  @override
  Widget build(BuildContext context) => Consumer<GuestController>(
        builder: (context, controller, child) {
          if (controller.hasError) {
            return GuestErrorView(controller.error);
          }
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return controller.hasVirtualKey
              ? Center(child: KeyDetailView(controller.virtualKey!))
              : const Center(child: _GuestEmptyState());
        },
      );
}

class _GuestEmptyState extends StatelessWidget {
  const _GuestEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.subject),
          SizedBox(height: 16),
          Text(
            'Você ainda não tem nenhuma chave.',
            textAlign: TextAlign.center,
          ),
        ],
      );
}
