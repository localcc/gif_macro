// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetImageCollection on Isar {
  IsarCollection<Image> get images => this.collection();
}

const ImageSchema = CollectionSchema(
  name: r'Image',
  id: -4937595749021071036,
  properties: {
    r'indexing': PropertySchema(
      id: 0,
      name: r'indexing',
      type: IsarType.stringList,
    ),
    r'shorthand': PropertySchema(
      id: 1,
      name: r'shorthand',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 2,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'url': PropertySchema(
      id: 3,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _imageEstimateSize,
  serialize: _imageSerialize,
  deserialize: _imageDeserialize,
  deserializeProp: _imageDeserializeProp,
  idName: r'id',
  indexes: {
    r'indexing': IndexSchema(
      id: 4598167767114457892,
      name: r'indexing',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'indexing',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _imageGetId,
  getLinks: _imageGetLinks,
  attach: _imageAttach,
  version: '3.0.1',
);

int _imageEstimateSize(
  Image object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.indexing.length * 3;
  {
    for (var i = 0; i < object.indexing.length; i++) {
      final value = object.indexing[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.shorthand;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _imageSerialize(
  Image object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.indexing);
  writer.writeString(offsets[1], object.shorthand);
  writer.writeStringList(offsets[2], object.tags);
  writer.writeString(offsets[3], object.url);
}

Image _imageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Image(
    shorthand: reader.readStringOrNull(offsets[1]),
    tags: reader.readStringList(offsets[2]) ?? const [],
    url: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _imageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? const []) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _imageGetId(Image object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _imageGetLinks(Image object) {
  return [];
}

void _imageAttach(IsarCollection<dynamic> col, Id id, Image object) {
  object.id = id;
}

extension ImageQueryWhereSort on QueryBuilder<Image, Image, QWhere> {
  QueryBuilder<Image, Image, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ImageQueryWhere on QueryBuilder<Image, Image, QWhereClause> {
  QueryBuilder<Image, Image, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Image, Image, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Image, Image, QAfterWhereClause> idBetween(
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

  QueryBuilder<Image, Image, QAfterWhereClause> indexingEqualTo(
      List<String> indexing) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'indexing',
        value: [indexing],
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterWhereClause> indexingNotEqualTo(
      List<String> indexing) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'indexing',
              lower: [],
              upper: [indexing],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'indexing',
              lower: [indexing],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'indexing',
              lower: [indexing],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'indexing',
              lower: [],
              upper: [indexing],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ImageQueryFilter on QueryBuilder<Image, Image, QFilterCondition> {
  QueryBuilder<Image, Image, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'indexing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'indexing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'indexing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'indexing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'indexing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'indexing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'indexing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'indexing',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'indexing',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition>
      indexingElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'indexing',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'indexing',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'indexing',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'indexing',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'indexing',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'indexing',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> indexingLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'indexing',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shorthand',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shorthand',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shorthand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shorthand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shorthand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shorthand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shorthand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shorthand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shorthand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shorthand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shorthand',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> shorthandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shorthand',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<Image, Image, QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension ImageQueryObject on QueryBuilder<Image, Image, QFilterCondition> {}

extension ImageQueryLinks on QueryBuilder<Image, Image, QFilterCondition> {}

extension ImageQuerySortBy on QueryBuilder<Image, Image, QSortBy> {
  QueryBuilder<Image, Image, QAfterSortBy> sortByShorthand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shorthand', Sort.asc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByShorthandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shorthand', Sort.desc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension ImageQuerySortThenBy on QueryBuilder<Image, Image, QSortThenBy> {
  QueryBuilder<Image, Image, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByShorthand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shorthand', Sort.asc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByShorthandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shorthand', Sort.desc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<Image, Image, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }
}

extension ImageQueryWhereDistinct on QueryBuilder<Image, Image, QDistinct> {
  QueryBuilder<Image, Image, QDistinct> distinctByIndexing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'indexing');
    });
  }

  QueryBuilder<Image, Image, QDistinct> distinctByShorthand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shorthand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Image, Image, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<Image, Image, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }
}

extension ImageQueryProperty on QueryBuilder<Image, Image, QQueryProperty> {
  QueryBuilder<Image, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Image, List<String>, QQueryOperations> indexingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'indexing');
    });
  }

  QueryBuilder<Image, String?, QQueryOperations> shorthandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shorthand');
    });
  }

  QueryBuilder<Image, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<Image, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }
}
