import 'package:flutter/material.dart';
import '../data/room_data.dart';
import '../models/room.dart';
import '../widgets/room_card.dart';
import '../theme/app_theme.dart';

class RoomListingsScreen extends StatefulWidget {
  const RoomListingsScreen({super.key});

  @override
  State<RoomListingsScreen> createState() => _RoomListingsScreenState();
}

class _RoomListingsScreenState extends State<RoomListingsScreen> {
  RoomCategory? _selectedCategory; // null = "All"

  List<Room> get _filteredRooms {
    if (_selectedCategory == null) return resortRooms;
    return resortRooms.where((r) => r.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900
        ? 4
        : width > 600
        ? 3
        : 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Rooms & Tours')),
      body: Column(
        children: [
          _CategoryFilterBar(
            selected: _selectedCategory,
            onSelected: (cat) => setState(() => _selectedCategory = cat),
          ),
          Expanded(
            child: _filteredRooms.isEmpty
                ? const Center(child: Text('No listings in this category.'))
                : RefreshIndicator(
                    onRefresh: () async {
                      // Simulates re-fetching local data.
                      await Future.delayed(const Duration(milliseconds: 400));
                      setState(() {});
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: _filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = _filteredRooms[index];
                        return RoomCard(
                          room: room,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/room-detail',
                            arguments: room,
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilterBar extends StatelessWidget {
  final RoomCategory? selected;
  final ValueChanged<RoomCategory?> onSelected;

  const _CategoryFilterBar({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final categories = <RoomCategory?>[null, ...RoomCategory.values];

    return Container(
      color: AppColors.sand.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((cat) {
            final label = cat == null ? 'All' : cat.label;
            final isSelected = selected == cat;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(label),
                selected: isSelected,
                selectedColor: AppColors.coral,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppColors.deepTeal,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: Colors.white,
                onSelected: (_) => onSelected(cat),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

