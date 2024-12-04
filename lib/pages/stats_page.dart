import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/debate_page_button.dart';

class StatsPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String name;
  final String debateId;
  final List<String> forOpinions;
  final List<String> againstOpinions;
  const StatsPage({
    super.key,
    required this.title,
    required this.name,
    required this.debateId,
    required this.forOpinions,
    required this.againstOpinions,
    required this.imageUrl,
  });

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    int totalVotes = widget.forOpinions.length + widget.againstOpinions.length;

    double forPercentage =
        totalVotes > 0 ? (widget.forOpinions.length / totalVotes) * 100 : 0.0;

    double againstPercentage = totalVotes > 0
        ? (widget.againstOpinions.length / totalVotes) * 100
        : 0.0;
    if (forPercentage == 100.0) {
      againstPercentage = 0.1; // Small non-zero value to render a tiny slice
    } else if (againstPercentage == 100.0) {
      forPercentage = 0.1; // Small non-zero value to render a tiny slice
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth_page');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 36,
            )),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.imageUrl.isNotEmpty
                      ? NetworkImage(widget.imageUrl) // Load from Firebase
                      : AssetImage("lib/Opinio_Images/placeholder.png")
                          as ImageProvider, // Default placeholder
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    BorderRadius.circular(20), // Added rounded corners
                boxShadow: [
                  // Added shadow for elevation effect
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Statement
            Container(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            // Opinion summary stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DebatePageButton(
                  shouldColor: false,
                  number: 0,
                  name: 'OPINIONS',
                  debateId: widget.debateId,
                  title: widget.title,
                  forOpinions: widget.forOpinions,
                  againstOpinions: [],
                  imageUrl: widget.imageUrl,
                ),
                const SizedBox(width: 5),
                DebatePageButton(
                  shouldColor: false,
                  number: 1,
                  name: 'SUMMARY',
                  debateId: widget.debateId,
                  title: widget.title,
                  forOpinions: widget.forOpinions,
                  againstOpinions: [],
                  imageUrl: widget.imageUrl,
                ),
                const SizedBox(width: 5),
                DebatePageButton(
                  imageUrl: widget.imageUrl,
                  shouldColor: true,
                  number: 2,
                  name: 'STATISTICS',
                  debateId: widget.debateId,
                  title: widget.title,
                  forOpinions: widget.forOpinions,
                  againstOpinions: [],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Pie Chart
            Container(
              height: 200,
              width: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: [
                        // "Against" section
                        PieChartSectionData(
                          value: againstPercentage,
                          color: Color.fromRGBO(212, 77, 92, 1),
                          // title: '${againstPercentage.toStringAsFixed(1)}%',
                          title: againstPercentage == 0.1 ? "" : "Against",
                          titleStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        // "For" section
                        PieChartSectionData(
                          value: forPercentage,
                          color: Color.fromRGBO(68, 161, 160, 1),
                          // title: '${forPercentage.toStringAsFixed(1)}%',
                          title: forPercentage == 0.1 ? "" : "For",
                          titleStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // You can add other widgets on top of the PieChart using Positioned or Center widgets
                  Center(
                    child: Text(
                      'Votes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
