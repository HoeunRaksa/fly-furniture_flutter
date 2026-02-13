import 'package:flutter/material.dart';
import '../../../core/widgets/MapPickerScreen.dart';
import '../../../core/widgets/input_field.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key});

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  double? lat;
  double? lng;

  @override
  void dispose() {
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationText = (lat == null || lng == null)
        ? "Select location from map"
        : "Selected: ${lat!.toStringAsFixed(5)}, ${lng!.toStringAsFixed(5)}";

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Address Detail", style: Theme.of(context).textTheme.bodyLarge),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapPickerScreen()),
                );

                if (!mounted) return;

                if (result != null) {
                  setState(() {
                    lat = result["lat"];
                    lng = result["lng"];
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 20),
                    Expanded(child: Text(locationText)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(" Address Detail", style: Theme.of(context).textTheme.bodyLarge),
            InputField(label: "Address Detail", controller: addressController),

            const SizedBox(height: 20),
            Text(" Phone Number", style: Theme.of(context).textTheme.bodyLarge),
            InputField(label: "Phone Number", controller: phoneNumberController),
          ],
        ),
      ),
    );
  }
}
