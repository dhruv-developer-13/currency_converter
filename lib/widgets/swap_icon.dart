import 'package:flutter/material.dart';

class SwapButton extends StatefulWidget { //stateful widget as it involves an animation of rotation that chages over time
  final VoidCallback onPressed;

  const SwapButton({
    super.key, 
    required this.onPressed, // Function to be called when the button is pressed
    });

  @override
  State<SwapButton> createState() => _SwapButtonState(); //creates a state object for the SwapButton and returns an instance which manages the animation and rotation of the button
}

class _SwapButtonState extends State<SwapButton> {
  double _rotationAngle = 0.0; // Controls rotation

  void _animateRotation() { //function to animate the rotation of the button
    setState(() {
      _rotationAngle += 3.14; // Rotate 180 degrees
    });

    widget.onPressed(); // Call the swap function
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation( // AnimatedRotation widget for smooth rotation
      turns: _rotationAngle / (2 * 3.14), // Convert radians to turns as it takes values between 0.0 and 1.0 where 0.0 means no rotation and 1.0 means 180 degrees rotation
      duration: const Duration(milliseconds: 300), // Smooth animation
      child: Container( // Container for the button
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:  const Color(0xFF469DB9),
          border: Border.all(
            color: const Color(0xFF00394C), 
            width: 2,
            ),
          ),

        child: IconButton(
          onPressed: _animateRotation, // Call the animateRotation function on button click
          icon: const Icon(
            Icons.swap_horiz, // Horizontal Swap icon
            size: 40, 
            color: Color(0xFF00394C),
            ),
          ),
        ),
      );
    }
}
