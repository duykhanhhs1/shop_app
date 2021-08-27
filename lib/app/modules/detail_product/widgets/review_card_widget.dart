import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    this.productReview,
  }) : super(key: key);

  final ProductReviewModel productReview;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: productReview.reviewer_photo_url != null
                          ? CachedNetworkImage(
                              imageUrl: productReview.reviewer_photo_url,
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            )
                          : Image.asset(
                              "assets/images/default_avatar.png",
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          productReview.reviewer_name,
                          style: TextStyle(color: Colors.black.withOpacity(.7)),
                        ),
                        SizedBox(
                          height: 20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productReview.rating.round(),
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.yellow.shade700,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
                Text(
                  DateFormat("hh:mm dd/MM/yyyy")
                      .format(productReview.create_at),
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            Text(
              productReview.comment,
              textAlign: TextAlign.justify,
              maxLines: 6,
            ),
            SizedBox(height: 5),
            if (productReview.photo_urls.length > 0)
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: productReview.photo_urls.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.network(
                          productReview.photo_urls[index],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
