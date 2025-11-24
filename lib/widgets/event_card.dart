import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String eventName;
  final String eventType;
  final String price;
  final List<String> tags;
  final bool showButton;
  final VoidCallback? onButtonPressed;

  const EventCard({
    super.key,
    required this.imageUrl,
    required this.eventName,
    required this.eventType,
    required this.price,
    required this.tags,
    this.showButton = true,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: SizedBox(
        width: size.width * 0.44,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: size.height * 0.12,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: size.height * 0.12,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : Image.asset(
                      imageUrl,
                      width: double.infinity,
                      height: size.height * 0.12,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: size.height * 0.12,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
            ),

            Padding(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Name and Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          eventName,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: size.width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        price,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD64F5C),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.005),

                  // Event Type
                  Text(
                    eventType,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),

                  SizedBox(height: size.height * 0.008),

                  // Tags
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: tags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE5E5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: size.width * 0.025,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFD64F5C),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Button (conditionally shown)
                  if (showButton) ...[
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onButtonPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD64F5C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.008,
                          ),
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Lihat Kode QR',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: size.width * 0.032,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
