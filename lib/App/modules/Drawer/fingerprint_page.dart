import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/custom_wave.dart';
import '../../helper/Colors2.dart';

class FingerprintPage extends StatefulWidget {
  @override
  _FingerprintPageState createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  double _progress = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
        if (mounted) {
          setState(() {
            _progress = _controller.value;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _enableFingerprint() {
    if (_controller.isAnimating) return; // Prevent overlapping animations
    setState(() {
      _isLoading = true;
      _progress = 0.0;
    });

    _controller.forward(from: 0.0).then((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fingerprint enabled successfully'.tr)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Wave Background
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.newa,
              ),
            ),
          ),
          // Back Button Positioned
          Positioned(
            top: 40, // Adjust for the safe area
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.newa,
                ),
              ),
            ),
          ),
          // Fingerprint Icon
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.fingerprint,
                    size: 50,
                    color: AppColors.newa,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 6.0,
                      color: AppColors.newa,
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fingerprint Unlock'.tr,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enable fingerprint authentication for added security.'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: _enableFingerprint,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.newa.withOpacity(0.1),
                          child: Icon(
                            Icons.fingerprint,
                            size: 50,
                            color: AppColors.newa,
                          ),
                        ),
                        if (_isLoading)
                          CircularProgressIndicator(
                            value: _progress,
                            strokeWidth: 6.0,
                            color: AppColors.newa,
                          ),
                      ],
                    ),
                  ),
                  if (_isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        '${(_progress * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
