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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bottom_navigation/bottom_navigation_controller.dart';
import '../privacy_policy/privacy_policy_view.dart';

class AboutPage extends PageModel {
  const AboutPage({Key? key}) : super(key: key);

  @override
  String getRouteTitle(BuildContext context) =>
      AppLocalizations.of(context)!.aboutPageTitle;

  @override
  String get pageId => 'aboutPage';

  @override
  IconData get icon => Icons.help;

  @override
  Widget? getFloatingButton(BuildContext context) => null;

  @override
  Widget build(BuildContext context) => const _AboutContent();
}

class _AboutContent extends StatefulWidget {
  const _AboutContent({Key? key}) : super(key: key);

  @override
  State<_AboutContent> createState() => __AboutStateContent();
}

class __AboutStateContent extends State<_AboutContent> {
  PackageInfo? packageInfo;
  final String authorEmail = 'ianmaciel@gmail.com';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        packageInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/about_banner.png'),
                fit: BoxFit.cover,
              ),
            ),
            // TODO: translate
            child: Text(
              'Porto Novo',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .merge(const TextStyle(color: Colors.white)),
            ),
          ),
          ListTile(
            // TODO: translate
            title: Text('Versão: ${packageInfo?.version ?? ""}'),
          ),
          ListTile(
            // TODO: translate
            title: const Text('Perfil do Usuário'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const ProfileScreen(),
              ),
            ),
          ),
          ListTile(
            // TODO: translate
            title: const Text('Licenças de código aberto'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => LicensePage(
                  applicationName: 'Porto Novo',
                  applicationVersion: packageInfo?.version ?? '',
                ),
              ),
            ),
          ),
          ListTile(
            // TODO: translate
            title: const Text('Política de Privacidade'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const PrivacyPolicyView(),
              ),
            ),
          ),
          ListTile(
            // TODO: translate
            title: const Text('Sair (Logout)'),
            onTap: _logout,
          ),
          const Divider(),
          const ListTile(
            // TODO: translate
            title: SelectableText('Desenvolvido por Ian Maciel'),
          ),
          ListTile(
            title: Text(authorEmail),
            onTap: () => launchUrl(Uri.parse(
                'mailto:$authorEmail?subject=${packageInfo?.packageName}')),
          ),
        ],
      );

  void _logout() async {
    await FlutterFireUIAuth.signOut(
      context: context,
      auth: FirebaseAuth.instance,
    );
  }
}
