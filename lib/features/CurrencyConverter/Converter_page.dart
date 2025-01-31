import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConverterPage extends StatefulWidget{
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPage();
}

class _ConverterPage extends State<ConverterPage> {

  String fromCurrency = "USD";
  String toCurrency = "INR";
  double rate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();
  List<String> currencies = [];


  @override
  void initState() {
    super.initState();
    _getCurrencies();
  }

  Future<void> _getCurrencies() async {
    var response = await http.get(Uri.parse("https://api.exchangerate-api.com/v4/latest/USD"));

    var data = json.decode(response.body);

    setState(() {
      currencies = (data['rates'] as  Map<String,dynamic>).keys.toList();
      rate = data['rates'][toCurrency];
    });
  }

  Future<void> _getrate() async {
    var response = await http.get(Uri.parse("https://api.exchangerate-api.com/v4/latest/$fromCurrency"));
    var data = json.decode(response.body);
    setState(() {
      rate = data['rates'][toCurrency];
    });
  }

  Future<void> _swapCurrencies() async {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      _getrate();
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: const Color(0xFF1d2360),
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 10,
         foregroundColor: Colors.white,
         title: const Text("Currency Converter"),
       ),
       body: Padding(
         padding: const EdgeInsets.all(20),
         child: SingleChildScrollView(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(40),
                 child: Image.asset(
                   'images/conversion.jpg',
                   width: MediaQuery.of(context).size.width/2,
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                 child: TextField(
                   controller: amountController,
                   keyboardType: TextInputType.number,
                   style: const TextStyle(
                     color: Colors.white,
                     fontSize: 20,
                   ),
                   decoration: InputDecoration(
                     label: const Text("Enter Amount",style: TextStyle(color: Colors.white),),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                     labelStyle: TextStyle(
                       color: Colors.white.withOpacity(0.5),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                       borderSide: const BorderSide(
                         color: Colors.white,
                       )
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20),
                       borderSide: const BorderSide(
                         color: Colors.white,
                       )
                     )
                   ),
                   onChanged: (value){
                     if(value.isNotEmpty){
                       setState(() {
                         double amount = double.parse(value);
                         total = amount * rate;
                       });
                     }
                   }
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     SizedBox(
                       width: 100,
                       child: Container(
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.white, width: 2), // White border
                           borderRadius: BorderRadius.circular(10),
                         ),
                         padding: const EdgeInsets.symmetric(horizontal: 10), // Adds some padding inside the border
                         child: DropdownButton<String>(
                           dropdownColor: const Color(0xff126885),
                           value: fromCurrency,
                           isExpanded: true,
                           style: const TextStyle(color: Colors.white),
                           underline: const SizedBox(), // Removes the default underline
                           items: currencies.map((String currency) {
                             return DropdownMenuItem<String>(
                               value: currency,
                               child: Text(currency),
                             );
                           }).toList(),
                           onChanged: (newValue) {
                             setState(() {
                               fromCurrency = newValue!;
                               _getrate();
                             });
                           },
                         ),
                       ),
                     ),
                     IconButton(
                       onPressed: _swapCurrencies,
                       icon: const Icon(
                         Icons.swap_horiz,
                         color: Colors.white,
                         size: 40,
                       ),
                     ),
                     SizedBox(
                       width: 100,
                       child: Container(
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.white, width: 2), // White border
                           borderRadius: BorderRadius.circular(10),
                         ),
                         padding: const EdgeInsets.symmetric(horizontal: 10), // Adds some padding inside the border
                         child: DropdownButton<String>(
                           dropdownColor: const Color(0xff126885),
                           value: toCurrency,
                           isExpanded: true,
                           style: const TextStyle(color: Colors.white),
                           underline: const SizedBox(), // Removes the default underline
                           items: currencies.map((String currency) {
                             return DropdownMenuItem<String>(
                               value: currency,
                               child: Text(currency),
                             );
                           }).toList(),
                           onChanged: (newValue) {
                             setState(() {
                               toCurrency = newValue!;
                               _getrate();
                             });
                           },
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 10,),
               Text(
                 "Rate: $rate",
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
               const SizedBox(height: 20,),
               Text(
                 "Total: ${total.toStringAsFixed(3)}",
                 style: const TextStyle(
                   color: Colors.greenAccent,
                   fontSize: 20,
                 )
               )
             ],
           )
         ),

       ),
     );
  }
}

