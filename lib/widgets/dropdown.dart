import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget { //immutable widget
  final String value; //currently selected currency
  final List<String> currencies; //list of currencies
  final ValueChanged<String?> onChanged; //function to handle currency change
  final String labelText; //label text for the dropdown

  const CurrencyDropdown({
    super.key,
    required this.value,
    required this.currencies,
    required this.onChanged,
    required this.labelText, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
      color: const Color.fromARGB(255, 70, 157, 185),
      borderRadius: BorderRadius.circular(18),  
      ),
      child: DropdownButtonFormField<String>(
        value: currencies.contains(value) ? value : null, // Checks and Set it as the selected value and if it is not in the list then Set value to null
        isExpanded: true, // Dropdown expands to fit the container
        dropdownColor:  const Color.fromARGB(255, 48, 147, 180), 
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          labelStyle: const TextStyle(color: Colors.black),

          enabledBorder: OutlineInputBorder( // Border when not focused
            borderRadius: BorderRadius.circular(18), // Rounded edges 
            borderSide: const BorderSide(color: Color(0xFF00394C)), // Dark blue color for border
          ),

          focusedBorder: OutlineInputBorder( // Border when focused
            borderRadius: BorderRadius.circular(18), // Rounded edges 
            borderSide: const BorderSide(color: Color.fromARGB(255, 3, 81, 107)), // Dark blue color for border
          ),
          ),
        
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        items: currencies.map((String currency) { // Mapping the currencies to DropdownMenuItem items
          return DropdownMenuItem<String>(
            value: currency, //represents the internal value that is used for tracking the selected option
            child: Text(currency), //visible text for the DropdownMenuItem
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}



