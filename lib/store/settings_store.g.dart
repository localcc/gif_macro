// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetSettingsCollection on Isar {
  IsarCollection<Settings> get settings => this.collection();
}

const SettingsSchema = CollectionSchema(
  name: r'Settings',
  id: -8656046621518759136,
  properties: {
    r'runOnStartup': PropertySchema(
      id: 0,
      name: r'runOnStartup',
      type: IsarType.bool,
    ),
    r'toggleWindowKeybind': PropertySchema(
      id: 1,
      name: r'toggleWindowKeybind',
      type: IsarType.longList,
    )
  },
  estimateSize: _settingsEstimateSize,
  serialize: _settingsSerialize,
  deserialize: _settingsDeserialize,
  deserializeProp: _settingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _settingsGetId,
  getLinks: _settingsGetLinks,
  attach: _settingsAttach,
  version: '3.0.1',
);

int _settingsEstimateSize(
  Settings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.toggleWindowKeybind.length * 8;
  return bytesCount;
}

void _settingsSerialize(
  Settings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.runOnStartup);
  writer.writeLongList(offsets[1], object.toggleWindowKeybind);
}

Settings _settingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Settings(
    runOnStartup: reader.readBool(offsets[0]),
    toggleWindowKeybind: reader.readLongList(offsets[1]) ?? [],
  );
  object.id = id;
  return object;
}

P _settingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingsGetId(Settings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingsGetLinks(Settings object) {
  return [];
}

void _settingsAttach(IsarCollection<dynamic> col, Id id, Settings object) {
  object.id = id;
}

extension SettingsQueryWhereSort on QueryBuilder<Settings, Settings, QWhere> {
  QueryBuilder<Settings, Settings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingsQueryWhere on QueryBuilder<Settings, Settings, QWhereClause> {
  QueryBuilder<Settings, Settings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SettingsQueryFilter
    on QueryBuilder<Settings, Settings, QFilterCondition> {
  QueryBuilder<Settings, Settings, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition> runOnStartupEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'runOnStartup',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toggleWindowKeybind',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toggleWindowKeybind',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toggleWindowKeybind',
        value: value,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toggleWindowKeybind',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'toggleWindowKeybind',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'toggleWindowKeybind',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'toggleWindowKeybind',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'toggleWindowKeybind',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'toggleWindowKeybind',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Settings, Settings, QAfterFilterCondition>
      toggleWindowKeybindLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'toggleWindowKeybind',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SettingsQueryObject
    on QueryBuilder<Settings, Settings, QFilterCondition> {}

extension SettingsQueryLinks
    on QueryBuilder<Settings, Settings, QFilterCondition> {}

extension SettingsQuerySortBy on QueryBuilder<Settings, Settings, QSortBy> {
  QueryBuilder<Settings, Settings, QAfterSortBy> sortByRunOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runOnStartup', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> sortByRunOnStartupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runOnStartup', Sort.desc);
    });
  }
}

extension SettingsQuerySortThenBy
    on QueryBuilder<Settings, Settings, QSortThenBy> {
  QueryBuilder<Settings, Settings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByRunOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runOnStartup', Sort.asc);
    });
  }

  QueryBuilder<Settings, Settings, QAfterSortBy> thenByRunOnStartupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runOnStartup', Sort.desc);
    });
  }
}

extension SettingsQueryWhereDistinct
    on QueryBuilder<Settings, Settings, QDistinct> {
  QueryBuilder<Settings, Settings, QDistinct> distinctByRunOnStartup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'runOnStartup');
    });
  }

  QueryBuilder<Settings, Settings, QDistinct> distinctByToggleWindowKeybind() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toggleWindowKeybind');
    });
  }
}

extension SettingsQueryProperty
    on QueryBuilder<Settings, Settings, QQueryProperty> {
  QueryBuilder<Settings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Settings, bool, QQueryOperations> runOnStartupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'runOnStartup');
    });
  }

  QueryBuilder<Settings, List<int>, QQueryOperations>
      toggleWindowKeybindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toggleWindowKeybind');
    });
  }
}
