import 'package:google_fonts/google_fonts.dart';
import 'package:library_application/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_application/models/popularbook_model.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

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
    // Filter hanya buku dengan status "Reserved"
    final reservedBooks = populars.where((book) => book.status == 'Reserved').toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Reminders',
          style: GoogleFonts.openSans(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: kBlackColor,
          ),
        ),
      ),
      body: reservedBooks.isNotEmpty
          ? ListView.builder(
              itemCount: reservedBooks.length,
              itemBuilder: (context, index) {
                final book = reservedBooks[index];
                final dueInfo = _calculateRemainingDays(book.dueDate);

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(book.image),
                    ),
                    title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (book.dueDate != null)
                          Text('Due Date: ${DateFormat.yMMMd().format(DateTime.parse(book.dueDate!))}'),
                        if (dueInfo != null)
                          Text(dueInfo,
                              style: TextStyle(
                                  color: dueInfo.contains('Overdue') ? Colors.red : Colors.green)),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reminder clicked!')),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No reserved books to show!',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }
}
