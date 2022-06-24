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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bottom_navigation/bottom_navigation_controller.dart';

class About extends StatefulWidget implements PageModel {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();

  @override
  final String routeName = '/about';
  // TODO: translate
  @override
  final String routeTitle = 'Sobre';
  @override
  final BottomNavigationBarItem navigationButton =
      const BottomNavigationBarItem(
    icon: Icon(Icons.help),
    // TODO: translate
    label: 'Sobre',
  );
}

class _AboutState extends State<About> {
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
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            // TODO: translate
            child: Text('Porto Novo'),
          ),
          ListTile(
            // TODO: translate
            title: Text('Versão: ${packageInfo?.version ?? ""}'),
          ),
          ListTile(
            // TODO: translate
            title: Text('Licenças de código aberto'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => LicensePage(
                  applicationName: 'Porto Novo',
                  applicationVersion: packageInfo?.version ?? '',
                ),
              ),
            ),
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
}
