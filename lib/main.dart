import 'package:flutter/material.dart';

void main() => runApp(const StatesApp());

class Region {
  final String name;
  final String capital;
  final String type;
  final String? note;
  const Region(this.name, this.capital, this.type, [this.note]);
}

const List<Region> regions = [
  // States
  Region('Andhra Pradesh', 'Amaravati', 'State'),
  Region('Arunachal Pradesh', 'Itanagar', 'State'),
  Region('Assam', 'Dispur', 'State'),
  Region('Bihar', 'Patna', 'State'),
  Region('Chhattisgarh', 'Raipur', 'State'),
  Region('Goa', 'Panaji', 'State'),
  Region('Gujarat', 'Gandhinagar', 'State'),
  Region('Haryana', 'Chandigarh', 'State'),
  Region('Himachal Pradesh', 'Shimla', 'State', 'Winter capital: Dharamshala'),
  Region('Jharkhand', 'Ranchi', 'State'),
  Region('Karnataka', 'Bengaluru', 'State'),
  Region('Kerala', 'Thiruvananthapuram', 'State'),
  Region('Madhya Pradesh', 'Bhopal', 'State'),
  Region('Maharashtra', 'Mumbai', 'State'),
  Region('Manipur', 'Imphal', 'State'),
  Region('Meghalaya', 'Shillong', 'State'),
  Region('Mizoram', 'Aizawl', 'State'),
  Region('Nagaland', 'Kohima', 'State'),
  Region('Odisha', 'Bhubaneswar', 'State'),
  Region('Punjab', 'Chandigarh', 'State'),
  Region('Rajasthan', 'Jaipur', 'State'),
  Region('Sikkim', 'Gangtok', 'State'),
  Region('Tamil Nadu', 'Chennai', 'State'),
  Region('Telangana', 'Hyderabad', 'State'),
  Region('Tripura', 'Agartala', 'State'),
  Region('Uttar Pradesh', 'Lucknow', 'State'),
  Region('Uttarakhand', 'Dehradun', 'State', 'Summer capital: Gairsain'),
  Region('West Bengal', 'Kolkata', 'State'),
  // Union Territories
  Region('Andaman and Nicobar Islands', 'Sri Vijaya Puram', 'Union Territory',
      'Formerly Port Blair'),
  Region('Chandigarh', 'Chandigarh', 'Union Territory'),
  Region('Dadra and Nagar Haveli and Daman and Diu', 'Daman',
      'Union Territory'),
  Region('Delhi', 'New Delhi', 'Union Territory'),
  Region('Jammu and Kashmir', 'Srinagar', 'Union Territory',
      'Winter capital: Jammu'),
  Region('Ladakh', 'Leh', 'Union Territory'),
  Region('Lakshadweep', 'Kavaratti', 'Union Territory'),
  Region('Puducherry', 'Puducherry', 'Union Territory'),
];

class StatesApp extends StatelessWidget {
  const StatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'States & Capitals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const WelcomeScreen(),
    );
  }
}

// ---------------- Screen 1: Select State ----------------
class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  Region? selected;

  DropdownMenuItem<Region> _header(String text, Color color) {
    return DropdownMenuItem<Region>(
      enabled: false,
      child: Text(text,
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
    );
  }

  List<DropdownMenuItem<Region>> _items(Color color) {
    final items = <DropdownMenuItem<Region>>[];
    items.add(_header('States', color));
    for (final r in regions.where((r) => r.type == 'State')) {
      items.add(DropdownMenuItem(value: r, child: Text(r.name)));
    }
    items.add(_header('Union Territories', color));
    for (final r in regions.where((r) => r.type != 'State')) {
      items.add(DropdownMenuItem(value: r, child: Text(r.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('States & Capitals'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Select a State / Union Territory',
                style: TextStyle(color: cs.onSurfaceVariant)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: cs.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<Region>(
                value: selected,
                isExpanded: true,
                underline: const SizedBox(),
                hint: const Text('-- Choose --'),
                items: _items(cs.primary),
                onChanged: (r) => setState(() => selected = r),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: selected == null
                  ? null
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CapitalScreen(region: selected!),
                        ),
                      ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Show Capital', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            Text('28 States · 8 Union Territories',
                textAlign: TextAlign.center,
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ---------------- Screen 2: Capital ----------------
class CapitalScreen extends StatelessWidget {
  final Region region;
  const CapitalScreen({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capital'),
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(region.type,
                          style: TextStyle(
                              color: cs.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ),
                    const SizedBox(height: 12),
                    Text(region.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    Text('CAPITAL',
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                            color: cs.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Text(region.capital,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: cs.primary)),
                    if (region.note != null) ...[
                      const SizedBox(height: 10),
                      Text(region.note!,
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text('Choose another', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ---------------- Screen 0: Welcome ----------------
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.map_outlined, size: 96, color: cs.onPrimary),
              const SizedBox(height: 24),
              Text('States & Capitals',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: cs.onPrimary)),
              const SizedBox(height: 8),
              Text('of India',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: cs.onPrimary)),
              const SizedBox(height: 48),
              Text('This app created by Goruganthu Sateesh Kumar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: cs.onPrimary)),
              const SizedBox(height: 32),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: cs.onPrimary,
                  foregroundColor: cs.primary,
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectScreen()),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Get Started', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}