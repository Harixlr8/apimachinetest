import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String idNation;
  final String nation;
  final String year;
  final String population;
  final String slugNation;
  const DetailsPage(
      {super.key,
      required this.nation,
      required this.idNation,
      required this.population,
      required this.year,
      required this.slugNation});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demographics of year ${widget.year}'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.shade300),
          child: Text(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            'The year "${widget.year}" had a population of "${widget.population}" in the slug Nation of "${widget.slugNation}" of the Nation "${widget.nation}"',
          ),
        ),
      ),
    );
  }
}
