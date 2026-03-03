import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/themes/color_tokens.dart';
import '../../controller/launch_controller.dart';

/// Bottom sheet para filtrar lanzamientos
class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  String? _selectedStatus;
  String? _selectedRocket;

  final List<String> _statuses = ['Success', 'Failed', 'Upcoming'];

  @override
  void initState() {
    super.initState();
    final filters = ref.read(launchFiltersProvider);
    _selectedStatus = filters.status;
    _selectedRocket = filters.rocket;
  }

  void _applyFilters() {
    HapticFeedback.mediumImpact();

    final filters = LaunchFilters(
      status: _selectedStatus,
      rocket: _selectedRocket,
    );

    ref.read(launchFiltersProvider.notifier).state = filters;
    ref.read(launchControllerProvider.notifier).applyFilters(filters);

    Navigator.of(context).pop();
  }

  void _clearFilters() {
    HapticFeedback.lightImpact();

    setState(() {
      _selectedStatus = null;
      _selectedRocket = null;
    });

    ref.read(launchControllerProvider.notifier).clearFilters();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rocketsAsync = ref.watch(uniqueRocketsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Título
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'filters.title'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: _clearFilters,
                      child: Text('filters.clear'.tr()),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // Contenido scrolleable
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Filtro por estado
                    Text(
                      'filters.status'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _statuses.map((status) {
                        final isSelected = _selectedStatus == status;
                        return FilterChip(
                          label: Text(_translateStatus(status)),
                          selected: isSelected,
                          onSelected: (selected) {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _selectedStatus = selected ? status : null;
                            });
                          },
                          selectedColor:
                              ColorTokens.spaceXBlue.withValues(alpha: 0.2),
                          checkmarkColor: ColorTokens.spaceXBlue,
                          avatar: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getStatusColor(status),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Filtro por cohete
                    Text(
                      'filters.rocket'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    rocketsAsync.when(
                      data: (rockets) => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: rockets.map((rocket) {
                          final isSelected = _selectedRocket == rocket;
                          return FilterChip(
                            label: Text(rocket),
                            selected: isSelected,
                            onSelected: (selected) {
                              HapticFeedback.selectionClick();
                              setState(() {
                                _selectedRocket = selected ? rocket : null;
                              });
                            },
                            selectedColor:
                                ColorTokens.spaceXBlue.withValues(alpha: 0.2),
                            checkmarkColor: ColorTokens.spaceXBlue,
                          );
                        }).toList(),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (_, __) => Text(
                        'filters.error_loading'.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: ColorTokens.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Botón de aplicar
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    child: Text(
                      'filters.apply'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return ColorTokens.statusSuccess;
      case 'failed':
        return ColorTokens.statusFailed;
      case 'upcoming':
        return ColorTokens.statusUpcoming;
      default:
        return ColorTokens.statusUpcoming;
    }
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return 'status.success'.tr();
      case 'failed':
        return 'status.failed'.tr();
      case 'upcoming':
        return 'status.upcoming'.tr();
      default:
        return status;
    }
  }
}
