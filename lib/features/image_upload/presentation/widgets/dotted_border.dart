import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DottedBorderWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const DottedBorderWidget({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      dashPattern: const [6, 4],
      strokeWidth: 1.5,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor.withOpacity(0.03),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 32, // Reduced size
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                text,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'JPG, PNG up to 5MB',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}