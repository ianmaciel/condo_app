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
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'virtual_key_model.g.dart';

@JsonSerializable()
class VirtualKey {
  final String name;
  final List<dynamic> allowedUsers;
  final dynamic owner;
  final String token;
  final int errors;
  final String errorMessage;
  final String type;
  final DateTime validThru;
  final bool enable;

  VirtualKey({
    required this.name,
    required this.allowedUsers,
    required this.owner,
    required this.token,
    required this.errors,
    required this.errorMessage,
    required this.type,
    required this.validThru,
    required this.enable,
  });

  factory VirtualKey.fromJson(Map<String, dynamic> json) =>
      _$VirtualKeyFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualKeyToJson(this);
}

@Collection<VirtualKey>('keys')
final virtualKeysRef = VirtualKeyCollectionReference();
