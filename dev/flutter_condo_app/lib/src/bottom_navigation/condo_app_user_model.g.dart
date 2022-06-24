// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'condo_app_user_model.dart';

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
abstract class CondoAppUserCollectionReference
    implements
        CondoAppUserQuery,
        FirestoreCollectionReference<CondoAppUserQuerySnapshot> {
  factory CondoAppUserCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$CondoAppUserCollectionReference;

  static CondoAppUser fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return CondoAppUser.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    CondoAppUser value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  CondoAppUserDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<CondoAppUserDocumentReference> add(CondoAppUser value);
}

class _$CondoAppUserCollectionReference extends _$CondoAppUserQuery
    implements CondoAppUserCollectionReference {
  factory _$CondoAppUserCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$CondoAppUserCollectionReference._(
      firestore.collection('users').withConverter(
            fromFirestore: CondoAppUserCollectionReference.fromFirestore,
            toFirestore: CondoAppUserCollectionReference.toFirestore,
          ),
    );
  }

  _$CondoAppUserCollectionReference._(
    CollectionReference<CondoAppUser> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<CondoAppUser> get reference =>
      super.reference as CollectionReference<CondoAppUser>;

  @override
  CondoAppUserDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return CondoAppUserDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<CondoAppUserDocumentReference> add(CondoAppUser value) {
    return reference
        .add(value)
        .then((ref) => CondoAppUserDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$CondoAppUserCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class CondoAppUserDocumentReference
    extends FirestoreDocumentReference<CondoAppUserDocumentSnapshot> {
  factory CondoAppUserDocumentReference(
          DocumentReference<CondoAppUser> reference) =
      _$CondoAppUserDocumentReference;

  DocumentReference<CondoAppUser> get reference;

  /// A reference to the [CondoAppUserCollectionReference] containing this document.
  CondoAppUserCollectionReference get parent {
    return _$CondoAppUserCollectionReference(reference.firestore);
  }

  @override
  Stream<CondoAppUserDocumentSnapshot> snapshots();

  @override
  Future<CondoAppUserDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String? email,
    List<String>? roles,
  });

  Future<void> set(CondoAppUser value);
}

class _$CondoAppUserDocumentReference
    extends FirestoreDocumentReference<CondoAppUserDocumentSnapshot>
    implements CondoAppUserDocumentReference {
  _$CondoAppUserDocumentReference(this.reference);

  @override
  final DocumentReference<CondoAppUser> reference;

  /// A reference to the [CondoAppUserCollectionReference] containing this document.
  CondoAppUserCollectionReference get parent {
    return _$CondoAppUserCollectionReference(reference.firestore);
  }

  @override
  Stream<CondoAppUserDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return CondoAppUserDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<CondoAppUserDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return CondoAppUserDocumentSnapshot._(
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
    Object? roles = _sentinel,
  }) async {
    final json = {
      if (email != _sentinel) "email": email as String?,
      if (roles != _sentinel) "roles": roles as List<String>?,
    };

    return reference.update(json);
  }

  Future<void> set(CondoAppUser value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is CondoAppUserDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class CondoAppUserDocumentSnapshot extends FirestoreDocumentSnapshot {
  CondoAppUserDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<CondoAppUser> snapshot;

  @override
  CondoAppUserDocumentReference get reference {
    return CondoAppUserDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final CondoAppUser? data;
}

abstract class CondoAppUserQuery
    implements QueryReference<CondoAppUserQuerySnapshot> {
  @override
  CondoAppUserQuery limit(int limit);

  @override
  CondoAppUserQuery limitToLast(int limit);

  CondoAppUserQuery whereEmail({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  CondoAppUserQuery whereRoles({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? arrayContainsAny,
  });

  CondoAppUserQuery orderByEmail({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    CondoAppUserDocumentSnapshot? startAtDocument,
    CondoAppUserDocumentSnapshot? endAtDocument,
    CondoAppUserDocumentSnapshot? endBeforeDocument,
    CondoAppUserDocumentSnapshot? startAfterDocument,
  });

  CondoAppUserQuery orderByRoles({
    bool descending = false,
    List<String>? startAt,
    List<String>? startAfter,
    List<String>? endAt,
    List<String>? endBefore,
    CondoAppUserDocumentSnapshot? startAtDocument,
    CondoAppUserDocumentSnapshot? endAtDocument,
    CondoAppUserDocumentSnapshot? endBeforeDocument,
    CondoAppUserDocumentSnapshot? startAfterDocument,
  });
}

class _$CondoAppUserQuery extends QueryReference<CondoAppUserQuerySnapshot>
    implements CondoAppUserQuery {
  _$CondoAppUserQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<CondoAppUser> reference;

  CondoAppUserQuerySnapshot _decodeSnapshot(
    QuerySnapshot<CondoAppUser> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return CondoAppUserQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<CondoAppUserDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: CondoAppUserDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return CondoAppUserQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<CondoAppUserQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<CondoAppUserQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  CondoAppUserQuery limit(int limit) {
    return _$CondoAppUserQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  CondoAppUserQuery limitToLast(int limit) {
    return _$CondoAppUserQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  CondoAppUserQuery whereEmail({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$CondoAppUserQuery(
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

  CondoAppUserQuery whereRoles({
    List<String>? isEqualTo,
    List<String>? isNotEqualTo,
    List<String>? isLessThan,
    List<String>? isLessThanOrEqualTo,
    List<String>? isGreaterThan,
    List<String>? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? arrayContainsAny,
  }) {
    return _$CondoAppUserQuery(
      reference.where(
        'roles',
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        arrayContainsAny: arrayContainsAny,
      ),
      _collection,
    );
  }

  CondoAppUserQuery orderByEmail({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CondoAppUserDocumentSnapshot? startAtDocument,
    CondoAppUserDocumentSnapshot? endAtDocument,
    CondoAppUserDocumentSnapshot? endBeforeDocument,
    CondoAppUserDocumentSnapshot? startAfterDocument,
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

    return _$CondoAppUserQuery(query, _collection);
  }

  CondoAppUserQuery orderByRoles({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    CondoAppUserDocumentSnapshot? startAtDocument,
    CondoAppUserDocumentSnapshot? endAtDocument,
    CondoAppUserDocumentSnapshot? endBeforeDocument,
    CondoAppUserDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('roles', descending: descending);

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

    return _$CondoAppUserQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$CondoAppUserQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class CondoAppUserQuerySnapshot
    extends FirestoreQuerySnapshot<CondoAppUserQueryDocumentSnapshot> {
  CondoAppUserQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<CondoAppUser> snapshot;

  @override
  final List<CondoAppUserQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<CondoAppUserDocumentSnapshot>> docChanges;
}

class CondoAppUserQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot
    implements CondoAppUserDocumentSnapshot {
  CondoAppUserQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<CondoAppUser> snapshot;

  @override
  CondoAppUserDocumentReference get reference {
    return CondoAppUserDocumentReference(snapshot.reference);
  }

  @override
  final CondoAppUser data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CondoAppUser _$CondoAppUserFromJson(Map<String, dynamic> json) => CondoAppUser(
      email: json['email'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CondoAppUserToJson(CondoAppUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'roles': instance.roles,
    };
