import 'package:flutter/material.dart';
import '../data/room_data.dart';

class RoomListingsScreen extends StatelessWidget {
  const RoomListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rooms & Tours')),
      body: ListView.builder(
        itemCount: resortRooms.length,
        itemBuilder: (context, index) {
          final room = resortRooms[index];
          return ListTile(
            title: Text(room.name),
            subtitle: Text('₱${room.pricePerNight.toStringAsFixed(0)}'),
            onTap: () =>
                Navigator.pushNamed(context, '/room-detail', arguments: room),
          );
        },
      ),
    );
  }
}
