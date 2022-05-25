// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_model.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class CameraCollectionReference
    implements CameraQuery, FirestoreCollectionReference<CameraQuerySnapshot> {
  factory CameraCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$CameraCollectionReference;

  static Camera fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return Camera.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    Camera value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CameraDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<CameraDocumentReference> add(Camera value);
}

class _$CameraCollectionReference extends _$CameraQuery
    implements CameraCollectionReference {
  factory _$CameraCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$CameraCollectionReference._(
      firestore.collection('cameras').withConverter(
            fromFirestore: CameraCollectionReference.fromFirestore,
            toFirestore: CameraCollectionReference.toFirestore,
          ),
    );
  }

  _$CameraCollectionReference._(
    CollectionReference<Camera> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<Camera> get reference =>
      super.reference as CollectionReference<Camera>;

  @override
  CameraDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return CameraDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<CameraDocumentReference> add(Camera value) {
    return reference.add(value).then((ref) => CameraDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$CameraCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class CameraDocumentReference
    extends FirestoreDocumentReference<CameraDocumentSnapshot> {
  factory CameraDocumentReference(DocumentReference<Camera> reference) =
      _$CameraDocumentReference;

  DocumentReference<Camera> get reference;

  /// A reference to the [CameraCollectionReference] containing this document.
  CameraCollectionReference get parent {
    return _$CameraCollectionReference(reference.firestore);
  }

  @override
  Stream<CameraDocumentSnapshot> snapshots();

  @override
  Future<CameraDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String name,
    String description,
    bool enabled,
    String url,
    String type,
    String model,
  });

  Future<void> set(Camera value);
}

class _$CameraDocumentReference
    extends FirestoreDocumentReference<CameraDocumentSnapshot>
    implements CameraDocumentReference {
  _$CameraDocumentReference(this.reference);

  @override
  final DocumentReference<Camera> reference;

  /// A reference to the [CameraCollectionReference] containing this document.
  CameraCollectionReference get parent {
    return _$CameraCollectionReference(reference.firestore);
  }

  @override
  Stream<CameraDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return CameraDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<CameraDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return CameraDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<void> delete() {
    return reference.delete();
  }

  Future<void> update({
    Object? name = _sentinel,
    Object? description = _sentinel,
    Object? enabled = _sentinel,
    Object? url = _sentinel,
    Object? type = _sentinel,
    Object? model = _sentinel,
  }) async {
    final json = {
      if (name != _sentinel) "name": name as String,
      if (description != _sentinel) "description": description as String,
      if (enabled != _sentinel) "enabled": enabled as bool,
      if (url != _sentinel) "url": url as String,
      if (type != _sentinel) "type": type as String,
      if (model != _sentinel) "model": model as String,
    };

    return reference.update(json);
  }

  Future<void> set(Camera value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is CameraDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class CameraDocumentSnapshot extends FirestoreDocumentSnapshot {
  CameraDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<Camera> snapshot;

  @override
  CameraDocumentReference get reference {
    return CameraDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Camera? data;
}

abstract class CameraQuery implements QueryReference<CameraQuerySnapshot> {
  @override
  CameraQuery limit(int limit);

  @override
  CameraQuery limitToLast(int limit);

  CameraQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  CameraQuery whereDescription({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  CameraQuery whereEnabled({
    bool? isEqualTo,
    bool? isNotEqualTo,
    bool? isLessThan,
    bool? isLessThanOrEqualTo,
    bool? isGreaterThan,
    bool? isGreaterThanOrEqualTo,
    bool? isNull,
    List<bool>? whereIn,
    List<bool>? whereNotIn,
  });
  CameraQuery whereUrl({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  CameraQuery whereType({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  CameraQuery whereModel({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });

  CameraQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  });

  CameraQuery orderByDescription({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  });

  CameraQuery orderByEnabled({
    bool descending = false,
    bool startAt,
    bool startAfter,
    bool endAt,
    bool endBefore,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  });

  CameraQuery orderByUrl({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  });

  CameraQuery orderByType({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  });

  CameraQuery orderByModel({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  });
}

class _$CameraQuery extends QueryReference<CameraQuerySnapshot>
    implements CameraQuery {
  _$CameraQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<Camera> reference;

  CameraQuerySnapshot _decodeSnapshot(
    QuerySnapshot<Camera> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return CameraQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<CameraDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: CameraDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return CameraQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<CameraQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<CameraQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  CameraQuery limit(int limit) {
    return _$CameraQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  CameraQuery limitToLast(int limit) {
    return _$CameraQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  CameraQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$CameraQuery(
      reference.where(
        'name',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  CameraQuery whereDescription({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$CameraQuery(
      reference.where(
        'description',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  CameraQuery whereEnabled({
    bool? isEqualTo,
    bool? isNotEqualTo,
    bool? isLessThan,
    bool? isLessThanOrEqualTo,
    bool? isGreaterThan,
    bool? isGreaterThanOrEqualTo,
    bool? isNull,
    List<bool>? whereIn,
    List<bool>? whereNotIn,
  }) {
    return _$CameraQuery(
      reference.where(
        'enabled',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  CameraQuery whereUrl({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$CameraQuery(
      reference.where(
        'url',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  CameraQuery whereType({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$CameraQuery(
      reference.where(
        'type',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  CameraQuery whereModel({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$CameraQuery(
      reference.where(
        'model',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      _collection,
    );
  }

  CameraQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('name', descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$CameraQuery(query, _collection);
  }

  CameraQuery orderByDescription({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('description', descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$CameraQuery(query, _collection);
  }

  CameraQuery orderByEnabled({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('enabled', descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$CameraQuery(query, _collection);
  }

  CameraQuery orderByUrl({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('url', descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$CameraQuery(query, _collection);
  }

  CameraQuery orderByType({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('type', descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$CameraQuery(query, _collection);
  }

  CameraQuery orderByModel({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CameraDocumentSnapshot? startAtDocument,
    CameraDocumentSnapshot? endAtDocument,
    CameraDocumentSnapshot? endBeforeDocument,
    CameraDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('model', descending: descending);

    if (startAtDocument != null) {
      query = query.startAtDocument(startAtDocument.snapshot);
    }
    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument.snapshot);
    }
    if (endAtDocument != null) {
      query = query.endAtDocument(endAtDocument.snapshot);
    }
    if (endBeforeDocument != null) {
      query = query.endBeforeDocument(endBeforeDocument.snapshot);
    }

    if (startAt != _sentinel) {
      query = query.startAt([startAt]);
    }
    if (startAfter != _sentinel) {
      query = query.startAfter([startAfter]);
    }
    if (endAt != _sentinel) {
      query = query.endAt([endAt]);
    }
    if (endBefore != _sentinel) {
      query = query.endBefore([endBefore]);
    }

    return _$CameraQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$CameraQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class CameraQuerySnapshot
    extends FirestoreQuerySnapshot<CameraQueryDocumentSnapshot> {
  CameraQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<Camera> snapshot;

  @override
  final List<CameraQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<CameraDocumentSnapshot>> docChanges;
}

class CameraQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot
    implements CameraDocumentSnapshot {
  CameraQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<Camera> snapshot;

  @override
  CameraDocumentReference get reference {
    return CameraDocumentReference(snapshot.reference);
  }

  @override
  final Camera data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Camera _$CameraFromJson(Map<String, dynamic> json) => Camera(
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      enabled: json['enabled'] as bool? ?? false,
      url: json['url'] as String,
      type: json['type'] as String,
      model: json['model'] as String,
    );

Map<String, dynamic> _$CameraToJson(Camera instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'enabled': instance.enabled,
      'url': instance.url,
      'type': instance.type,
      'model': instance.model,
    };
