import 'package:flutter/material.dart';

class InfantDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const InfantDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infant Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF871818)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('I. Infant Information:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Text('Name: ${data['infant']['name'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                  Text('Patient Number: ${data['infant']['tracking_number'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                  Text('Weight(kg): ${data['infant']['weight'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                  Text('Length(cm): ${data['infant']['length'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                  Text('Father\'s Name: ${data['infant']['father_name'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                  Text('Mother\'s Name: ${data['infant']['mother_name'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                  Text('Contact Number: ${data['infant']['contact_number'] ?? ""}', style: const TextStyle(fontSize: 16.0)),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            const Text('II. Vaccines Taken:', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF871818)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DataTable(
                columnSpacing: 8.0, // Adjust the column spacing
                dataRowHeight: 40.0, // Adjust the height as needed
                columns: const [
                  DataColumn(
                    label: Text('Vaccine', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.0, color: Color(0xFF871818))),
                  ),
                  DataColumn(
                    label: Text('Administered By', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.0, color: Color(0xFF871818))),
                  ),
                  DataColumn(
                    label: Text('Date (YYYY-MM-DD)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.0, color: Color(0xFF871818))),
                  ),
                ],
                rows: data['vaccine_taken'].map<DataRow>(
                  (vaccine) => DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 100, // Adjust the width as needed
                          child: Text('${vaccine['vaccine_name'] ?? ""}', style: const TextStyle(fontSize: 6.0)),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 70, // Adjust the width as needed
                          child: Text('${vaccine['administered_by'] ?? ""}', style: const TextStyle(fontSize: 6.0)),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 50, // Adjust the width as needed
                          child: Text('${vaccine['immunization_date'] ?? ""}', style: const TextStyle(fontSize: 7.0)),
                        ),
                      ),
                    ],
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
