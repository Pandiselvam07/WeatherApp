import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectivityChecker extends StatefulWidget {
  final Widget child;
  final bool isDarkMode;

  const ConnectivityChecker(
      {super.key, required this.child, required this.isDarkMode});

  @override
  State<ConnectivityChecker> createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  bool isConnected = true;
  final Connectivity _connectivity = Connectivity(); // Create an instance

  @override
  void initState() {
    super.initState();

    // Check the initial connectivity status
    _connectivity.checkConnectivity().then((List<ConnectivityResult> results) {
      setState(() {
        isConnected =
            results.isNotEmpty && results.first != ConnectivityResult.none;
      });
    });

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      setState(() {
        isConnected =
            results.isNotEmpty && results.first != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? widget.child
        : Container(
            color: widget.isDarkMode ? Colors.black : Colors.white,
            child: Center(
              child: Lottie.asset(
                'assets/no_internet.json', // Path to your Lottie file
                width: 200,
                height: 200,
              ),
            ),
          );
  }
}
