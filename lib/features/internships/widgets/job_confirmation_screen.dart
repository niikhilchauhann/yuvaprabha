import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yuvaprabha/config/api/export.dart';

class JobConfirmationScreen extends StatefulWidget {
  const JobConfirmationScreen({super.key});

  @override
  State<JobConfirmationScreen> createState() => _JobConfirmationScreenState();
}

class _JobConfirmationScreenState extends State<JobConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/job_applied.json',
              height: 300,
              width: 300,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
                _controller.repeat();
              },
              repeat: true,
              frameRate: FrameRate.max,
            ),
            const Text(
              'Application Sent!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'You can expect a response within a week',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            h12,
            Text(
              'You will be redirected...',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
