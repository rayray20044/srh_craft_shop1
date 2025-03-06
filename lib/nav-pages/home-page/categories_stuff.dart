import 'package:flutter/material.dart';
import 'package:srhcraftshop/categories-pages/artandsupplies_page.dart';
import 'package:srhcraftshop/categories-pages/cuttingtools_page.dart';
import 'package:srhcraftshop/categories-pages/stationery_page.dart';
import 'package:srhcraftshop/categories-pages/paperandcard_page.dart';
import 'package:srhcraftshop/categories-pages/adhesives_pages.dart';
import 'package:srhcraftshop/categories-pages/photographyandprinitng_page.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});


  final Color primaryColor = Color(0xFFBC5D5D);
  final Color accentColor = Color(0xFFEA6C6C);

  // list of categories
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Art Supplies',
      'icon': Icons.brush,
      'page': const ArtAndSuppliesPage(),
    },
    {
      'name': 'Cutting Tools',
      'icon': Icons.content_cut,
      'page': const CuttingToolsPage(),
    },
    {
      'name': 'Stationery',
      'icon': Icons.edit,
      'page': const StationeryPage(),
    },
    {
      'name': 'Paper & Card',
      'icon': Icons.insert_drive_file,
      'page': const PaperAndCardPage(),
    },
    {
      'name': 'Adhesives',
      'icon': Icons.opacity,
      'page': const AdhesivesPage(),
    },
    {
      'name': 'Photography & Printing',
      'icon': Icons.camera_alt,
      'page': const PhotographyAndPrintingPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // title of  categories section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "CATEGORIES",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: accentColor,
            ),
          ),
        ),

        // divider line
        Divider(color: accentColor, thickness: 2, indent: 20, endIndent: 20),

        // scrolling list for  categoris
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CategoryCard(
                  title: category['name'],
                  icon: category['icon'],
                  primaryColor: primaryColor,
                  accentColor: accentColor,
                  onTap: () {

                    // navigates to the selected category page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => category['page'],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// widget for individual category
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, //calls the function when tapped
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: 110,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withOpacity(0.8)], // gradient effect
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(height: 8), // space  between icon and text
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // ... if text is too long
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
