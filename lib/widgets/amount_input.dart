import 'package:flutter/material.dart';

class Amount extends StatefulWidget { //stateful widget class because its state changes due to increments/decrements actions
  final TextEditingController controller;
  final ValueChanged<String> onChanged; 

  const Amount({
    super.key, required this.controller, 
    required this.onChanged //function to handle the change in the amount
    });

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  //function to handle increment button click
  void _increment() {
    int currentValue = int.tryParse(widget.controller.text) ?? 0; //convert to integer
    setState(() {
      currentValue++;
      widget.controller.text = currentValue.toString(); //convert back to string to update the text field
      widget.onChanged(widget.controller.text);
    });
  }

  //function to handle decrement button click
  void _decrement() {
    int currentValue = int.tryParse(widget.controller.text) ?? 0; // convert to integer
    if (currentValue > 0) { // Prevent negative values
      setState(() {
        currentValue--;
        widget.controller.text = currentValue.toString(); //convert back to string to update the text field
        widget.onChanged(widget.controller.text); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.95, // Set width of the container
      height: 60, // Set height of the container
      padding: const EdgeInsets.symmetric(horizontal: 8), // Add padding to both sides of the container
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 47, 94, 131),
            const Color.fromARGB(255, 22, 103, 141)
          ], // Gradient colors
          begin: Alignment.topLeft, // Start from top left
          end: Alignment.bottomRight, // End at bottom right
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all( // Add border to the container
          color: Colors.black,
          width: 2,
          ),
      ),
      child: Row(
        children: [
          // Decrement Button
          IconButton(
            icon: const Icon(
              Icons.remove, // Minus icon
              color:  Colors.black, // Black color for icon
              ),
            onPressed: _decrement,
          ),
          // Amount TextField
          Expanded(
            child: TextField(
              controller: widget.controller, // Set controller
              keyboardType: TextInputType.number, // Set keyboard type to number
              textAlign: TextAlign.center, // Align text to center
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Amount",
                labelStyle: const TextStyle(color: Colors.black),
                floatingLabelAlignment: FloatingLabelAlignment.center, // Align floating label to center
                border: InputBorder.none, // Remove extra border inside Container
              ),
              onChanged: widget.onChanged,
            ),
          ),
          // Increment Button
          IconButton(
            icon: const Icon (
              Icons.add, // Plus icon
              color:  Colors.black, // Black color for icon
              ),
            onPressed: _increment,
          ),
        ],
      ),
    );
  }
}
