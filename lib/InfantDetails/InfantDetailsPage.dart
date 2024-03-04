import 'package:flutter/material.dart';

class InfantDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const InfantDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Infant Details', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF6F3EB), // Set app bar color
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bginfantdetails.png', // Replace with your actual image path
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Make the container solid
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'I. Infant Information:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Adjust the padding to control the spacing
                          Container(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                      _buildInfoRow('Name', data['infant']['name']),
                      _buildInfoRow(
                          'Patient Number', data['infant']['tracking_number']),
                      _buildInfoRow('Weight(kg)', data['infant']['weight']),
                      _buildInfoRow('Length(cm)', data['infant']['length']),
                      _buildInfoRow(
                          'Father\'s Name', data['infant']['father_name']),
                      _buildInfoRow(
                          'Mother\'s Name', data['infant']['mother_name']),
                      _buildInfoRow(
                          'Contact Number', data['infant']['contact_number']),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // Make the container solid
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'II. Vaccines Taken:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Adjust the padding to control the spacing
                      Container(
                        height: 0.5,
                        child: Divider(),
                      ),
                      DataTable(
                        columnSpacing: 8.0, // Adjust the column spacing
                        dataRowHeight: 40.0, // Adjust the height as needed
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Vaccine',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Color(0xFF016A52),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Administered By',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Color(0xFF016A52),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date (YYYY-MM-DD)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Color(0xFF016A52),
                              ),
                            ),
                          ),
                        ],
                        rows: data['vaccine_taken']
                            .map<DataRow>(
                              (vaccine) => DataRow(
                                cells: [
                                  DataCell(
                                    Text('${vaccine['vaccine_name'] ?? ""}',
                                        style: const TextStyle(fontSize: 12.0)),
                                  ),
                                  DataCell(
                                    Text('${vaccine['administered_by'] ?? ""}',
                                        style: const TextStyle(fontSize: 12.0)),
                                  ),
                                  DataCell(
                                    Text(
                                        '${vaccine['immunization_date'] ?? ""}',
                                        style: const TextStyle(fontSize: 12.0)),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.0,
            child: Text(
              '$title:',
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "",
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
