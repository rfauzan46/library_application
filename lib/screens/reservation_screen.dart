import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_application/screens/selected_book_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_application/constants/color_constant.dart';
// import 'package:flutter/material.dart';
import 'package:library_application/models/popularbook_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter buku yang tersedia
    final availableBooks = populars.where((book) => book.status == 'Available').toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
                  'Book Reservation',
                  style: GoogleFonts.openSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kBlackColor,
                  ),)
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            height: 39,
            margin: const EdgeInsets.only(left: 25, right: 25, top: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kLightGreyColor,
            ),
            child: Stack(
              children: <Widget>[
                TextField(
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: kBlackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: 19, right: 50, bottom: 8),
                    border: InputBorder.none,
                    hintText: 'Search book..',
                    hintStyle: GoogleFonts.openSans(
                      fontSize: 12,
                      color: kGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SvgPicture.asset('assets/svg/background_search.svg'),
                ),
                Positioned(
                  top: 8,
                  right: 9,
                  child: SvgPicture.asset('assets/icons/icon_search_white.svg'),
                ),
              ],
            ),
          ),
          // Daftar Buku
          Expanded(
            child: availableBooks.isNotEmpty
                ? ListView.builder(
                    itemCount: availableBooks.length,
                    itemBuilder: (context, index) {
                      final book = availableBooks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              // Navigasi ke halaman detail buku
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectedBookScreen(popularBookModel: book), // Pastikan class ini ada
                                ),
                              );
                            },
                            child: Image.asset(
                              book.image,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 75,
                            ),
                          ),
                          title: Text(book.title),
                          subtitle: Text('Author: ${book.author}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Fungsi reservasi placeholder
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Reservasi Berhasil'),
                                  content: Text('Anda telah mereservasi "${book.title}".'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                            ),
                            child: const Text('Reservasi'),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'Tidak ada buku yang tersedia untuk reservasi.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
