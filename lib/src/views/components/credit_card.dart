import 'package:flutter/material.dart';

import 'package:pardakht/src/domain/enums/card_network_type.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CreditCard extends StatelessWidget {
  final String holderName;
  final double amount;
  final String issuer;
  final CardNetworkType? cardNetworkType;
  const CreditCard({
    super.key,
    required this.holderName,
    required this.amount,
    required this.issuer,
    this.cardNetworkType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amountField = Row(
      children: [
        Text(
          "Amount:",
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.textTheme.titleSmall?.color?.withAlpha(100),
          ),
        ),
        Text(
          "$amount \$",
          style: theme.textTheme.titleSmall,
        )
      ],
    );
    var appLogo = Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        "pngs/pardakht.png",
        fit: BoxFit.cover,
        height: 150,
        width: 150,
        color: Colors.white,
      ),
    );
    final issuerName = Positioned(
      right: 20,
      top: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "pngs/pardakht.png",
            height: 20,
            width: 20,
            color: Colors.white,
          ),
          const SizedBox(width: 3),
          Text(
            "Pardakht",
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    final clipPath = ClipPath(
      clipper: JaggedClipper(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(50).withOpacity(0.2),
            borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: 300,
      ),
    );

    const sim = Positioned(
      right: 20,
      bottom: 20,
      child: Row(
        children: [
          Icon(
            MaterialCommunityIcons.integrated_circuit_chip,
            color: Colors.amber,
          ),
          Icon(
            MaterialCommunityIcons.contactless_payment,
            color: Colors.tealAccent,
          ),
        ],
      ),
    );
    final cardField = Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      height: 150,
      width: 300,
      child: Stack(
        children: [clipPath, appLogo, issuerName, sim],
      ),
    );
    final holderNameField = Text(
      holderName,
      style: theme.textTheme.titleSmall,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          amountField,
          cardField,
          holderNameField,
        ],
      ),
    );
  }
}

class JaggedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 50, 0);
    path.lineTo(100, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
