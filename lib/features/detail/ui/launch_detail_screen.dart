import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/themes/color_tokens.dart';
import '../../home/controller/launch_controller.dart';
import '../../home/models/launch.dart';
import '../controller/launch_detail_controller.dart';
import 'widgets/detail_shimmer.dart';
import 'widgets/info_tile.dart';

/// Pantalla de detalle de lanzamiento con Hero animation
class LaunchDetailScreen extends ConsumerWidget {
  const LaunchDetailScreen({
    super.key,
    required this.launchId,
  });

  final String launchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Intentar obtener del estado seleccionado primero (más rápido)
    final selectedLaunch = ref.watch(selectedLaunchProvider);
    final launchAsync = ref.watch(launchDetailControllerProvider(launchId));

    // Usar el seleccionado si existe y coincide
    if (selectedLaunch != null && selectedLaunch.id == launchId) {
      return _LaunchDetailContent(launch: selectedLaunch);
    }

    return launchAsync.when(
      data: (launch) => _LaunchDetailContent(launch: launch),
      loading: () => const DetailShimmer(),
      error: (error, _) => _ErrorView(
        error: error.toString(),
        onRetry: () {
          ref.read(launchDetailControllerProvider(launchId).notifier).refresh();
        },
      ),
    );
  }
}

class _LaunchDetailContent extends StatelessWidget {
  const _LaunchDetailContent({required this.launch});

  final LaunchModel launch;

  Color _getStatusColor() {
    if (launch.success == null) {
      return ColorTokens.statusUpcoming;
    }
    return launch.success! ? ColorTokens.statusSuccess : ColorTokens.statusFailed;
  }

  String _getStatusText() {
    if (launch.success == null) return 'status.upcoming'.tr();
    return launch.success! ? 'status.success'.tr() : 'status.failed'.tr();
  }

  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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

  String _getYouTubeThumbnail(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final patchLarge = launch.patchLarge ?? launch.patchSmall;
    final hasVideo = launch.hasWebcast;
    final videoId = hasVideo ? _extractYouTubeId(launch.links.webcast!) : null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con video/imagen
          SliverAppBar(
            expandedHeight: size.height * 0.45,
            pinned: true,
            stretch: true,
            backgroundColor: theme.colorScheme.surface,
            leading: IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).pop();
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Fondo: Video thumbnail o imagen del parche
                  Hero(
                    tag: 'launch-image-${launch.id}',
                    child: Container(
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
                      child: videoId != null
                          ? CachedNetworkImage(
                              imageUrl: _getYouTubeThumbnail(videoId),
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => patchLarge != null
                                  ? CachedNetworkImage(
                                      imageUrl: patchLarge,
                                      fit: BoxFit.contain,
                                    )
                                  : _buildPlaceholder(),
                            )
                          : patchLarge != null
                              ? CachedNetworkImage(
                                  imageUrl: patchLarge,
                                  fit: BoxFit.contain,
                                  errorWidget: (_, __, ___) => _buildPlaceholder(),
                                )
                              : _buildPlaceholder(),
                    ),
                  ),

                  // Botón de play grande para video
                  if (hasVideo)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          _launchUrl(launch.links.webcast);
                        },
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.3),
                          child: Center(
                            child: Hero(
                              tag: 'launch-play-${launch.id}',
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withValues(alpha: 0.5),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Badge de VIDEO
                  if (hasVideo)
                    Positioned(
                      bottom: 70,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'detail.watch_video'.tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Gradiente inferior
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            theme.colorScheme.surface,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Badge de estado con Hero
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    right: 16,
                    child: Hero(
                      tag: 'launch-status-${launch.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor().withValues(alpha: 0.9),
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
                    ),
                  ),

                  // Número de vuelo con Hero
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 56,
                    right: 16,
                    child: Hero(
                      tag: 'launch-flight-${launch.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '#${launch.flightNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre con Hero
                  Hero(
                    tag: 'launch-name-${launch.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        launch.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Cohete con Hero
                  Hero(
                    tag: 'launch-rocket-${launch.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        launch.rocketName ?? 'detail.unknown_rocket'.tr(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Fecha con Hero
                  Hero(
                    tag: 'launch-date-${launch.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            launch.formattedDate,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sección de información
                  Text(
                    'detail.information'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                  const SizedBox(height: 16),

                  // Grid de información
                  _buildInfoGrid(theme),

                  // Descripción si existe
                  if (launch.details != null && launch.details!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'detail.description'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        launch.details!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                        ),
                      ),
                    ).animate().fadeIn(delay: 650.ms, duration: 400.ms),
                  ],

                  // Sección de enlaces
                  const SizedBox(height: 24),
                  Text(
                    'detail.links'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(delay: 700.ms, duration: 400.ms),

                  const SizedBox(height: 12),
                  _buildLinksSection(theme),

                  // Imágenes de Flickr
                  if (launch.flickrImages.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'detail.photos'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
                    const SizedBox(height: 12),
                    _buildFlickrGallery(theme),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.rocket_launch_outlined,
        size: 100,
        color: Colors.white.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildInfoGrid(ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InfoTile(
                icon: Icons.rocket_launch,
                label: 'detail.rocket'.tr(),
                value: launch.rocketName ?? 'detail.unknown'.tr(),
                delay: 450,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoTile(
                icon: Icons.location_on,
                label: 'detail.launchpad'.tr(),
                value: launch.launchpadName ?? 'detail.unknown'.tr(),
                delay: 500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: InfoTile(
                icon: Icons.calendar_today,
                label: 'detail.date'.tr(),
                value: launch.formattedDate,
                delay: 550,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InfoTile(
                icon: Icons.tag,
                label: 'detail.flight'.tr(),
                value: '#${launch.flightNumber}',
                delay: 600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinksSection(ThemeData theme) {
    // No incluir YouTube aquí ya que está en el header
    final links = <_LinkItem>[
      if (launch.links.wikipedia != null)
        _LinkItem(
          icon: Icons.menu_book,
          label: 'detail.wikipedia'.tr(),
          url: launch.links.wikipedia!,
          color: Colors.blue,
        ),
      if (launch.links.article != null)
        _LinkItem(
          icon: Icons.article,
          label: 'detail.article'.tr(),
          url: launch.links.article!,
          color: Colors.green,
        ),
      if (launch.links.webcast != null)
        _LinkItem(
          icon: Icons.play_circle_fill,
          label: 'detail.watch_youtube'.tr(),
          url: launch.links.webcast!,
          color: Colors.red,
        ),
    ];

    if (links.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              Icons.link_off,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text(
              'detail.no_links'.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 750.ms, duration: 400.ms);
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: links.map((link) {
        return InkWell(
          onTap: () => _launchUrl(link.url),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: link.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: link.color.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(link.icon, color: link.color, size: 20),
                const SizedBox(width: 8),
                Text(
                  link.label,
                  style: TextStyle(
                    color: link.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(delay: 750.ms, duration: 400.ms);
  }

  Widget _buildFlickrGallery(ThemeData theme) {
    return SizedBox(
      height: 200,
      child: _ParallaxGallery(
        images: launch.flickrImages,
        theme: theme,
      ),
    ).animate().fadeIn(delay: 850.ms, duration: 400.ms);
  }
}

class _LinkItem {
  const _LinkItem({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String url;
  final Color color;
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: ColorTokens.error,
              ),
              const SizedBox(height: 16),
              Text(
                'detail.error_title'.tr(),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text('detail.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Galería horizontal con efecto parallax
class _ParallaxGallery extends StatefulWidget {
  const _ParallaxGallery({
    required this.images,
    required this.theme,
  });

  final List<String> images;
  final ThemeData theme;

  @override
  State<_ParallaxGallery> createState() => _ParallaxGalleryState();
}

class _ParallaxGalleryState extends State<_ParallaxGallery> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        // Calcular offset del parallax basado en la posición del scroll
        double parallaxOffset = 0;
        if (_scrollController.hasClients) {
          final itemPosition = index * 312.0; // width + margin
          final scrollOffset = _scrollController.offset;
          final viewportWidth = _scrollController.position.viewportDimension;

          // Calcular qué tan centrado está el item
          final itemCenter = itemPosition + 150; // mitad del item
          final viewportCenter = scrollOffset + viewportWidth / 2;
          final distanceFromCenter = itemCenter - viewportCenter;

          // El parallax se mueve en dirección opuesta
          parallaxOffset = distanceFromCenter * 0.3;
        }

        return Container(
          margin: EdgeInsets.only(
            right: index < widget.images.length - 1 ? 12 : 0,
          ),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Imagen con parallax
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(parallaxOffset.clamp(-50.0, 50.0), 0),
                  child: Transform.scale(
                    scale: 1.2, // Zoom para cubrir durante el parallax
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: widget.theme.colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: widget.theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
              ),
              // Overlay gradiente sutil
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                      ],
                      stops: const [0.7, 1.0],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
