import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_application/constants/color_constant.dart';
import 'package:library_application/models/popularbook_model.dart';
import 'package:library_application/widgets/custom_tab_indicator.dart';

class SelectedBookScreen extends StatelessWidget {
  SelectedBookScreen({Key? key, required this.popularBookModel})
      : super(key: key);
  final PopularBookModel popularBookModel;

  String? _calculateRemainingDays(String? dueDate) {
    if (dueDate == null) return null;

    final now = DateTime.now();
    final due = DateTime.parse(dueDate);
    final difference = due.difference(now).inDays;

    if (difference > 0) {
      return 'Due in $difference days';
    } else if (difference == 0) {
      return 'Due today';
    } else {
      return 'Overdue by ${-difference} days';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            foregroundColor: MaterialStateProperty.all<Color>(kMainColor),
          ),
          onPressed: () {},
          child: Text(
            'Add to Library',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: kWhiteColor),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: kMainColor,
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  color: Color(popularBookModel.color),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 25,
                        top: 35,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/homeScreen');
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kWhiteColor,
                            ),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 62),
                          width: 172,
                          height: 225,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(popularBookModel.image),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 25),
                    child: Text(
                      popularBookModel.title,
                      style: GoogleFonts.openSans(
                          fontSize: 27,
                          color: kBlackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 25),
                    child: Text(
                      popularBookModel.author,
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: kGreyColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          popularBookModel.status == 'Reserved'
                              ? _calculateRemainingDays(popularBookModel.dueDate) ?? 'Unknown'
                              : popularBookModel.status,
                          style: GoogleFonts.openSans(
                              fontSize: 32,
                              color: kMainColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 28,
                    margin: const EdgeInsets.only(top: 23, bottom: 36),
                    padding: const EdgeInsets.only(left: 25),
                    child: DefaultTabController(
                      length: 3,
                      child: TabBar(
                        labelPadding: const EdgeInsets.all(0),
                        indicatorPadding: const EdgeInsets.all(0),
                        isScrollable: true,
                        labelColor: kBlackColor,
                        unselectedLabelColor: kGreyColor,
                        labelStyle: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        indicator: RoundedRectangleTabIndicator(
                            weight: 2, width: 30, color: kBlackColor),
                        tabs: [
                          Tab(
                              child: Container(
                                  margin: const EdgeInsets.only(right: 39),
                                  child: const Text('Description'))),
                          Tab(
                              child: Container(
                                  margin: const EdgeInsets.only(right: 39),
                                  child: const Text('Reviews'))),
                          Tab(
                              child: Container(
                                  margin: const EdgeInsets.only(right: 39),
                                  child: const Text('Similar'))),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: Text(
                      popularBookModel.description,
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: kGreyColor,
                          letterSpacing: 1.5,
                          height: 2),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
      // Tambahkan tombol floating jika status adalah 'Available'
      floatingActionButton: popularBookModel.status == 'Available'
    ? SizedBox(
        width: 150, // Perlebar ukuran tombol
        height: 50, // Tambahkan tinggi tombol jika diperlukan
        child: FloatingActionButton(
          onPressed: () {
            // Logika untuk reservasi buku
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Reservasi Berhasil'),
                content: Text(
                    'Anda telah mereservasi "${popularBookModel.title}".'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          backgroundColor: kMainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Tambahkan radius sudut
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bookmark),
              const SizedBox(width: 8), // Tambahkan jarak antara ikon dan teks
              Text(
                      'Reservasi',
                      style: GoogleFonts.openSans(), // Opsional: Atur gaya teks
                  ),
            ],
          ),
        ),
      )
    : null, // Tidak menampilkan tombol jika status bukan 'Available'
    );
  }
}
