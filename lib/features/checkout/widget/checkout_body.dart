import 'package:flutter/material.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:fly/features/checkout/widget/checkout_bottom.dart';
import 'package:fly/model/order_request.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/MapPickerScreen.dart';
import '../../../core/widgets/input_field.dart';
import '../../../model/order_item.dart';

class CheckoutBody extends StatefulWidget {
  final List<OrderItem> items;
  final double total;
  final Future<void> Function(OrderRequest request) onContinue;
  const CheckoutBody({
    super.key,
    required this.onContinue,
    required this.total,
    required this.items,
  });
  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  double? lat;
  double? long;

  Future<void> _onContunue() async {
    if (lat == null || long == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select location from map")),
      );
      return;
    }

    if (addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please give address properly")),
      );
      return;
    }

    if (phoneNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter phone number")),
      );
      return;
    }

    final createRequest = OrderRequest(
      shipping: addressController.text.trim(),
      phone: phoneNumberController.text.trim(),
      payment: "QR",
      items: widget.items,
      lat: lat,
      long: long,
    );

    await widget.onContinue(createRequest);
  }


  @override
  void dispose() {
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationText = (lat == null || long == null)
        ? "Select location from map"
        : "Selected: ${lat!.toStringAsFixed(5)}, ${long!.toStringAsFixed(5)}";

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Address Detail",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
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
                    long = result["lng"];
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
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
            Text(
              " Address Detail",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            InputField(label: "Address Detail", controller: addressController),
            const SizedBox(height: 20),
            Text(" Phone Number", style: Theme.of(context).textTheme.bodyLarge),
            InputField(
              label: "Phone Number",
              controller: phoneNumberController,
            ),
            Spacer(),
            CheckoutBottom(onContinue: _onContunue),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
