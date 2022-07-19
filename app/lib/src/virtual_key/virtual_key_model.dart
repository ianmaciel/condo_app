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
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'virtual_key_model.g.dart';

@JsonSerializable()
class VirtualKey {
  final String name;
  final List<dynamic> allowedUsers;
  final String owner;
  final String token;
  final int errors;
  final String errorMessage;
  final String type;
  final DateTime validThru;
  DateTime? validFrom;
  DateTime? createdAt;
  final bool enable;
  final String? id;

  VirtualKey({
    required this.name,
    this.allowedUsers = const [],
    required this.owner,
    this.token = '',
    this.errors = 0,
    this.errorMessage = '',
    this.type = 'regular',
    required this.validThru,
    this.validFrom,
    this.createdAt,
    required this.enable,
    this.id,
  }) {
    validFrom ??= DateTime.now();
  }

  factory VirtualKey.fromJson(Map<String, dynamic> json) =>
      _$VirtualKeyFromJson(json);
  Map<String, dynamic> toJson() => _$VirtualKeyToJson(this);

  bool isValid() {
    DateTime now = DateUtils.dateOnly(DateTime.now());
    return enable &&
        !validFrom!.isAfterOrSameTime(now) &&
        !validThru.isBeforeOrSameTime(now);
  }
}

extension DateTimeOrSameTime on DateTime {
  bool isAfterOrSameTime(DateTime other) => !isBefore(other);
  bool isBeforeOrSameTime(DateTime other) => !isAfter(other);
}

@Collection<VirtualKey>('virtualKeys')
final virtualKeysRef = VirtualKeyCollectionReference();
