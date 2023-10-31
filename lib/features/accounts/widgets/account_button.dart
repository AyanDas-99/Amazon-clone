import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(50),
        ),
        child: OutlinedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black12.withOpacity(0.03),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}
