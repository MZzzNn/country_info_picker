part of '../country_info_picker.dart';

enum CountryPickerType {
  CountryOnly,
  NationalityOnly,
  DialCodeOnly,
  DialCodeAndCountryCode,
  Full,
}

// Todo:: Return the value that show in the list
String _getText(CountryInfoModel e, CountryPickerType type) {
  switch (type) {
    case CountryPickerType.DialCodeOnly:
      return e.dialCode ?? '';
    case CountryPickerType.CountryOnly:
      return e.toCountryStringOnly();
    case CountryPickerType.DialCodeAndCountryCode:
      return e.toLongString();
    case CountryPickerType.NationalityOnly:
      return e.nationality ?? '';
    case CountryPickerType.Full:
      return '${e.toLongString()} (${e.code})';
  }
}

// Todo:: Return the value that show in form field
String _getTextValue(CountryInfoModel e, CountryPickerType type) {
  switch (type) {
    case CountryPickerType.DialCodeOnly:
    case CountryPickerType.DialCodeAndCountryCode:
      return e.dialCode ?? '';
    case CountryPickerType.CountryOnly:
      return e.toCountryStringOnly();
    case CountryPickerType.NationalityOnly:
      return e.nationality ?? '';
    case CountryPickerType.Full:
      return '${e.toLongString()} (${e.code})';
  }
}

// Label for the form field
String _getTypeTitle(CountryPickerType type, BuildContext context) {
  switch (type) {
    case CountryPickerType.DialCodeOnly:
    case CountryPickerType.DialCodeAndCountryCode:
      return CountryLocalizations.of(context)?.translate('dial_code') ?? 'Code';
    case CountryPickerType.CountryOnly:
      return CountryLocalizations.of(context)?.translate('country') ??
          'Country';
    case CountryPickerType.NationalityOnly:
      return CountryLocalizations.of(context)?.translate('nationality') ??
          'Nationality';
    case CountryPickerType.Full:
      return CountryLocalizations.of(context)?.translate('country') ??
          'Country';
  }
}

// AppBar title
String _getAppBarTitle(CountryPickerType type, BuildContext context) {
  switch (type) {
    case CountryPickerType.DialCodeOnly:
    case CountryPickerType.DialCodeAndCountryCode:
      return CountryLocalizations.of(context)?.translate('pick_a_country') ??
          'Pick a Count Code';
    case CountryPickerType.CountryOnly:
      return CountryLocalizations.of(context)?.translate('pick_a_country') ??
          'Pick a Country';
    case CountryPickerType.NationalityOnly:
      return CountryLocalizations.of(context)
              ?.translate('pick_a_nationality') ??
          'Pick a Nationality';
    case CountryPickerType.Full:
      return CountryLocalizations.of(context)?.translate('pick_a_country') ??
          'Pick a Country';
  }
}
