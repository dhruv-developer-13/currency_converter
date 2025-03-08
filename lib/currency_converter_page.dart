import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/dropdown.dart';
import 'package:flutter_application_1/widgets/amount_input.dart';
import 'package:flutter_application_1/widgets/total_box.dart';
import 'package:flutter_application_1/widgets/swap_icon.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key}); 

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}
 
class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String fromCurrency = "USD"; //default currency
  String toCurrency = "EUR"; //default currency
  double amount = 0.0; //amount entered by the user
  double rate = 0.0; //rate of the currency entered by the user
  double total = 0.0; //total amount of the currency entered by the user
  
  TextEditingController amountController = TextEditingController(text: "0"); 
  // amountController is an instance of class TextEditingController that is used to control and retrieve the input from a TextField
  // It takes input from user and saves it in amount but has 0 as its default value
  List<String> currencies = [];

  @override
  void initState() {
    super.initState();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async{
  var response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));

  var data = json.decode(response.body);
  setState(() {
    rate = data['rates'][toCurrency];
  });
  }

  void _swapCurrencies() { // Adds functionality to the swap currenicies button by basic logic of swapping the strings and calling the get rate function
    setState(() { 
      String temp = fromCurrency; //temp string to store fromCurrency string
      fromCurrency = toCurrency; //temp fromCurrency to store toCurrency string
      toCurrency = temp; //toCurrency string to store temp string
      _getRate(); //getRate function to get the rate of the current currency in fromCurrency  
        total = amount * rate;
      });
  }

  Future<void> _getRate() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
        rate = data['rates'][toCurrency] ?? 0.0; // Default to 0 if null
      });
    } else {
      throw Exception('Failed to load exchange rates. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    debugPrint('Error fetching exchange rate: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 208, 221),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 157, 185), //appbar background color transparent 
        elevation: 0,
        foregroundColor: Colors.black, 
        title: const Text("Currency Converter"), //app title
        centerTitle: true, //centers the title  of the application
      ),

      body: Padding(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView( //main child scroll view
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20),
              child: Image.asset(
                'images/currency_converter2.png',
                width: 300,
                height: 250,
              ),
              ),

              const SizedBox(height: 20), //adds vertical space between the image and the textfield

                Amount (
                controller: amountController,
                onChanged: (value) {
                  if (value !='') {
                    setState(() {
                      amount = double.parse(value); //converts the string value to a double value
                      total = amount * rate; //basic formulae for the total amount
                    });
                  }
                },
              ),

              const SizedBox(height: 40), //adds vertical space between the textfield and the dropdowns

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CurrencyDropdown ( // Adding CurrencyDropdown widget to display the currency dropdowns.
                    value: fromCurrency,
                    currencies: currencies,
                    onChanged: (newValue) {
                      setState(() {
                        fromCurrency = newValue ?? fromCurrency;
                        _getRate();
                      });
                    }, 
                    labelText: "From",
                  ),
                  
                  const SizedBox(width: 40), //adds horizontal space between the dropdowns

                  SwapButton( // Adding SwapIcon widget to swap the currencies
                    onPressed: _swapCurrencies,
                    ),
                  const SizedBox(width: 40), // adds horizontal space between the dropdowns

                  CurrencyDropdown ( // Adding CurrencyDropdown widget to display the currency dropdowns.
                    value: toCurrency,
                    currencies: currencies,
                    onChanged: (newValue) {
                      setState(() {
                        fromCurrency = newValue !;
                        _getRate();
                      });
                    },  
                    labelText: "To",         
                    ),
                  ], //childerns for currency dropdowns                
                ),
                
                const SizedBox(height: 15), //adds vertical space between the dropdowns and the text
                
                Text( // Displaying the rate of the currency entered by the user.
                  "Rate : $rate",
                  style: TextStyle(
                  fontSize: 20, color: Color(0xFF00394C),
                ),
                ),
                
                const SizedBox(height: 15),

                TotalBox ( // Adding TotalBox widget to display the total amount of the currency entered by the user.)
                  total: total,
                  ),

            ],),
          ),
        ),
      );
    }
  }