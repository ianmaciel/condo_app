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

import '../about/about_page.dart';
import '../bottom_navigation/protected_bottom_navigation.dart';
import 'guest_error_view.dart';
import 'guest_content.dart';
import 'guest_controller.dart';

class PublicView extends StatelessWidget {
  const PublicView({Key? key}) : super(key: key);

  static const String routeName = '/guest';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // TODO: translate
          title: const Text('Convidado'),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const _About(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<GuestController>(
            builder: (context, controller, child) {
              if (controller.hasError) {
                return GuestErrorView(controller.error);
              }
              if (controller.isLoading) {
                return const CircularProgressIndicator();
              }
              return controller.hasVirtualKey
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GuestContent(controller.virtualKey!),
                        const _LoginTip(),
                      ],
                    )
                  : const CircularProgressIndicator();
            },
          ),
        ),
      );
}

class _About extends StatelessWidget {
  const _About({Key? key}) : super(key: key);
  final AboutPage aboutView = const AboutPage();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(aboutView.routeTitle),
        ),
        body: aboutView,
      );
}

class _LoginTip extends StatelessWidget {
  const _LoginTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                const ProtectedBottomNavigation(),
          ),
        ),
        child: SizedBox(
          height: 64,
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              const Icon(Icons.tips_and_updates),
              const SizedBox(width: 16),
              // TODO: translate
              Text(
                'Dica: Clique aqui para fazer login e\nter acesso à chave sempre que precisar.',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
