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

import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../user/user_controller.dart';
import '../virtual_key/virtual_key_model.dart';

class VirtualKeyListView extends StatelessWidget {
  const VirtualKeyListView(
      {this.guestKey, this.showEmptyState = true, Key? key})
      : super(key: key);
  final bool showEmptyState;

  /// Include on the list view the key received url (token access), and not
  /// assined to the user.
  final VirtualKeyDocumentSnapshot? guestKey;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return showEmptyState ? const _KeysListViewEmptyState() : Container();
    }
    return FirestoreBuilder<VirtualKeyQuerySnapshot>(
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
          return Center(
            child:
                // TODO: translate
                SelectableText(
                    'Erro inesperado!\n\n${snapshot.error.toString()}'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Access the QuerySnapshot
        VirtualKeyQuerySnapshot querySnapshot = snapshot.requireData;

        return _KeysListView(querySnapshot.docs, guestKey,
            showEmptyState: showEmptyState);
      },
    );
  }

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
  const _KeysListView(this.docs, this.guestKey,
      {this.showEmptyState = true, Key? key})
      : super(key: key);
  final List<VirtualKeyQueryDocumentSnapshot> docs;
  final VirtualKeyDocumentSnapshot? guestKey;
  final bool showEmptyState;

  @override
  Widget build(BuildContext context) {
    List<VirtualKeyDocumentSnapshot> mergedDocs = mergeKeysList(docs, guestKey);
    if (mergedDocs.isEmpty) {
      return showEmptyState ? const _KeysListViewEmptyState() : Container();
    }
    return ListView.builder(
      itemCount: mergedDocs.length,
      itemBuilder: (context, index) {
        VirtualKey virtualKey = mergedDocs[index].data!;
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

  List<VirtualKeyDocumentSnapshot> mergeKeysList(
      List<VirtualKeyQueryDocumentSnapshot> userVirtualKeys,
      VirtualKeyDocumentSnapshot? guesKey) {
    List<VirtualKeyDocumentSnapshot> docs =
        userVirtualKeys.map<VirtualKeyDocumentSnapshot>((e) => e).toList();

    // Add keys received by url (shared keys).
    if (guestKey != null) {
      // Avoid duplication.
      if (docs.where((doc) => doc.id == guestKey!.id).isEmpty) {
        docs.add(guestKey!);
      }
    }
    return docs;
  }
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
              'Você ainda não tem nenhuma chave.',
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
