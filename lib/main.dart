import 'package:dnd_dice/constants/dice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: DnDHomePage(),
    );
  }
}

class DnDHomePage extends StatefulWidget {
  const DnDHomePage({super.key});

  @override
  State<DnDHomePage> createState() => _DnDHomePageState();
}

var selectedIndex = 0;
var rolledValue = 1;

class _DnDHomePageState extends State<DnDHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'DnD Dice Roller',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              rolledValue =
                  Random().nextInt(diceList[selectedIndex].maxRoll) + 1;
            });
          },
          label: Text(
            'Roll',
            style: GoogleFonts.poppins(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            Container(
              height: 350,
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2.5,
                ),
                itemCount: diceList.length,
                itemBuilder: (context, index) {
                  return _buildDieCard(context, index);
                },
              ),
            ),
            Expanded(
              child: Text(
                'You rolled: $rolledValue',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildDieCard(BuildContext context, int index) {
    var dice = diceList[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          rolledValue = 1;
          selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: dice.color.withOpacity(0.25),
          border: index == selectedIndex
              ? Border.all(color: dice.color, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            dice.name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: dice.color,
            ),
          ),
        ),
      ),
    );
  }
}
