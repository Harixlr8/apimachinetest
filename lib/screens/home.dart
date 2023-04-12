import 'dart:convert';

import 'package:apimachinetest/models/dataModel.dart';
import 'package:apimachinetest/screens/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Data> datas = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Sample'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              'The American Coummunity Survey(ACS) is conducted by the US Census and sent to a portion of the population every year',textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
          ),
          const Center(
            child: Text(
              '(Tap to View Year wise results)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                final data = datas[index];

                final nationId = data.idNation;
                final nation = data.nation;
                final idYear = data.idYear;
                final year = data.year;
                final population = data.population;
                final slugNation = data.slugNation;

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          slugNation: slugNation,
                          year: idYear,
                          nation: nation,
                          population: population,
                          idNation: nationId,
                        ),
                      ),
                    );
                  },
                  title: Text(year),
                  // subtitle: Text(population),
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade600,
                      child: Text('${index + 1}')),
                  trailing: Text(nation),
                );
              },
              itemCount: datas.length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    const url =
        'https://datausa.io/api/data?drilldowns=Nation&measures=Population';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;

    final json = jsonDecode(body);

    final results = json['data'] as List<dynamic>;

    final transformed = results.map((e) {
      return Data(
        idNation: e['ID Nation'],
        nation: e['Nation'],
        year: e['Year'],
        idYear: e['ID Year'].toString(),
        population: e['Population'].toString(),
        slugNation: e['Slug Nation'],
      );
    }).toList();

    setState(() {
      datas = transformed;
    });
  }
}
