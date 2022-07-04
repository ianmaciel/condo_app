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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'condo_app_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CondoAppUser {
  CondoAppUser({
    this.email,
    this.roles,
    this.firebaseUser,
  }) {
    if (firebaseUser != null) {
      email = firebaseUser?.email;
    }
  }

  String? email;
  List<String>? roles;
  @JsonKey(ignore: true)
  User? firebaseUser;
  bool isAdmin() => roles?.any((element) => element == 'admin') ?? false;
  bool isResident() => roles?.any((element) => element == 'resident') ?? false;
  bool isGuest() => !isAdmin() && !isResident();

  static Future<CondoAppUser?> fromFirebaseUser() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }
    CondoAppUserDocumentSnapshot documentSnapshot = await condoAppUsersRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (documentSnapshot.data == null) {
      return null;
    }

    CondoAppUser condoUser = documentSnapshot.data!;
    condoUser.firebaseUser = FirebaseAuth.instance.currentUser;
    return condoUser;
  }

  factory CondoAppUser.fromJson(Map<String, Object?> json) =>
      _$CondoAppUserFromJson(json);
  Map<String, Object?> toJson() => _$CondoAppUserToJson(this);
}

@Collection<CondoAppUser>('users')
final condoAppUsersRef = CondoAppUserCollectionReference();
