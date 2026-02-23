import 'package:flutter/material.dart';

class ErrorInfoPage extends StatelessWidget {
  final String errorInfo;
  final VoidCallback onReloadPage;

  const ErrorInfoPage({
    super.key,
    required this.errorInfo,
    required this.onReloadPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Image.asset(
              'assets/error_img.png',
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error_outline, size: 100),
            ),
          ),
          Text(
            'Error',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              letterSpacing: 0.1,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
            child: Text(
              errorInfo,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ElevatedButton.icon(
              onPressed: onReloadPage,
              icon: const Icon(Icons.refresh),
              label: const Text('Reload'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
