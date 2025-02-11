import 'package:flutter/material.dart';
import 'package:srhcraftshop/categories-pages/artandsupplies_page.dart';
import 'package:srhcraftshop/categories-pages/cuttingtools_page.dart';
import 'package:srhcraftshop/categories-pages/stationery_page.dart';
import 'package:srhcraftshop/categories-pages/paperandcard_page.dart';
import 'package:srhcraftshop/categories-pages/adhesives_pages.dart';
import 'package:srhcraftshop/categories-pages/photographyandprinitng_page.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});

  final List<String> categories = [ //list of strings, each string is a categorie
    'Art Supplies',
    'Cutting Tools',
    'Stationery',
    'Paper & Card',
    'Adhesives',
    'Photography & Printing',
  ];

  @override
  Widget build(BuildContext context) {
    return Column( //layout of the widget
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CATEGORIES",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Color(0xFFE41B13),
              ),
            ),
            const SizedBox(height: 4), // Space between the text and the line
            Container(
              height: 2, // Thickness of the line
              width: 350, // Adjust width as needed
              color: Color(0xFFE41B13), // Line color matching the text
            ),
          ],
        ),

        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(categories.length, (index) {
            //each button for each category
            return GestureDetector(//handles on tap event
              onTap: () {
                // Navigate to the corresponding page based on category
                if (categories[index] == 'Art Supplies') {//it navigates to the corresponding page using Navigator.push
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ArtAndSuppliesPage()), //materialPageRoute is used to navigate to a new page
                  );
                } else if (categories[index] == 'Cutting Tools') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CuttingToolsPage()),
                  );
                } else if (categories[index] == 'Stationery') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StationeryPage()),
                  );
                } else if (categories[index] == 'Paper & Card') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaperAndCardPage()),
                  );
                } else if (categories[index] == 'Adhesives') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdhesivesPage()),
                  );
                } else if (categories[index] == 'Photography & Printing') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PhotographyAndPrintingPage()),
                  );
                }
              },
              child: Container(
                width: (MediaQuery.of(context).size.width - 48) / 3,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF999999),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}


