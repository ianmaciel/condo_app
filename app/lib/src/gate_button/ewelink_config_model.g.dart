// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ewelink_config_model.dart';

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
abstract class EwelinkConfigModelCollectionReference
    implements
        EwelinkConfigModelQuery,
        FirestoreCollectionReference<EwelinkConfigModelQuerySnapshot> {
  factory EwelinkConfigModelCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$EwelinkConfigModelCollectionReference;

  static EwelinkConfigModel fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return EwelinkConfigModel.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    EwelinkConfigModel value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  EwelinkConfigModelDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<EwelinkConfigModelDocumentReference> add(EwelinkConfigModel value);
}

class _$EwelinkConfigModelCollectionReference extends _$EwelinkConfigModelQuery
    implements EwelinkConfigModelCollectionReference {
  factory _$EwelinkConfigModelCollectionReference(
      [FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$EwelinkConfigModelCollectionReference._(
      firestore.collection('configs').withConverter(
            fromFirestore: EwelinkConfigModelCollectionReference.fromFirestore,
            toFirestore: EwelinkConfigModelCollectionReference.toFirestore,
          ),
    );
  }

  _$EwelinkConfigModelCollectionReference._(
    CollectionReference<EwelinkConfigModel> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<EwelinkConfigModel> get reference =>
      super.reference as CollectionReference<EwelinkConfigModel>;

  @override
  EwelinkConfigModelDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return EwelinkConfigModelDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<EwelinkConfigModelDocumentReference> add(EwelinkConfigModel value) {
    return reference
        .add(value)
        .then((ref) => EwelinkConfigModelDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$EwelinkConfigModelCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class EwelinkConfigModelDocumentReference
    extends FirestoreDocumentReference<EwelinkConfigModelDocumentSnapshot> {
  factory EwelinkConfigModelDocumentReference(
          DocumentReference<EwelinkConfigModel> reference) =
      _$EwelinkConfigModelDocumentReference;

  DocumentReference<EwelinkConfigModel> get reference;

  /// A reference to the [EwelinkConfigModelCollectionReference] containing this document.
  EwelinkConfigModelCollectionReference get parent {
    return _$EwelinkConfigModelCollectionReference(reference.firestore);
  }

  @override
  Stream<EwelinkConfigModelDocumentSnapshot> snapshots();

  @override
  Future<EwelinkConfigModelDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String email,
    String password,
    String region,
  });

  Future<void> set(EwelinkConfigModel value);
}

class _$EwelinkConfigModelDocumentReference
    extends FirestoreDocumentReference<EwelinkConfigModelDocumentSnapshot>
    implements EwelinkConfigModelDocumentReference {
  _$EwelinkConfigModelDocumentReference(this.reference);

  @override
  final DocumentReference<EwelinkConfigModel> reference;

  /// A reference to the [EwelinkConfigModelCollectionReference] containing this document.
  EwelinkConfigModelCollectionReference get parent {
    return _$EwelinkConfigModelCollectionReference(reference.firestore);
  }

  @override
  Stream<EwelinkConfigModelDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return EwelinkConfigModelDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<EwelinkConfigModelDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return EwelinkConfigModelDocumentSnapshot._(
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
    Object? email = _sentinel,
    Object? password = _sentinel,
    Object? region = _sentinel,
  }) async {
    final json = {
      if (email != _sentinel) "email": email as String,
      if (password != _sentinel) "password": password as String,
      if (region != _sentinel) "region": region as String,
    };

    return reference.update(json);
  }

  Future<void> set(EwelinkConfigModel value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is EwelinkConfigModelDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class EwelinkConfigModelDocumentSnapshot extends FirestoreDocumentSnapshot {
  EwelinkConfigModelDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<EwelinkConfigModel> snapshot;

  @override
  EwelinkConfigModelDocumentReference get reference {
    return EwelinkConfigModelDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final EwelinkConfigModel? data;
}

abstract class EwelinkConfigModelQuery
    implements QueryReference<EwelinkConfigModelQuerySnapshot> {
  @override
  EwelinkConfigModelQuery limit(int limit);

  @override
  EwelinkConfigModelQuery limitToLast(int limit);

  EwelinkConfigModelQuery whereEmail({
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
  EwelinkConfigModelQuery wherePassword({
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
  EwelinkConfigModelQuery whereRegion({
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

  EwelinkConfigModelQuery orderByEmail({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    EwelinkConfigModelDocumentSnapshot? startAtDocument,
    EwelinkConfigModelDocumentSnapshot? endAtDocument,
    EwelinkConfigModelDocumentSnapshot? endBeforeDocument,
    EwelinkConfigModelDocumentSnapshot? startAfterDocument,
  });

  EwelinkConfigModelQuery orderByPassword({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    EwelinkConfigModelDocumentSnapshot? startAtDocument,
    EwelinkConfigModelDocumentSnapshot? endAtDocument,
    EwelinkConfigModelDocumentSnapshot? endBeforeDocument,
    EwelinkConfigModelDocumentSnapshot? startAfterDocument,
  });

  EwelinkConfigModelQuery orderByRegion({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    EwelinkConfigModelDocumentSnapshot? startAtDocument,
    EwelinkConfigModelDocumentSnapshot? endAtDocument,
    EwelinkConfigModelDocumentSnapshot? endBeforeDocument,
    EwelinkConfigModelDocumentSnapshot? startAfterDocument,
  });
}

class _$EwelinkConfigModelQuery
    extends QueryReference<EwelinkConfigModelQuerySnapshot>
    implements EwelinkConfigModelQuery {
  _$EwelinkConfigModelQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<EwelinkConfigModel> reference;

  EwelinkConfigModelQuerySnapshot _decodeSnapshot(
    QuerySnapshot<EwelinkConfigModel> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return EwelinkConfigModelQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<EwelinkConfigModelDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc:
            EwelinkConfigModelDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return EwelinkConfigModelQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<EwelinkConfigModelQuerySnapshot> snapshots(
      [SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<EwelinkConfigModelQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  EwelinkConfigModelQuery limit(int limit) {
    return _$EwelinkConfigModelQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  EwelinkConfigModelQuery limitToLast(int limit) {
    return _$EwelinkConfigModelQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  EwelinkConfigModelQuery whereEmail({
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
    return _$EwelinkConfigModelQuery(
      reference.where(
        'email',
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

  EwelinkConfigModelQuery wherePassword({
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
    return _$EwelinkConfigModelQuery(
      reference.where(
        'password',
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

  EwelinkConfigModelQuery whereRegion({
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
    return _$EwelinkConfigModelQuery(
      reference.where(
        'region',
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

  EwelinkConfigModelQuery orderByEmail({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    EwelinkConfigModelDocumentSnapshot? startAtDocument,
    EwelinkConfigModelDocumentSnapshot? endAtDocument,
    EwelinkConfigModelDocumentSnapshot? endBeforeDocument,
    EwelinkConfigModelDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('email', descending: descending);

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

    return _$EwelinkConfigModelQuery(query, _collection);
  }

  EwelinkConfigModelQuery orderByPassword({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    EwelinkConfigModelDocumentSnapshot? startAtDocument,
    EwelinkConfigModelDocumentSnapshot? endAtDocument,
    EwelinkConfigModelDocumentSnapshot? endBeforeDocument,
    EwelinkConfigModelDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('password', descending: descending);

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

    return _$EwelinkConfigModelQuery(query, _collection);
  }

  EwelinkConfigModelQuery orderByRegion({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    EwelinkConfigModelDocumentSnapshot? startAtDocument,
    EwelinkConfigModelDocumentSnapshot? endAtDocument,
    EwelinkConfigModelDocumentSnapshot? endBeforeDocument,
    EwelinkConfigModelDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('region', descending: descending);

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

    return _$EwelinkConfigModelQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$EwelinkConfigModelQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class EwelinkConfigModelQuerySnapshot
    extends FirestoreQuerySnapshot<EwelinkConfigModelQueryDocumentSnapshot> {
  EwelinkConfigModelQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<EwelinkConfigModel> snapshot;

  @override
  final List<EwelinkConfigModelQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<EwelinkConfigModelDocumentSnapshot>>
      docChanges;
}

class EwelinkConfigModelQueryDocumentSnapshot
    extends FirestoreQueryDocumentSnapshot
    implements EwelinkConfigModelDocumentSnapshot {
  EwelinkConfigModelQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<EwelinkConfigModel> snapshot;

  @override
  EwelinkConfigModelDocumentReference get reference {
    return EwelinkConfigModelDocumentReference(snapshot.reference);
  }

  @override
  final EwelinkConfigModel data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EwelinkConfigModel _$EwelinkConfigModelFromJson(Map<String, dynamic> json) =>
    EwelinkConfigModel(
      auth: json['auth'] == null
          ? null
          : EwelinkCredentials.fromJson(json['auth'] as Map<String, dynamic>),
      email: json['email'] as String,
      password: json['password'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$EwelinkConfigModelToJson(EwelinkConfigModel instance) =>
    <String, dynamic>{
      'auth': instance.auth?.toJson(),
      'email': instance.email,
      'password': instance.password,
      'region': instance.region,
    };
