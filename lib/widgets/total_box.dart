import 'package:flutter/material.dart';

class TotalBox extends StatelessWidget {
  final double total; // Accept total value dynamically

  const TotalBox ({
    super.key, 
    required this.total // Required parameter for total value
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.95, // Set width of the container fitting the screen width
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 47, 94, 131),
            const Color.fromARGB(255, 22, 103, 141)
          ], // Gradient colors
          begin: Alignment.topLeft, // Start from top left
          end: Alignment.bottomRight, // End at bottom right
        ),
        borderRadius: BorderRadius.circular(12), // Rounded edges
        border: Border.all(
          color: const Color(0xFF00394C),
          width: 1,
        ),
        ),

      child: Center(
        child: Text(
          'Total: ${total.toStringAsFixed(3)}', // Display the total value dynamically
          style: const TextStyle (
            color: Colors.white, 
            fontSize: 20, 
            ),
        ),
      ),
    );
  }
}
