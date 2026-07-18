import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/room.dart';
import '../models/booking_details.dart';
import '../services/firestore_service.dart';
import '../theme/app_theme.dart';

/// Booking form screen handles guest details, stay dates, and booking submission.
class BookingFormScreen extends StatefulWidget {
  final Room room;
  const BookingFormScreen({super.key, required this.room});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guestCount = 1;
  late StayPackage _package;
  bool _isSubmitting = false;

  final _dateFormat = DateFormat('MMM d, yyyy');

  @override
  void initState() {
    super.initState();
    // Set the default stay package when the booking form loads.
    _package = StayPackage.overnightStay;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickCheckIn() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _checkIn = picked;
        // Reset check-out if it is not valid after a new check-in date.
        if (_checkOut != null && !_checkOut!.isAfter(_checkIn!)) {
          _checkOut = null;
        }
      });
    }
  }

  Future<void> _pickCheckOut() async {
    if (_checkIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a check-in date first.')),
      );
      return;
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkIn!.add(const Duration(days: 1)),
      firstDate: _checkIn!.add(const Duration(days: 1)),
      lastDate: _checkIn!.add(const Duration(days: 60)),
    );
    if (picked != null) {
      setState(() => _checkOut = picked);
    }
  }

  Future<void> _submit() async {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (_checkIn == null || _checkOut == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both check-in and check-out dates.'),
        ),
      );
      return;
    }

    if (!formValid) return;

    final confirmationNumber = 'AND-${100000 + Random().nextInt(899999)}';

    final booking = BookingDetails(
      room: widget.room,
      checkIn: _checkIn!,
      checkOut: _checkOut!,
      guestCount: _guestCount,
      package: _package,
      guestName: _nameController.text.trim(),
      confirmationNumber: confirmationNumber,
    );

    setState(() => _isSubmitting = true);
    try {
      // Send booking details to Firestore and navigate on success.
      await FirestoreService.instance.submitBooking(booking);
      if (!mounted) return;
      Navigator.pushNamed(context, '/booking-confirmation', arguments: booking);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not save your booking to the server. Please try again.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Your Stay')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 64 : 20,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(room.imageEmojis.first,
                          style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '₱${room.pricePerNight.toStringAsFixed(0)} / night',
                              style: const TextStyle(color: AppColors.coral),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Guest Name',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter the full name for this reservation',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a guest name.';
                  }
                  if (value.trim().length < 2) {
                    return 'Name is too short.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text('Check-in / Check-out',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: 'Check-in',
                      value: _checkIn,
                      formatter: _dateFormat,
                      onTap: _pickCheckIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateField(
                      label: 'Check-out',
                      value: _checkOut,
                      formatter: _dateFormat,
                      onTap: _pickCheckOut,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Guests',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _GuestStepper(
                count: _guestCount,
                maxGuests: room.maxGuests,
                onChanged: (value) => setState(() => _guestCount = value),
              ),
              const SizedBox(height: 24),
              const Text('Package',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              RadioGroup<StayPackage>(
                groupValue: _package,
                onChanged: (value) => setState(() => _package = value!),
                child: Column(
                  children: StayPackage.values
                      .map(
                        (pkg) => RadioListTile<StayPackage>(
                          contentPadding: EdgeInsets.zero,
                          value: pkg,
                          activeColor: AppColors.coral,
                          title: Text(pkg.label),
                          subtitle: Text(pkg.description),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Icon(Icons.check_circle_outline),
                  label: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(_isSubmitting
                        ? 'Saving Booking...'
                        : 'Confirm Booking Request'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final DateFormat formatter;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.formatter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today, size: 18),
        ),
        child: Text(
          value == null ? 'Select date' : formatter.format(value!),
          style: TextStyle(
            color: value == null ? Colors.black45 : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}

class _GuestStepper extends StatelessWidget {
  final int count;
  final int maxGuests;
  final ValueChanged<int> onChanged;

  const _GuestStepper({
    required this.count,
    required this.maxGuests,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Number of guests (max $maxGuests)'),
          Row(
            children: [
              IconButton(
                onPressed: count > 1 ? () => onChanged(count - 1) : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColors.deepTeal,
              ),
              Text(
                '$count',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed:
                    count < maxGuests ? () => onChanged(count + 1) : null,
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.deepTeal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
