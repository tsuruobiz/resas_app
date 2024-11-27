import 'package:flutter/material.dart';

import 'city_detail_page.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const cities = [
      '札幌市',
      '横浜市',
      '川崎市',
      '相模原市',
      '仙台市',
      'さいたま市',
      '千葉市',
      '静岡市',
      '浜松市',
      '北九州市',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: ListView(
        children: [
          for (final city in cities)
            ListTile(
              title: Text(city),
              subtitle: const Text(
                  '政令指定都市'), // This is fine as it's a constant string
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CityDetailPage(
                      city: city,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
