import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';

class Dashboard2Screen extends StatefulWidget {
  const Dashboard2Screen({super.key});

  @override
  State<Dashboard2Screen> createState() => _Dashboard2ScreenState();
}

class _Dashboard2ScreenState extends State<Dashboard2Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSourceSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('2nd Page'),
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
            // Navigate to 1st Page button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D4FF),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '1st Page Navigate',
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

            // Tab Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF666666),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Summery'),
                  Tab(text: 'SLD'),
                  Tab(text: 'Data'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tab Content
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSummaryTab(),
                  _buildSLDTab(),
                  _buildDataTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Electricity Section
          Container(
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
              children: [
                Text(
                  'Electricity',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF999999),
                  ),
                ),
                const SizedBox(height: 20),

                // Pie Chart
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 70,
                          startDegreeOffset: -90,
                          sections: [
                            PieChartSectionData(
                              value: 60,
                              color: AppTheme.primaryBlue,
                              radius: 35,
                              title: '',
                            ),
                            PieChartSectionData(
                              value: 40,
                              color: const Color(0xFFB3D9FF),
                              radius: 35,
                              title: '',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Total Power',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '5.53 kw',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Source/Load Toggle
                Row(
                  children: [
                    Expanded(
                      child: _buildToggleButton(
                        'Source',
                        _isSourceSelected,
                        () {
                          setState(() {
                            _isSourceSelected = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildToggleButton(
                        'Load',
                        !_isSourceSelected,
                        () {
                          setState(() {
                            _isSourceSelected = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Data View Cards
          _buildDataViewCard(
            'Data View',
            const Color(0xFF66B3FF),
            true,
            'assets/images/solarcell.png',
            [
              {'label': 'Data 1', 'value': ': 55505.63'},
              {'label': 'Data 2', 'value': ': 58805.63'},
            ],
          ),
          const SizedBox(height: 12),
          _buildDataViewCard(
            'Data Type 2',
            const Color(0xFFFF9933),
            true,
            'assets/images/power.png',
            [
              {'label': 'Data 1', 'value': ': 55505.63'},
              {'label': 'Data 2', 'value': ': 58805.63'},
            ],
          ),
          const SizedBox(height: 12),
          _buildDataViewCard(
            'Data Type 3',
            const Color(0xFF66B3FF),
            false,
            'assets/images/Asset.png',
            [
              {'label': 'Data 1', 'value': ': 55505.63'},
              {'label': 'Data 2', 'value': ': 58805.63'},
            ],
          ),
          const SizedBox(height: 20),

          // Bottom Action Buttons Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: [
              _buildActionButton(
                'Analysis Pro',
                Icons.analytics,
                const Color(0xFF0099FF),
              ),
              _buildActionButton(
                'G. Generator',
                Icons.power,
                const Color(0xFFFF9933),
              ),
              _buildActionButton(
                'Plant Summery',
                Icons.flash_on,
                const Color(0xFFFFCC00),
              ),
              _buildActionButton(
                'Natural Gas',
                Icons.local_fire_department,
                const Color(0xFFFF6633),
              ),
              _buildActionButton(
                'D. Generator',
                Icons.power_settings_new,
                const Color(0xFFFF9933),
              ),
              _buildActionButton(
                'Water Process',
                Icons.water_drop,
                const Color(0xFF00CCFF),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSLDTab() {
    return Center(
      child: Text(
        'SLD Content Coming Soon',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: const Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildDataTab() {
    return Center(
      child: Text(
        'Data Content Coming Soon',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: const Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF999999),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataViewCard(
    String title,
    Color color,
    bool isActive,
    String iconPath,
    List<Map<String, String>> data,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF00AAFF) : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isActive ? 'Active' : 'Inactive',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...data.map((item) => Text(
                      '${item['label']}     ${item['value']}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF8899AA),
                      ),
                    )),
              ],
            ),
          ),
          // Arrow
          const Icon(Icons.chevron_right, color: Color(0xFF999999), size: 28),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
