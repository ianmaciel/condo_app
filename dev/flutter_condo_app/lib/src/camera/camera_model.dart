import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

part 'camera_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Camera {
  Camera({
    required this.name,
    this.description = '',
    this.enabled = false,
    required this.url,
    required this.type,
    required this.model,
    this.priority = 10,
  });

  final String name;
  final String description;
  final bool enabled;
  final String url;
  final String type;
  final String model;
  @Min(0)
  final int priority;

  factory Camera.fromJson(Map<String, Object?> json) => _$CameraFromJson(json);
  Map<String, Object?> toJson() => _$CameraToJson(this);
}

@Collection<Camera>('cameras')
final camerasRef = CameraCollectionReference();
