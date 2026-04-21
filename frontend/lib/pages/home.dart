import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _api = ApiService();
  List<dynamic> _classes = [];
  List<dynamic> _announcements = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final classes = await _api.getClasses();
      final announcements = await _api.getAnnouncements();
      setState(() {
        _classes = classes;
        _announcements = announcements;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final greeting = _getGreeting(now.hour);
    final dateStr = DateFormat('EEEE, MMMM d').format(now);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    greeting,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const Text(
                    "Student",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    dateStr,
                    style: const TextStyle(color: Colors.black45),
                  ),
                  const SizedBox(height: 25),
                  _card(
                    title: "Today's Classes",
                    child: _classes.isEmpty
                        ? const Text("No classes today")
                        : Column(
                            children: _classes
                                .map(
                                  (c) => _classTile(
                                    c['name'] ?? '',
                                    c['schedule']?['dtstart'] ?? '',
                                    c['location'] ?? '',
                                    c['prof']?['name'] ?? '',
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                  const SizedBox(height: 20),
                  _card(
                    title: "Announcements",
                    child: _announcements.isEmpty
                        ? const Text("No announcements")
                        : Column(
                            children: _announcements
                                .map(
                                  (a) => ListTile(
                                    leading: const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.red,
                                    ),
                                    title: Text(a['title'] ?? ''),
                                    subtitle: Text(a['content'] ?? ''),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                    ),
                                    onTap: () => _showAnnouncement(a),
                                  ),
                                )
                                .toList(),
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

  Widget _classTile(String title, String time, String location, String prof) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(location, style: const TextStyle(color: Colors.black54)),
              Text(prof, style: const TextStyle(color: Colors.black45)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4FB6A6).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Now",
              style: TextStyle(color: Color(0xFF4FB6A6)),
            ),
          ),
        ],
      ),
    );
  }

  void _showAnnouncement(Map<String, dynamic> announcement) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(announcement['title'] ?? ''),
        content: Text(announcement['content'] ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  String _getGreeting(int hour) {
    if (hour < 12) return "Good morning,";
    if (hour < 17) return "Good afternoon,";
    return "Good evening,";
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
