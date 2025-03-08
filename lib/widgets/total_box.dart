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
      width: 180,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 111, 156, 190),
            const Color.fromARGB(255, 43, 120, 156)
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
