import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double progress;

  const CustomCircularButton({
    super.key,
    required this.onPressed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final double outerSize = 80.w;
    final double buttonSize = 60.w;
    final double strokeWidth = 3.0.w;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: outerSize,
            height: outerSize,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade300),
            ),
          ),
          SizedBox(
            width: outerSize,
            height: outerSize,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: strokeWidth,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
          ),
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.zero,
                elevation: 4,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
