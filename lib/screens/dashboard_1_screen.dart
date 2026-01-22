import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/metric_card.dart';
import '../widgets/weather_widget.dart';
import '../widgets/data_table_widget.dart';

class Dashboard1Screen extends StatelessWidget {
  const Dashboard1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('1st Page'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
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
              children: const [
                MetricCard(
                  icon: Icons.bolt,
                  iconColor: Color(0xFF00CC66),
                  value: '10000 kW',
                  label: 'Live AC Power',
                ),
                MetricCard(
                  icon: Icons.factory_outlined,
                  iconColor: Color(0xFF00D4FF),
                  value: '82.58 %',
                  label: 'Plant Generation',
                ),
                MetricCard(
                  icon: Icons.analytics_outlined,
                  iconColor: Color(0xFF9966FF),
                  value: '85.61 %',
                  label: 'Live PR',
                ),
                MetricCard(
                  icon: Icons.account_tree_outlined,
                  iconColor: Color(0xFF0099FF),
                  value: '27.58 %',
                  label: 'Cumulative PR',
                ),
                MetricCard(
                  icon: Icons.payments_outlined,
                  iconColor: Color(0xFFFF9933),
                  value: '10000 ৳',
                  label: 'Return PV(Till Today)',
                ),
                MetricCard(
                  icon: Icons.energy_savings_leaf,
                  iconColor: Color(0xFF9966FF),
                  value: '10000 kWh',
                  label: 'Total Energy',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Weather Widget
            const WeatherWidget(
              temperature: '17°C',
              windSpeed: '26 MPH',
              windDirection: 'NW',
              irradiation: '15.20 w/m²',
              weatherIconPath: 'assets/images/cloud.png',
            ),
            const SizedBox(height: 20),

            // Data Comparison Table
            DataTableWidget(
              columns: const ['Yesterday\'s Data', 'Today\'s Data'],
              rows: const [
                CustomDataRow(
                  label: 'AC Max Power',
                  value1: '1636.50 kW',
                  value2: '2121.88 kW',
                ),
                CustomDataRow(
                  label: 'Net Energy',
                  value1: '6439.16 kWh',
                  value2: '4875.77 kWh',
                ),
                CustomDataRow(
                  label: 'Specific Yield',
                  value1: '1.25 kWh/kWp',
                  value2: '0.94 kWh/kWp',
                ),
                CustomDataRow(
                  label: 'Net Energy',
                  value1: '6439.16 kWh',
                  value2: '4875.77 kWh',
                ),
                CustomDataRow(
                  label: 'Specific Yield',
                  value1: '1.25 kWh/kWp',
                  value2: '0.94 kWh/kWp',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // PV Module and Capacity Info - Single Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF00A0E3), width: 2),
              ),
              child: Column(
                children: [
                  // PV Module Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00D4FF).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.solar_power,
                          color: Color(0xFF00D4FF),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Total Num of PV Module  :  6372 pcs. (585 Wp each)',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFE0E8F5)),
                  const SizedBox(height: 12),
                  
                  // Row 1: AC and DC Capacity
                  Row(
                    children: [
                      Expanded(
                        child: _buildCompactInfoCard(
                          icon: Icons.settings_input_component,
                          iconColor: const Color(0xFF0099FF),
                          title: 'Total AC Capacity',
                          value: '3000 KW',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildCompactInfoCard(
                          icon: Icons.electrical_services,
                          iconColor: const Color(0xFF00D4FF),
                          title: 'Total DC Capacity',
                          value: '3.727 MWp',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  // Row 2: Date and Inverter
                  Row(
                    children: [
                      Expanded(
                        child: _buildCompactInfoCard(
                          icon: Icons.calendar_today,
                          iconColor: const Color(0xFF0099FF),
                          title: 'Date of Commissioning',
                          value: '17/07/2024',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildCompactInfoCard(
                          icon: Icons.developer_board,
                          iconColor: const Color(0xFF00D4FF),
                          title: 'Number of Inverter',
                          value: '30',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  // Row 3: AC and DC Capacity (repeated)
                  Row(
                    children: [
                      Expanded(
                        child: _buildCompactInfoCard(
                          icon: Icons.settings_input_component,
                          iconColor: const Color(0xFF0099FF),
                          title: 'Total AC Capacity',
                          value: '3000 KW',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildCompactInfoCard(
                          icon: Icons.electrical_services,
                          iconColor: const Color(0xFF00D4FF),
                          title: 'Total DC Capacity',
                          value: '3.727 MWp',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Inverter Details Cards
            ..._buildInverterCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    Color? borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? const Color(0xFFE0E8F5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFF7A8A9E),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFF7A8A9E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInverterCards() {
    return List.generate(2, (index) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LT_01',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.wind_power, color: Color(0xFF00D4FF)),
                    const SizedBox(width: 6),
                    Text(
                      '495.505 kWp / 440 kW',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00D4FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildInverterMetric(
                  icon: Icons.bolt,
                  iconColor: const Color(0xFF00D4FF),
                  label: 'Lifetime Energy',
                  value: '352.96 MWh',
                ),
                _buildInverterMetric(
                  icon: Icons.wb_sunny,
                  iconColor: const Color(0xFFFFCC00),
                  label: 'Today Energy',
                  value: '273.69 kWh',
                ),
                _buildInverterMetric(
                  icon: Icons.flash_on,
                  iconColor: const Color(0xFFFF9933),
                  label: 'Prev. Meter Energy',
                  value: '0.00 MWh',
                ),
                _buildInverterMetric(
                  icon: Icons.power,
                  iconColor: const Color(0xFF9966FF),
                  label: 'Live Power',
                  value: '352.96 MWh',
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInverterMetric({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: const Color(0xFF666666),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
