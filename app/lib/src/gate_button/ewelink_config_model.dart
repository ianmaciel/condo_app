import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_ewelink_api/dart_ewelink_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'ewelink_config_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EwelinkConfigModel {
  EwelinkConfigModel({
    this.auth,
    required this.email,
    required this.password,
    required this.region,
  });

  EwelinkCredentials? auth;
  String email;
  String password;
  String region;

  factory EwelinkConfigModel.fromJson(Map<String, Object?> json) =>
      _$EwelinkConfigModelFromJson(json);
  Map<String, Object?> toJson() => _$EwelinkConfigModelToJson(this);
}

@Collection<EwelinkConfigModel>('configs')
final configsRef = EwelinkConfigModelCollectionReference();
