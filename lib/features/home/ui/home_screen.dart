import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes.dart';
import '../../../config/themes/color_tokens.dart';
import '../../../core/network/network_info.dart';
import '../../../shared/widgets/connectivity_banner.dart';
import '../controller/launch_controller.dart';
import 'widgets/launch_carousel.dart';
import 'widgets/character_card_shimmer.dart';
import 'widgets/filter_bottom_sheet.dart';

/// Pantalla principal con carrusel de lanzamientos
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    HapticFeedback.mediumImpact();
    await ref.read(launchControllerProvider.notifier).refresh(
          onSuccess: () {
            HapticFeedback.lightImpact();
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: ColorTokens.error,
              ),
            );
          },
        );
  }

  void _showFilters() {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _onSearch(String query) {
    ref.read(launchFiltersProvider.notifier).state =
        ref.read(launchFiltersProvider).copyWith(
              searchQuery: query,
              clearStatus: true,
              clearRocket: true,
            );
    ref.read(launchControllerProvider.notifier).search(query);
  }

  @override
  Widget build(BuildContext context) {
    final launchesAsync = ref.watch(launchControllerProvider);
    final filters = ref.watch(launchFiltersProvider);
    final connectivityAsync = ref.watch(connectivityStreamProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Banner de conectividad
            connectivityAsync.when(
              data: (isConnected) => isConnected
                  ? const SizedBox.shrink()
                  : const ConnectivityBanner(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

            // AppBar personalizada
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'home.title'.tr(),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'home.subtitle'.tr(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botón de perfil
                  IconButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      context.push(Routes.profile);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorTokens.spaceXBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: ColorTokens.spaceXBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),

            // Barra de búsqueda y filtros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'home.search_hint'.tr(),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearch('');
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: _onSearch,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Botón de filtros
                  Badge(
                    isLabelVisible: filters.hasFilters,
                    child: IconButton(
                      onPressed: _showFilters,
                      style: IconButton.styleFrom(
                        backgroundColor:
                            ColorTokens.spaceXBlue.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(
                        Icons.tune,
                        color: filters.hasFilters
                            ? ColorTokens.spaceXBlue
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms)
                .slideY(begin: -0.1, end: 0),

            const SizedBox(height: 24),

            // Contenido principal
            Expanded(
              child: launchesAsync.when(
                data: (launches) {
                  if (launches.isEmpty) {
                    return _buildEmptyState(theme);
                  }

                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: ColorTokens.spaceXBlue,
                    child: LaunchCarousel(launches: launches),
                  );
                },
                loading: () => const CharacterCarouselShimmer(),
                error: (error, _) => _buildErrorState(theme, error.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'home.no_results'.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              _searchController.clear();
              ref.read(launchControllerProvider.notifier).clearFilters();
            },
            child: Text('home.clear_filters'.tr()),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildErrorState(ThemeData theme, String error) {
    return Center(
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
              'home.error_title'.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
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
              onPressed: _onRefresh,
              icon: const Icon(Icons.refresh),
              label: Text('home.retry'.tr()),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
