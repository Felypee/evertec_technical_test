import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../config/themes/color_tokens.dart';

/// Banner que muestra el estado de conectividad offline
class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ColorTokens.mortyYellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 16,
            color: Colors.black87,
          ),
          const SizedBox(width: 8),
          Text(
            'connectivity.offline'.tr(),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    )
        .animate()
        .slideY(begin: -1, end: 0, duration: 300.ms)
        .fadeIn(duration: 300.ms);
  }
}

/// Widget que envuelve contenido y muestra mensaje cuando está offline
class OfflineAwareWidget extends StatelessWidget {
  const OfflineAwareWidget({
    super.key,
    required this.isOffline,
    required this.child,
  });

  final bool isOffline;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isOffline) const ConnectivityBanner(),
        Expanded(child: child),
      ],
    );
  }
}
