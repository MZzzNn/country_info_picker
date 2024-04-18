# Country Info Picker

[![pub package](https://img.shields.io/pub/v/country_info_picker.svg)](https://pub.dev/packages/country_info_picker)

A Flutter package to select a country from a list, with features like country name, flag, dial code, code, nationality, and the maximum length of a phone number.

<img alt="Country Info Picker" height="400" src="https://raw.githubusercontent.com/MZzzNn/country_info_picker/main/assets/img.png" width="200"/>

## Features
- Show country flag.
- Show country dial code.
- Show country code.
- Show country
- Show Nationality
- Show the maximum length of a phone number.
- Select a country from a list.
- Get the selected country information.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
country_info_picker: ^0.0.1
```

Import the package in your file:

```dart
import 'package:country_info_picker/country_info_picker.dart';
```

Use the `CountryInfoPicker` widget:

```dart
CountryInfoPicker(
  onChanged: (CountryInfoModel country) {
    print('Select country: ${country.toLongString()}');
  },
);
```

## Example
```dart
import 'package:country_info_picker/country_info_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Country Info Picker Example'),
        ),
        body: Center(
          child: CountryInfoPicker(
            onChanged: (CountryInfoModel country) {
              print('Select country: ${country.toLongString()}');
            },
          ),
        ),
      ),
    );
  }
}
```

## Parameters
- `onChanged`: A callback function that is called when a country is selected.
- `selectedCountry`: The default selected country.
- `showFlag`: Whether to show the flag of the country.
- `showDialCode`: Whether to show the dial code of the country.
- `showCode`: Whether to show the code of the country.

## Contributions
Contributions of any kind are more than welcome! Feel free to fork and improve country_info_picker in any way you want, make a pull request, or open an issue.


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

