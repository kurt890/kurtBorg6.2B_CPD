import 'package:flutter/material.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> habits = List.generate(1, (index) => 'Habit ${index + 1}');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  // Performance Issue: Heavy computation in build method
  int _expensiveCalculation() {
    int result = 0;
    for (int i = 0; i < 1000000; i++) {
      result += i;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // Performance Issue: Running expensive calculation on every rebuild
    _expensiveCalculation();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40.0),
            color: Colors.grey[300],
            child: const Text(
              'Daily Habits',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            // Performance Issue: Using ListView instead of ListView.builder
            child: ListView(
              children: habits.map((habit) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    title: Text(habit),
                    trailing: const Icon(Icons.more_vert),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            habits.add('New Habit ${habits.length + 1}');
          });
        },
        backgroundColor: Colors.grey[400],
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 32),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 32),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
