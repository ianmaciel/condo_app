// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'virtual_key_model.dart';

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
abstract class VirtualKeyCollectionReference
    implements
        VirtualKeyQuery,
        FirestoreCollectionReference<VirtualKeyQuerySnapshot> {
  factory VirtualKeyCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$VirtualKeyCollectionReference;

  static VirtualKey fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return VirtualKey.fromJson(snapshot.data()!);
  }

  static Map<String, Object?> toFirestore(
    VirtualKey value,
    SetOptions? options,
  ) {
    return value.toJson();
  }

  @override
  VirtualKeyDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<VirtualKeyDocumentReference> add(VirtualKey value);
}

class _$VirtualKeyCollectionReference extends _$VirtualKeyQuery
    implements VirtualKeyCollectionReference {
  factory _$VirtualKeyCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$VirtualKeyCollectionReference._(
      firestore.collection('keys').withConverter(
            fromFirestore: VirtualKeyCollectionReference.fromFirestore,
            toFirestore: VirtualKeyCollectionReference.toFirestore,
          ),
    );
  }

  _$VirtualKeyCollectionReference._(
    CollectionReference<VirtualKey> reference,
  ) : super(reference, reference);

  String get path => reference.path;

  @override
  CollectionReference<VirtualKey> get reference =>
      super.reference as CollectionReference<VirtualKey>;

  @override
  VirtualKeyDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return VirtualKeyDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<VirtualKeyDocumentReference> add(VirtualKey value) {
    return reference.add(value).then((ref) => VirtualKeyDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$VirtualKeyCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class VirtualKeyDocumentReference
    extends FirestoreDocumentReference<VirtualKeyDocumentSnapshot> {
  factory VirtualKeyDocumentReference(DocumentReference<VirtualKey> reference) =
      _$VirtualKeyDocumentReference;

  DocumentReference<VirtualKey> get reference;

  /// A reference to the [VirtualKeyCollectionReference] containing this document.
  VirtualKeyCollectionReference get parent {
    return _$VirtualKeyCollectionReference(reference.firestore);
  }

  @override
  Stream<VirtualKeyDocumentSnapshot> snapshots();

  @override
  Future<VirtualKeyDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  Future<void> update({
    String name,
    List<dynamic> allowedUsers,
    String token,
    int errors,
    String errorMessage,
    String type,
    bool enable,
  });

  Future<void> set(VirtualKey value);
}

class _$VirtualKeyDocumentReference
    extends FirestoreDocumentReference<VirtualKeyDocumentSnapshot>
    implements VirtualKeyDocumentReference {
  _$VirtualKeyDocumentReference(this.reference);

  @override
  final DocumentReference<VirtualKey> reference;

  /// A reference to the [VirtualKeyCollectionReference] containing this document.
  VirtualKeyCollectionReference get parent {
    return _$VirtualKeyCollectionReference(reference.firestore);
  }

  @override
  Stream<VirtualKeyDocumentSnapshot> snapshots() {
    return reference.snapshots().map((snapshot) {
      return VirtualKeyDocumentSnapshot._(
        snapshot,
        snapshot.data(),
      );
    });
  }

  @override
  Future<VirtualKeyDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then((snapshot) {
      return VirtualKeyDocumentSnapshot._(
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
    Object? allowedUsers = _sentinel,
    Object? token = _sentinel,
    Object? errors = _sentinel,
    Object? errorMessage = _sentinel,
    Object? type = _sentinel,
    Object? enable = _sentinel,
  }) async {
    final json = {
      if (name != _sentinel) "name": name as String,
      if (allowedUsers != _sentinel)
        "allowedUsers": allowedUsers as List<dynamic>,
      if (token != _sentinel) "token": token as String,
      if (errors != _sentinel) "errors": errors as int,
      if (errorMessage != _sentinel) "errorMessage": errorMessage as String,
      if (type != _sentinel) "type": type as String,
      if (enable != _sentinel) "enable": enable as bool,
    };

    return reference.update(json);
  }

  Future<void> set(VirtualKey value) {
    return reference.set(value);
  }

  @override
  bool operator ==(Object other) {
    return other is VirtualKeyDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

class VirtualKeyDocumentSnapshot extends FirestoreDocumentSnapshot {
  VirtualKeyDocumentSnapshot._(
    this.snapshot,
    this.data,
  );

  @override
  final DocumentSnapshot<VirtualKey> snapshot;

  @override
  VirtualKeyDocumentReference get reference {
    return VirtualKeyDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final VirtualKey? data;
}

abstract class VirtualKeyQuery
    implements QueryReference<VirtualKeyQuerySnapshot> {
  @override
  VirtualKeyQuery limit(int limit);

  @override
  VirtualKeyQuery limitToLast(int limit);

  VirtualKeyQuery whereName({
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
  VirtualKeyQuery whereAllowedUsers({
    List<dynamic>? isEqualTo,
    List<dynamic>? isNotEqualTo,
    List<dynamic>? isLessThan,
    List<dynamic>? isLessThanOrEqualTo,
    List<dynamic>? isGreaterThan,
    List<dynamic>? isGreaterThanOrEqualTo,
    bool? isNull,
    List<dynamic>? arrayContainsAny,
  });
  VirtualKeyQuery whereToken({
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
  VirtualKeyQuery whereErrors({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int>? whereIn,
    List<int>? whereNotIn,
  });
  VirtualKeyQuery whereErrorMessage({
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
  VirtualKeyQuery whereType({
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
  VirtualKeyQuery whereEnable({
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

  VirtualKeyQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });

  VirtualKeyQuery orderByAllowedUsers({
    bool descending = false,
    List<dynamic> startAt,
    List<dynamic> startAfter,
    List<dynamic> endAt,
    List<dynamic> endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });

  VirtualKeyQuery orderByToken({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });

  VirtualKeyQuery orderByErrors({
    bool descending = false,
    int startAt,
    int startAfter,
    int endAt,
    int endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });

  VirtualKeyQuery orderByErrorMessage({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });

  VirtualKeyQuery orderByType({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });

  VirtualKeyQuery orderByEnable({
    bool descending = false,
    bool startAt,
    bool startAfter,
    bool endAt,
    bool endBefore,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  });
}

class _$VirtualKeyQuery extends QueryReference<VirtualKeyQuerySnapshot>
    implements VirtualKeyQuery {
  _$VirtualKeyQuery(
    this.reference,
    this._collection,
  );

  final CollectionReference<Object?> _collection;

  @override
  final Query<VirtualKey> reference;

  VirtualKeyQuerySnapshot _decodeSnapshot(
    QuerySnapshot<VirtualKey> snapshot,
  ) {
    final docs = snapshot.docs.map((e) {
      return VirtualKeyQueryDocumentSnapshot._(e, e.data());
    }).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return FirestoreDocumentChange<VirtualKeyDocumentSnapshot>(
        type: change.type,
        oldIndex: change.oldIndex,
        newIndex: change.newIndex,
        doc: VirtualKeyDocumentSnapshot._(change.doc, change.doc.data()),
      );
    }).toList();

    return VirtualKeyQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  @override
  Stream<VirtualKeyQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(_decodeSnapshot);
  }

  @override
  Future<VirtualKeyQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(_decodeSnapshot);
  }

  @override
  VirtualKeyQuery limit(int limit) {
    return _$VirtualKeyQuery(
      reference.limit(limit),
      _collection,
    );
  }

  @override
  VirtualKeyQuery limitToLast(int limit) {
    return _$VirtualKeyQuery(
      reference.limitToLast(limit),
      _collection,
    );
  }

  VirtualKeyQuery whereName({
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
    return _$VirtualKeyQuery(
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

  VirtualKeyQuery whereAllowedUsers({
    List<dynamic>? isEqualTo,
    List<dynamic>? isNotEqualTo,
    List<dynamic>? isLessThan,
    List<dynamic>? isLessThanOrEqualTo,
    List<dynamic>? isGreaterThan,
    List<dynamic>? isGreaterThanOrEqualTo,
    bool? isNull,
    List<dynamic>? arrayContainsAny,
  }) {
    return _$VirtualKeyQuery(
      reference.where(
        'allowedUsers',
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

  VirtualKeyQuery whereToken({
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
    return _$VirtualKeyQuery(
      reference.where(
        'token',
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

  VirtualKeyQuery whereErrors({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int>? whereIn,
    List<int>? whereNotIn,
  }) {
    return _$VirtualKeyQuery(
      reference.where(
        'errors',
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

  VirtualKeyQuery whereErrorMessage({
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
    return _$VirtualKeyQuery(
      reference.where(
        'errorMessage',
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

  VirtualKeyQuery whereType({
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
    return _$VirtualKeyQuery(
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

  VirtualKeyQuery whereEnable({
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
    return _$VirtualKeyQuery(
      reference.where(
        'enable',
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

  VirtualKeyQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
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

    return _$VirtualKeyQuery(query, _collection);
  }

  VirtualKeyQuery orderByAllowedUsers({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('allowedUsers', descending: descending);

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

    return _$VirtualKeyQuery(query, _collection);
  }

  VirtualKeyQuery orderByToken({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('token', descending: descending);

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

    return _$VirtualKeyQuery(query, _collection);
  }

  VirtualKeyQuery orderByErrors({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('errors', descending: descending);

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

    return _$VirtualKeyQuery(query, _collection);
  }

  VirtualKeyQuery orderByErrorMessage({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('errorMessage', descending: descending);

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

    return _$VirtualKeyQuery(query, _collection);
  }

  VirtualKeyQuery orderByType({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
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

    return _$VirtualKeyQuery(query, _collection);
  }

  VirtualKeyQuery orderByEnable({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    VirtualKeyDocumentSnapshot? startAtDocument,
    VirtualKeyDocumentSnapshot? endAtDocument,
    VirtualKeyDocumentSnapshot? endBeforeDocument,
    VirtualKeyDocumentSnapshot? startAfterDocument,
  }) {
    var query = reference.orderBy('enable', descending: descending);

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

    return _$VirtualKeyQuery(query, _collection);
  }

  @override
  bool operator ==(Object other) {
    return other is _$VirtualKeyQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class VirtualKeyQuerySnapshot
    extends FirestoreQuerySnapshot<VirtualKeyQueryDocumentSnapshot> {
  VirtualKeyQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  final QuerySnapshot<VirtualKey> snapshot;

  @override
  final List<VirtualKeyQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<VirtualKeyDocumentSnapshot>> docChanges;
}

class VirtualKeyQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot
    implements VirtualKeyDocumentSnapshot {
  VirtualKeyQueryDocumentSnapshot._(this.snapshot, this.data);

  @override
  final QueryDocumentSnapshot<VirtualKey> snapshot;

  @override
  VirtualKeyDocumentReference get reference {
    return VirtualKeyDocumentReference(snapshot.reference);
  }

  @override
  final VirtualKey data;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VirtualKey _$VirtualKeyFromJson(Map<String, dynamic> json) => VirtualKey(
      name: json['name'] as String,
      allowedUsers: json['allowedUsers'] as List<dynamic>,
      owner: json['owner'],
      token: json['token'] as String,
      errors: json['errors'] as int,
      errorMessage: json['errorMessage'] as String,
      type: json['type'] as String,
      validThru: DateTime.parse(json['validThru'] as String),
      enable: json['enable'] as bool,
    );

Map<String, dynamic> _$VirtualKeyToJson(VirtualKey instance) =>
    <String, dynamic>{
      'name': instance.name,
      'allowedUsers': instance.allowedUsers,
      'owner': instance.owner,
      'token': instance.token,
      'errors': instance.errors,
      'errorMessage': instance.errorMessage,
      'type': instance.type,
      'validThru': instance.validThru.toIso8601String(),
      'enable': instance.enable,
    };
