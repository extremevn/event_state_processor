import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Pokemon {
  @JsonKey(name: 'name', disallowNullValue: true)
  final String name;

  @JsonKey(disallowNullValue: true)
  final String id;

  @JsonKey(name: 'imageurl', disallowNullValue: true)
  final String imageUrl;

  @JsonKey(name: 'xdescription', defaultValue: '')
  final String xDescription;

  @JsonKey(name: 'ydescription', defaultValue: '')
  final String yDescription;

  @JsonKey(defaultValue: '')
  final String height;

  @JsonKey(defaultValue: '')
  final String category;

  @JsonKey(defaultValue: '')
  final String weight;

  @JsonKey(name: 'typeofpokemon', disallowNullValue: true)
  final List<String> types;

  @JsonKey(defaultValue: [])
  final List<String> weaknesses;

  @JsonKey(defaultValue: [])
  final List<String> evolutions;

  @JsonKey(defaultValue: [])
  final List<String> abilities;

  @JsonKey(disallowNullValue: true)
  final num hp;

  @JsonKey(disallowNullValue: true)
  final num attack;

  @JsonKey(disallowNullValue: true)
  final num defense;

  @JsonKey(name: 'special_attack', disallowNullValue: true)
  final num specialAttack;

  @JsonKey(name: 'special_defense', disallowNullValue: true)
  final num specialDefense;

  @JsonKey(disallowNullValue: true)
  final num speed;

  @JsonKey(disallowNullValue: true)
  final num total;

  @JsonKey(name: 'male_percentage', disallowNullValue: true)
  final String genderMalePercentage;

  @JsonKey(name: 'female_percentage', disallowNullValue: true)
  final String genderFemalePercentage;

  @JsonKey(disallowNullValue: true)
  final num genderless;

  @JsonKey(defaultValue: '')
  final String cycles;

  @JsonKey(name: 'egg_groups', disallowNullValue: true)
  final String eggGroups;

  @JsonKey(name: 'evolvedfrom')
  final String evolvedFrom;

  @JsonKey(defaultValue: '')
  final String reason;

  @JsonKey(name: 'base_exp', defaultValue: '0')
  final String baseExp;

  Pokemon(
    this.name,
    this.id,
    this.imageUrl,
    this.xDescription,
    this.yDescription,
    this.height,
    this.category,
    this.weight,
    this.types,
    this.weaknesses,
    this.evolutions,
    this.abilities,
    this.hp,
    this.attack,
    this.defense,
    this.specialAttack,
    this.specialDefense,
    this.speed,
    this.total,
    this.genderMalePercentage,
    this.genderFemalePercentage,
    this.genderless,
    this.cycles,
    this.eggGroups,
    this.evolvedFrom,
    this.reason,
    this.baseExp,
  );

  factory Pokemon.fromJson(Map<String, dynamic> json) => _pokemonFromJson(json);
}

Pokemon _pokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
      json['name'] as String,
      json['id'] as String,
      json['imageurl'] as String,
      json['xdescription'] as String,
      json['ydescription'] as String,
      json['height'] as String,
      json['category'] as String,
      json['weight'] as String,
      (json['typeofpokemon'] as List).map((e) => e as String? ?? '').toList(),
      (json['weaknesses'] as List).map((e) => e as String? ?? '').toList(),
      (json['evolutions'] as List).map((e) => e as String? ?? '').toList(),
      (json['abilities'] as List).map((e) => e as String? ?? '').toList(),
      json['hp'] as num,
      json['attack'] as num,
      json['defense'] as num,
      json['special_attack'] as num,
      json['special_defense'] as num,
      json['speed'] as num,
      json['total'] as num,
      json['male_percentage'] as String? ?? '',
      json['female_percentage'] as String? ??'',
      json['genderless'] as num,
      json['cycles'] as String? ?? '',
      json['egg_groups'] as String,
      json['evolvedfrom'] as String,
      json['reason'] as String? ?? '',
      json['base_exp'] as String? ?? '0');
}
