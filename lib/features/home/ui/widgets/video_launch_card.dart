import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../config/themes/color_tokens.dart';
import '../../models/launch.dart';

/// Tarjeta de lanzamiento con video estilo TikTok y efecto parallax
class VideoLaunchCard extends StatefulWidget {
  const VideoLaunchCard({
    super.key,
    required this.launch,
    required this.onTap,
    this.isCenter = false,
    this.autoPlay = false,
    this.parallaxOffset = 0,
  });

  final LaunchModel launch;
  final VoidCallback onTap;
  final bool isCenter;
  final bool autoPlay;
  final double parallaxOffset;

  @override
  State<VideoLaunchCard> createState() => _VideoLaunchCardState();
}

class _VideoLaunchCardState extends State<VideoLaunchCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(VideoLaunchCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Animar el botón de play cuando está centrado y tiene video
    if (widget.isCenter && widget.launch.hasWebcast && !oldWidget.isCenter) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isCenter && oldWidget.isCenter) {
      _pulseController.stop();
      _pulseController.reset();
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
      if (match != null) {
        return match.group(1);
      }
    }
    return null;
  }

  String _getYouTubeThumbnail(String videoId, {bool highQuality = true}) {
    // maxresdefault es la mejor calidad, hqdefault como fallback
    return highQuality
        ? 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg'
        : 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _getStatusColor() {
    if (widget.launch.success == null) {
      return ColorTokens.statusUpcoming;
    }
    return widget.launch.success!
        ? ColorTokens.statusSuccess
        : ColorTokens.statusFailed;
  }

  String _getStatusText() {
    if (widget.launch.success == null) return 'status.upcoming'.tr();
    return widget.launch.success! ? 'status.success'.tr() : 'status.failed'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor();
    final hasVideo = widget.launch.hasWebcast;
    final videoId =
        hasVideo ? _extractYouTubeId(widget.launch.links.webcast!) : null;

    return GestureDetector(
      onTap: widget.onTap, // Siempre va al detalle
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: widget.isCenter
                  ? (hasVideo
                      ? Colors.red.withValues(alpha: 0.4)
                      : ColorTokens.spaceXBlue.withValues(alpha: 0.3))
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: widget.isCenter ? 24 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Fondo: thumbnail de YouTube o imagen del parche con efecto parallax
              Hero(
                tag: 'launch-image-${widget.launch.id}',
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Zoom de 1.3x para cubrir el área durante el parallax
                    const double zoomScale = 1.3;
                    return ClipRect(
                      child: Transform.translate(
                        offset: Offset(widget.parallaxOffset, 0),
                        child: Transform.scale(
                          scale: zoomScale,
                          child: _buildBackground(theme, videoId),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Gradiente oscuro para legibilidad
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.0, 0.3, 1.0],
                  ),
                ),
              ),

              // Botón de play central (solo si tiene video)
              if (hasVideo) _buildPlayButton(),

              // Badge de video disponible
              if (hasVideo)
                Positioned(
                  top: 60,
                  right: 16,
                  child: _buildVideoBadge(),
                ),

              // Borde brillante si está centrado
              if (widget.isCenter)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: hasVideo
                            ? Colors.red.withValues(alpha: 0.8)
                            : ColorTokens.spaceXBlue.withValues(alpha: 0.5),
                        width: 3,
                      ),
                    ),
                  ),
                ),

              // Indicador de estado
              Positioned(
                top: 16,
                right: 16,
                child: _buildStatusBadge(statusColor),
              ),

              // Número de vuelo
              Positioned(
                top: 16,
                left: 16,
                child: _buildFlightNumber(),
              ),

              // Información del lanzamiento
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: _buildLaunchInfo(hasVideo),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(ThemeData theme, String? videoId) {
    // Si tiene video, mostrar thumbnail de YouTube
    if (videoId != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail de YouTube con fallback
          CachedNetworkImage(
            imageUrl: _getYouTubeThumbnail(videoId),
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildShimmer(theme),
            errorWidget: (context, url, error) {
              // Intentar con calidad menor
              return CachedNetworkImage(
                imageUrl: _getYouTubeThumbnail(videoId, highQuality: false),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    _buildFallbackImage(theme),
              );
            },
          ),
        ],
      );
    }

    return _buildFallbackImage(theme);
  }

  Widget _buildPlayButton() {
    return Center(
      child: Hero(
        tag: 'launch-play-${widget.launch.id}',
        child: Material(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale =
                  widget.isCenter ? 1.0 + (_pulseController.value * 0.1) : 1.0;
              return Transform.scale(
                scale: scale,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color:
                        Colors.red.withValues(alpha: widget.isCenter ? 0.9 : 0.7),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.5),
                        blurRadius: widget.isCenter ? 30 : 15,
                        spreadRadius: widget.isCenter ? 5 : 0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 56,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    )
        .animate(target: widget.isCenter ? 1 : 0)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0))
        .fadeIn();
  }

  Widget _buildVideoBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Color(0xFFFF4444)],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .fadeIn(duration: 500.ms)
              .then()
              .fadeOut(duration: 500.ms),
          const SizedBox(width: 6),
          Text(
            'card.video'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(Color statusColor) {
    return Hero(
      tag: 'launch-status-${widget.launch.id}',
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                _getStatusText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlightNumber() {
    return Hero(
      tag: 'launch-flight-${widget.launch.id}',
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '#${widget.launch.flightNumber}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLaunchInfo(bool hasVideo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Iconos de enlaces disponibles
        if (widget.launch.hasLinks)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                if (widget.launch.hasWebcast)
                  _buildLinkChip(Icons.play_circle_fill, 'card.watch'.tr(), Colors.red),
                if (widget.launch.hasWikipedia)
                  _buildLinkChip(Icons.menu_book, 'card.wiki'.tr(), Colors.blue),
                if (widget.launch.hasArticle)
                  _buildLinkChip(Icons.article, 'card.news'.tr(), Colors.orange),
              ],
            ),
          ),

        Hero(
          tag: 'launch-name-${widget.launch.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.launch.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(color: Colors.black54, blurRadius: 4),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        const SizedBox(height: 4),

        Hero(
          tag: 'launch-rocket-${widget.launch.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.launch.rocketName ?? 'detail.unknown_rocket'.tr(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Hero(
              tag: 'launch-date-${widget.launch.id}',
              child: Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.launch.formattedDate,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (widget.isCenter)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.touch_app, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      hasVideo ? 'card.tap_details'.tr() : 'card.tap_view'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildFallbackImage(ThemeData theme) {
    final patchUrl = widget.launch.patchSmall;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorTokens.cosmicGray,
            ColorTokens.spaceBlack,
          ],
        ),
      ),
      child: patchUrl != null
          ? CachedNetworkImage(
              imageUrl: patchUrl,
              fit: BoxFit.contain,
              placeholder: (context, url) => _buildShimmer(theme),
              errorWidget: (context, url, error) => _buildPlaceholder(),
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildShimmer(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? ColorTokens.spaceBlack : Colors.grey[300]!,
      highlightColor: isDark ? ColorTokens.cosmicGray : Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? ColorTokens.cosmicGray : Colors.grey[400]!,
              isDark ? ColorTokens.spaceBlack : Colors.grey[300]!,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Play button placeholder
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Bottom gradient placeholder
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.rocket_launch_outlined,
        size: 80,
        color: Colors.white.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildLinkChip(IconData icon, String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
