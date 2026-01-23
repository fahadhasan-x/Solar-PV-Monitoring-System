import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/metric_card.dart';
import '../widgets/weather_widget.dart';
import '../providers/solar_data_provider.dart';
import '../providers/auth_provider.dart';

class Dashboard1Screen extends StatefulWidget {
  const Dashboard1Screen({super.key});

  @override
  State<Dashboard1Screen> createState() => _Dashboard1ScreenState();
}

class _Dashboard1ScreenState extends State<Dashboard1Screen> {
  @override
  void initState() {
    super.initState();
    // Fetch dashboard data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final solarProvider = Provider.of<SolarDataProvider>(context, listen: false);
      solarProvider.fetchDashboardData();
      // Start auto-refresh every 30 seconds
      solarProvider.startAutoRefresh(intervalSeconds: 30);
    });
  }

  @override
  void dispose() {
    // Stop auto-refresh when leaving screen
    Provider.of<SolarDataProvider>(context, listen: false).stopAutoRefresh();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    final solarProvider = Provider.of<SolarDataProvider>(context, listen: false);
    await solarProvider.fetchDashboardData();
  }

  void _handleLogout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _handleLogout,
        ),
        title: const Text('Solar Dashboard'),
        centerTitle: true,
        actions: [
          Consumer<SolarDataProvider>(
            builder: (context, provider, child) {
              final hasAlerts = provider.dashboardData?.current.system.alerts.isNotEmpty ?? false;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Show alerts
                    },
                  ),
                  if (hasAlerts)
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<SolarDataProvider>(
        builder: (context, solarProvider, child) {
          if (solarProvider.isLoading && solarProvider.dashboardData == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (solarProvider.error != null && solarProvider.dashboardData == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading data',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      solarProvider.error ?? 'Unknown error',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: AppTheme.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleRefresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final data = solarProvider.dashboardData?.current;
          if (data == null) {
            return const Center(child: Text('No data available'));
          }

          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Navigate to 2nd Page button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard2');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D4FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '2nd Page Navigate',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Metric Cards Grid - 3 columns, 2 rows
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.3,
                    children: [
                      MetricCard(
                        icon: Icons.bolt,
                        iconColor: const Color(0xFF00CC66),
                        value: '${data.solarPower.current.toStringAsFixed(2)} kW',
                        label: 'Live AC Power',
                      ),
                      MetricCard(
                        icon: Icons.factory_outlined,
                        iconColor: const Color(0xFF00D4FF),
                        value: '${data.inverter.efficiency.toStringAsFixed(2)} %',
                        label: 'Plant Efficiency',
                      ),
                      MetricCard(
                        icon: Icons.analytics_outlined,
                        iconColor: const Color(0xFF9966FF),
                        value: '${data.battery.level.toStringAsFixed(1)} %',
                        label: 'Battery Level',
                      ),
                      MetricCard(
                        icon: Icons.wb_sunny_outlined,
                        iconColor: const Color(0xFFFFCC00),
                        value: '${data.energyProduction.today.toStringAsFixed(1)} kWh',
                        label: 'Today Energy',
                      ),
                      MetricCard(
                        icon: Icons.electrical_services,
                        iconColor: const Color(0xFFFF6633),
                        value: '${data.load.power.toStringAsFixed(2)} kW',
                        label: 'Current Load',
                      ),
                      MetricCard(
                        icon: Icons.grid_on,
                        iconColor: data.grid.status == 'online' 
                            ? const Color(0xFF00CC66) 
                            : Colors.red,
                        value: data.grid.status.toUpperCase(),
                        label: 'Grid Status',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Weather Widget
                  WeatherWidget(
                    temperature: '${data.weather.temperature.toStringAsFixed(1)}°C',
                    windSpeed: '${(data.weather.irradiance / 50).toStringAsFixed(1)} MPH',
                    windDirection: 'NE',
                    irradiation: '${data.weather.irradiance.toStringAsFixed(0)} W/m²',
                    weatherIconPath: 'assets/images/icons/cloudy.png',
                  ),
                  const SizedBox(height: 20),

                  // Energy Statistics
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Energy Production',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildStatRow('Today', '${data.energyProduction.today.toStringAsFixed(2)} kWh'),
                        _buildStatRow('This Month', '${data.energyProduction.thisMonth.toStringAsFixed(2)} kWh'),
                        _buildStatRow('Total', '${data.energyProduction.total.toStringAsFixed(2)} kWh'),
                        const Divider(height: 24),
                        Text(
                          'System Status',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildStatRow('Inverter', data.inverter.status.toUpperCase()),
                        _buildStatRow('Temperature', '${data.inverter.temperature.toStringAsFixed(1)}°C'),
                        _buildStatRow('System', data.system.status.toUpperCase()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Last updated
                  Center(
                    child: Text(
                      'Last updated: ${_formatTime(data.timestamp)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    
    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
}
