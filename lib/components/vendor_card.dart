import 'package:flutter/material.dart';
import 'package:plug/model/vendor.dart';
import 'package:plug/screens/view_vendor_screen.dart';
import 'package:plug/utilities/constants.dart';

class HomeVendorCard extends StatelessWidget {
  final Vendor vendor;
  const HomeVendorCard({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViewVendorPage(vendor: vendor);
        }));
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.fromLTRB(22, 15, 22, 15),
        decoration: kBoxDecoration.copyWith(boxShadow: kBoxShadow),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                vendor.logoUrl,
                width: 112,
                height: 112,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vendor.businessName,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    vendor.desc,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    vendor.address,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}