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

import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:condo_app/src/user/user_controller.dart';
import 'package:condo_app/src/virtual_key/create_key_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'virtual_key_model.dart';
import '../bottom_navigation/bottom_navigation_controller.dart';

class VirtualKeyView extends StatelessWidget implements PageModel {
  const VirtualKeyView({
    Key? key,
  }) : super(key: key);

  @override
  final String routeName = '/virtual_key';
  // TODO: translate
  @override
  final String routeTitle = 'Chave Virtual';
  @override
  final BottomNavigationBarItem navigationButton =
      const BottomNavigationBarItem(
    icon: Icon(Icons.key),
    // TODO: translate
    label: 'Chave Virtual',
  );

  @override
  Widget build(BuildContext context) =>
      FirestoreBuilder<VirtualKeyQuerySnapshot>(
        ref: getFirestoreQuery(context),
        builder: (context, AsyncSnapshot<VirtualKeyQuerySnapshot> snapshot,
            Widget? child) {
          if (snapshot.hasError) {
            FirebaseException error = snapshot.error as FirebaseException;
            if (error.code == 'permission-denied') {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    // TODO: translate
                    'Seu usuário não possui permissão para acessar o aplicativo.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const Text('Something went wrong!');
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Access the QuerySnapshot
          VirtualKeyQuerySnapshot querySnapshot = snapshot.requireData;

          return _KeysListView(querySnapshot.docs);
        },
      );

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

  FirestoreListenable<VirtualKeyQuerySnapshot> getFirestoreQuery(
      BuildContext context) {
    UserController userController = Provider.of<UserController>(context);

    if (userController.isAdmin || userController.isResident) {
      return virtualKeysRef.whereOwner(isEqualTo: userController.uid!);
    }
    return virtualKeysRef.whereAllowedUsers(arrayContainsAny: [
      FirebaseAuth.instance.currentUser!.uid
    ]).orderByEnable();
  }
}

class _KeysListView extends StatelessWidget {
  const _KeysListView(this.docs, {Key? key}) : super(key: key);
  final List<VirtualKeyQueryDocumentSnapshot> docs;

  @override
  Widget build(BuildContext context) => docs.isEmpty
      ? const _KeysListViewEmptyState()
      : ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            VirtualKey virtualKey = docs[index].data;
            return ListTile(
              title: Text(virtualKey.name),
              subtitle: Text(virtualKey.allowedUsers.join(', ')),
              trailing: Chip(
                // TODO: translate
                label: Text(virtualKey.enable ? 'Habilitada' : 'Desabilitada'),
              ),
            );
          },
        );
}

class _KeysListViewEmptyState extends StatelessWidget {
  const _KeysListViewEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.subject),
            const SizedBox(height: 16),
            const Text(
              'Você não tem nenhuma chave ainda.',
              textAlign: TextAlign.center,
            ),
            Consumer<UserController>(
              builder: (context, userController, child) {
                if (userController.isAdmin || userController.isResident) {
                  return const Text(
                    'Clique no botão abaixo para criar sua primeira chave e compartilhar com seus convidados!',
                    textAlign: TextAlign.center,
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      );
}
