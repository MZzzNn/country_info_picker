part of '../country_info_picker.dart';


class CountryInfoModel {
  //Todo:: the name of the country
  String? name;

  ///Todo:: the flag of the country
  final String? flagUri;

  //Todo:: the country code of the country eg. (IT,AF..)
  final String? code;

  //Todo:: the dial code of the country eg. (+39,+93..)
  final String? dialCode;

  //Todo::  the nationality of the country
  final String? nationality;

  //Todo::  max length of phone number for the country
  final int? maxLength;

  //Todo::  hint for phone number for the country
  final String? hintPhone;

  CountryInfoModel({
    this.name,
    this.flagUri,
    this.code,
    this.dialCode,
    this.nationality,
    this.maxLength,
    this.hintPhone,
  });

  factory CountryInfoModel.fromCountryCode(String countryCode) {
    final Map<String, dynamic>? jsonCode = codes.firstWhereOrNull(
      (code) => code['code'] == countryCode,
    );
    return CountryInfoModel.fromJson(jsonCode!);
  }

  factory CountryInfoModel.fromDialCode(String dialCode) {
    final Map<String, dynamic>? jsonCode = codes.firstWhereOrNull(
      (code) => code['dial_code'] == dialCode,
    );
    return CountryInfoModel.fromJson(jsonCode!);
  }

  CountryInfoModel localize(BuildContext context) {
    return this
      ..name = CountryLocalizations.of(context)?.translate(code) ?? name;
  }

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    return CountryInfoModel(
      name: json['name'],
      code: json['code'],
      dialCode: json['dial_code'],
      flagUri: 'assets/flags/${json['code'].toLowerCase()}.png',
      maxLength: json['max_length'],
      hintPhone: json['hint_phone'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'dial_code': dialCode,
        'flag_uri': flagUri ?? '',
        'max_length': maxLength ?? '',
        'hint_phone': hintPhone ?? '',
        'national': nationality ?? '',
      };

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toCountryStringOnly()}";

  String toCountryStringOnly() {
    return '$_cleanName';
  }

  String? get _cleanName {
    return name?.replaceAll(RegExp(r'[[\]]'), '').split(',').first;
  }

}
