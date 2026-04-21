import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        selectedItemColor: const Color(0xFF4FB6A6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF6F4), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Good morning,",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const Text(
              "Richard",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),
            const Text(
              "Tuesday, March 24",
              style: TextStyle(color: Colors.black45),
            ),

            const SizedBox(height: 25),

            _card(
              title: "Today's Classes",
              child: Column(
                children: [
                  _classTile(
                    "Calculus II",
                    "10:00 - 11:45 AM",
                    "Room 202 • Prof. Smith",
                    "Now",
                  ),
                  const Divider(),
                  _classTile(
                    "Operating System",
                    "12:00 - 01:30 PM",
                    "Room D4 • Dr. Adams",
                    "In 2h",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _card(
              title: "Announcements",
              child: ListTile(
                leading: const Icon(Icons.circle, size: 10, color: Colors.red),
                title: const Text("School Operations"),
                subtitle: const Text(
                  "Updated hours at the library this week...",
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              ),
            ),

            const SizedBox(height: 20),

            _card(
              title: "Quick Actions",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _quickAction(Icons.calendar_month, "My Schedule"),
                  _quickAction(Icons.map, "Campus Map"),
                  _quickAction(Icons.chat_bubble, "Messages"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _classTile(String title, String time, String room, String tag) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(time, style: const TextStyle(color: Colors.black54)),
            Text(room, style: const TextStyle(color: Colors.black45)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF4FB6A6).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(tag, style: const TextStyle(color: Color(0xFF4FB6A6))),
        ),
      ],
    );
  }
}

class _quickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _quickAction(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF4FB6A6).withOpacity(0.15),
          child: Icon(icon, color: const Color(0xFF4FB6A6)),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
