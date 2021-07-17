import 'package:flutter/material.dart';
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