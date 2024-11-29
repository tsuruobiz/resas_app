import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/city.dart';

import 'env.dart';

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final City city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    // APIからデータを取得する処理
    const host = 'opendata.resas-portal.go.jp';
    // 一人当たりの地方税を取得するエンドポイントを指定します
    const endopoint = 'api/v1/municipality/taxes/perYear';
    final headers = {'X-API-KEY': Env.resasApiKey};
    final param = {
      'prefCode': widget.city.prefCode.toString(),
      'cityCode': widget.city.cityCode,
    };
    _future = http
        .get(Uri.https(host, endopoint, param), headers: headers)
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.cityName),
      ),
      body: FutureBuilder<String>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final result =
              jsonDecode(snapshot.data!)['result'] as Map<String, dynamic>;
          final data = result['data'] as List;
          final items = data.cast<Map<String, dynamic>>();
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text('${item['year']}年'),
                trailing: Text(
                  _formatTaxLabel(item['value'] as int),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// 地方税の金額をフォーマットして表示する
  ///
  /// [value] 地方税の金額（単位：千円）
  /// [return] フォーマットされた地方税の文字列（例：1,234,567円）
  String _formatTaxLabel(int value) {
    final formatted = NumberFormat('#,###').format(value * 1000);
    return '$formatted円';
  }
}
