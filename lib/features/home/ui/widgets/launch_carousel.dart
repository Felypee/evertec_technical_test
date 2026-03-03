import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/routes.dart';
import '../../controller/launch_controller.dart';
import '../../models/launch.dart';
import 'video_launch_card.dart';

/// Carrusel horizontal de lanzamientos con elemento central destacado
class LaunchCarousel extends ConsumerStatefulWidget {
  const LaunchCarousel({
    super.key,
    required this.launches,
  });

  final List<LaunchModel> launches;

  @override
  ConsumerState<LaunchCarousel> createState() => _LaunchCarouselState();
}

class _LaunchCarouselState extends ConsumerState<LaunchCarousel> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: 0,
    );
    _pageController.addListener(_onPageChanged);
    // Pre-cache first few images after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAdjacentImages(0);
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = _pageController.page ?? 0;
    });
    // Pre-cache images for adjacent cards
    _precacheAdjacentImages(_currentPage.round());
  }

  void _precacheAdjacentImages(int currentIndex) {
    // Pre-cache images for 2 cards ahead and 1 behind
    for (int offset = -1; offset <= 2; offset++) {
      final index = currentIndex + offset;
      if (index >= 0 && index < widget.launches.length && index != currentIndex) {
        final launch = widget.launches[index];
        _precacheLaunchImages(launch);
      }
    }
  }

  void _precacheLaunchImages(LaunchModel launch) {
    // Pre-cache YouTube thumbnail if available
    if (launch.hasWebcast) {
      final videoId = _extractYouTubeId(launch.links.webcast!);
      if (videoId != null) {
        CachedNetworkImage.evictFromCache('https://img.youtube.com/vi/$videoId/maxresdefault.jpg');
        precacheImage(
          CachedNetworkImageProvider('https://img.youtube.com/vi/$videoId/maxresdefault.jpg'),
          context,
        );
      }
    }
    // Pre-cache patch image
    if (launch.patchSmall != null) {
      precacheImage(
        CachedNetworkImageProvider(launch.patchSmall!),
        context,
      );
    }
  }

  String? _extractYouTubeId(String url) {
    final patterns = [
      RegExp(r'youtu\.be/([a-zA-Z0-9_-]+)'),
      RegExp(r'youtube\.com/watch\?v=([a-zA-Z0-9_-]+)'),
      RegExp(r'youtube\.com/embed/([a-zA-Z0-9_-]+)'),
      RegExp(r'youtube\.com/v/([a-zA-Z0-9_-]+)'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null) return match.group(1);
    }
    return null;
  }

  void _onLaunchTap(LaunchModel launch) {
    HapticFeedback.mediumImpact();
    ref.read(selectedLaunchProvider.notifier).state = launch;
    context.push('${Routes.detail}/${launch.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.launches.length,
            onPageChanged: (index) {
              HapticFeedback.selectionClick();
            },
            itemBuilder: (context, index) {
              final launch = widget.launches[index];
              final difference = index - _currentPage;

              // Calcular escala basada en la distancia al centro
              final scale = (1 - difference.abs() * 0.12).clamp(0.85, 1.0);

              // Opacidad con transición más suave
              final opacity = (1 - difference.abs() * 0.25).clamp(0.6, 1.0);

              // Efecto parallax vertical - las tarjetas laterales bajan más
              final translateY = difference.abs() * 60;

              // Efecto parallax horizontal para la imagen interna (más intenso)
              final parallaxOffset = difference * 80;

              // Rotación 3D en el eje Y (perspectiva más pronunciada)
              final rotationY = difference * 0.15;

              final isCenter = difference.abs() < 0.5;

              // Matriz de transformación con perspectiva 3D
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(rotationY);

              return Transform(
                alignment: Alignment.center,
                transform: transform,
                child: Transform.translate(
                  offset: Offset(0, translateY),
                  child: Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: VideoLaunchCard(
                        launch: launch,
                        onTap: () => _onLaunchTap(launch),
                        isCenter: isCenter,
                        autoPlay: launch.hasWebcast,
                        parallaxOffset: parallaxOffset,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Indicador de página
        const SizedBox(height: 16),
        _buildPageIndicator(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return SizedBox(
      height: 8,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.launches.length,
        itemBuilder: (context, index) {
          final isActive = (index - _currentPage).abs() < 0.5;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}
