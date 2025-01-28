import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_application/constants/color_constant.dart';
import 'package:library_application/models/newbook_model.dart';
import 'package:library_application/models/popularbook_model.dart';
import 'package:library_application/screens/reservation_screen.dart';
import 'package:library_application/screens/reminder_screen.dart';
import 'package:library_application/screens/profile_screen.dart';
import 'package:library_application/screens/selected_book_screen.dart';
import 'package:library_application/widgets/custom_tab_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreenBody(),
    const ReservationScreen(),
    const ReminderScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGreyColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hi, Rizki',
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kGreyColor,
                  ),
                ),
                Text(
                  'Discover Latest Book',
                  style: GoogleFonts.openSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: kBlackColor,
                  ),
                ),
              ],
            ),
          ),
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
          Container(
            height: 25,
            margin: const EdgeInsets.only(top: 30),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                indicator: RoundedRectangleTabIndicator(
                  weight: 2,
                  width: 10,
                  color: kBlackColor,
                ),
                tabs: [
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(right: 23),
                      child: const Text('New'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(right: 23),
                      child: const Text('Trending'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      margin: const EdgeInsets.only(right: 23),
                      child: const Text('Best Seller'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 21),
            height: 210,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 25, right: 6),
              itemCount: newbooks.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 19),
                  height: 210,
                  width: 153,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kMainColor,
                    image: DecorationImage(
                      image: AssetImage(newbooks[index].image),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'Popular',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kBlackColor,
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: populars.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectedBookScreen(popularBookModel: populars[index]),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 19),
                  height: 81,
                  width: MediaQuery.of(context).size.width - 50,
                  color: kBackgroundColor,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 81,
                        width: 62,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: AssetImage(populars[index].image),
                          ),
                          color: kMainColor,
                        ),
                      ),
                      const SizedBox(
                        width: 21,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            populars[index].title,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kBlackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            populars[index].author,
                            style: GoogleFonts.openSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: kGreyColor,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            populars[index].status,
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(populars[index].status.toString()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'Available':
      return kBlackColor; // Green for available books
    case 'Reserved':
      return kGreyColor; // Orange for reserved books
    case 'Unavailable':
      return kMainColor; // Red for unavailable books
    default:
      return kBlackColor; // Default color
  }
}
