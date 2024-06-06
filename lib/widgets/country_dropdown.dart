import 'package:flutter/material.dart';
import '../models/country.dart';
import '../utils/countries.dart';

class CountryDropdown extends StatelessWidget {
  final Country? selectedCountry;
  final ValueChanged<Country?>? onChanged;
  final FormFieldSetter<Country?>? onSaved;

  const CountryDropdown({
    super.key,
    this.selectedCountry,
    this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Country>(
      decoration: const InputDecoration(
        labelText: 'Country Code',
        hintText: 'Select your country code',
      ),
      items: countries.map((Country country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Row(
            children: [
              Image.asset(
                country.flagPath,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Text('${country.name} (${country.code})'),
            ],
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a country code';
        }
        return null;
      },
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
