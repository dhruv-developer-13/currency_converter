import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key}); 

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}
 
class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String fromCurrency = "USD";
  String toCurrency = "EUR";
  double rate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();
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

  void _swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      _getRate();
    });

  }


  Future<void> _getRate() async{
  var response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'));

  var data = json.decode(response.body);
  setState(() {
    currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
    rate = data['rates'][toCurrency];
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 208, 221),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text("Currency Converter"), //app title
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(0),
              child: Image.asset(
                'images/currency_converter2.png',
                width:MediaQuery.of(context).size.width/2,
              ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 10),
                child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style:TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),                  
                ),

                decoration: InputDecoration(
                  labelText: "Amount",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12) ,
                    borderSide: BorderSide(
                      color: Color(0xFF00394C),
                    ),
                  ),

                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12) ,
                    borderSide: BorderSide(
                      color: Color(0xFF00394C),
                    ),
                  ),
                ),

                onChanged: (value) {
                  if (value !='') {
                    setState(() {
                      double amount = double.parse(value);
                      total = amount * rate;
                    });
                  }
                },

              ),
              ),
              const SizedBox(height: 40), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: fromCurrency,
                    isExpanded: true,
                    dropdownColor: Color.fromARGB(255, 191, 208, 221),
                    style: TextStyle(color:Color.fromARGB(255, 0, 0, 0),),
                    items: currencies.map((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        fromCurrency = newValue !;
                        _getRate();
                      });
                    },

                    ),
                  
                  IconButton(
                      onPressed: _swapCurrencies,
                      icon: Icon(
                        Icons.swap_horiz,
                        size: 40,
                        color: const Color(0xFF00394C),
                      ),
                    ),

                  DropdownButton<String>(
                    value: toCurrency,
                    isExpanded: true,
                    dropdownColor: Color.fromARGB(255, 191, 208, 221),
                    style: TextStyle(color:Color.fromARGB(255, 0, 0, 0),),
                    items: currencies.map((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        toCurrency = newValue !;
                        _getRate();
                      });
                    },

                    ),
                    
                  ],                
                ),
                SizedBox(height: 10),
                Text("Rate $rate",
                style: TextStyle(
                  fontSize: 20, color: Color(0xFF00394C),
                ),
                ),
                SizedBox(height : 20),
                Text(
                  total.toStringAsFixed(3),
                  style: TextStyle(
                    color: Color(0xFFFF6500),
                    fontSize: 40,
                  ),
                ),

                ],  
              ),
            ),
          ),
        );
  }
}