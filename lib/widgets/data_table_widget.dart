import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTableWidget extends StatelessWidget {
  final List<CustomDataRow> rows;
  final List<String> columns;

  const DataTableWidget({
    super.key,
    required this.rows,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E8F5), width: 1.5),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FBFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                ...columns.map((col) => Expanded(
                      flex: 2,
                      child: Text(
                        col,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C3E50),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE0E8F5)),
          // Data rows with alternating colors
          Column(
            children: List.generate(
              rows.length,
              (index) => Container(
                color: index.isEven ? Colors.white : const Color(0xFFF8FBFF),
                child: rows[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDataRow extends StatelessWidget {
  final String label;
  final String value1;
  final String value2;

  const CustomDataRow({
    super.key,
    required this.label,
    required this.value1,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF5A6C7D),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value1,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value2,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
