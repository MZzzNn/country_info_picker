import 'package:flutter/material.dart';
import 'package:country_info_picker/country_info_picker.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Info Picker Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountryInfoModel? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Country Info Picker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Country: ${selectedCountry?.name ?? 'None'}',
              style: Theme.of(context).textTheme.headline6,
            ),

            //Todo:: There Section To Select Country Code then Enter Phone Number
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CountryInfoPicker(
                        favorite: const ['+20', '+966'],
                        initialSelection: 'EG',
                        onChanged: (CountryInfoModel value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 7,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(selectedCountry?.maxLength),
                        ],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: selectedCountry?.hintPhone,
                          labelText: "Mobile Number *",
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Todo:: There Section To Select your Country
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: CountryInfoPicker(
                countryPickerType: CountryPickerType.CountryOnly,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                suffixIcon: const Icon(
                  FontAwesomeIcons.chevronDown,
                  color: Color.fromRGBO(51, 71, 96, 0.4),
                  size: 17,
                ),
                favorite: const ['SA', 'EG'],
                onChanged: (CountryInfoModel value) {

                },
              ),
            ),

            //Todo:: There Section To Select your Nationality
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: CountryInfoPicker(
                countryPickerType: CountryPickerType.NationalityOnly,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                suffixIcon: const Icon(
                  FontAwesomeIcons.chevronDown,
                  color: Color.fromRGBO(51, 71, 96, 0.4),
                  size: 17,
                ),
                favorite: const ['SA', 'EG'],
                onChanged: (CountryInfoModel value) {

                },
              ),
            ),





          ],
        ),
      ),
    );
  }
}
