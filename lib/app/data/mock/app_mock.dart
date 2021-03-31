import 'package:scrum_app/app/data/models/product_model.dart';

class AppMock {
  static List<ProductOverViewModel> products = [
    ProductOverViewModel(
        productNo: 1,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrl:
            'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
        price: 3000),
    ProductOverViewModel(
        productNo: 2,
        name: 'Iphone 12 Pro Max 256 GB zxcxz zxc ',
        imageUrl:
            'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
        price: 123123),
    ProductOverViewModel(
        productNo: 3,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrl:
            'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
        price: 2323),
    ProductOverViewModel(
        productNo: 4,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrl:
            'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
        price: 34340),
  ];

  static List<ProductDetailModel> productDetails = [
    ProductDetailModel(
        price: 3000,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrls: [
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
        ],
        productProperties: [
          ProductPropertyModel(property: 'Kho còn', content: '2323'),
          ProductPropertyModel(property: 'Dòng máy', content: 'Apple'),
          ProductPropertyModel(property: 'Chất liệu', content: 'Nhựa'),
        ],
        rating: 4.7,
        shippingCost: 2000,
        shopLocation: 'Vinh',
        shopName: 'thegioibanve',
        shopImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJK5ssLOJ_fu9WoRvjZ6e6tQ9LXARku0GfKg&usqp=CAU',
        productReviews: [
          ProductReviewModel(
              rating: 4,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
              ],
              comment: 'zxcz 1',
              username: 'duykhanh1'),
          ProductReviewModel(
              rating: 3,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
              ],
              comment: 'zxcz 2',
              username: 'duykhanh12'),
        ]),
    ProductDetailModel(
        productNo: 2,
        price: 123123,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrls: [
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
        ],
        productProperties: [
          ProductPropertyModel(property: 'Kho còn', content: '2323 2'),
          ProductPropertyModel(property: 'Dòng máy', content: 'Apple'),
          ProductPropertyModel(property: 'Chất liệu', content: 'Nhựa'),
        ],
        rating: 4.7,
        shippingCost: 2000,
        shopLocation: 'Vinh',
        shopName: 'thegioibanve',
        shopImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJK5ssLOJ_fu9WoRvjZ6e6tQ9LXARku0GfKg&usqp=CAU',
        productReviews: [
          ProductReviewModel(
              rating: 4,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
              ],
              comment: 'zxcz 1',
              username: 'duykhanh1'),
          ProductReviewModel(
              rating: 3,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
              ],
              comment: 'zxcz 2',
              username: 'duykhanh12'),
        ]),
    ProductDetailModel(
        productNo: 3,
        price: 2323,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrls: [
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
        ],
        productProperties: [
          ProductPropertyModel(property: 'Kho còn', content: '2323'),
          ProductPropertyModel(property: 'Dòng máy', content: 'Apple 3'),
          ProductPropertyModel(property: 'Chất liệu', content: 'Nhựa'),
        ],
        rating: 4.7,
        shippingCost: 2000,
        shopLocation: 'Vinh',
        shopName: 'thegioibanve',
        shopImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJK5ssLOJ_fu9WoRvjZ6e6tQ9LXARku0GfKg&usqp=CAU',
        productReviews: [
          ProductReviewModel(
              rating: 4,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
              ],
              comment: 'zxcz 1',
              username: 'duykhanh1'),
          ProductReviewModel(
              rating: 3,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
              ],
              comment: 'zxcz 2',
              username: 'duykhanh12'),
        ]),
    ProductDetailModel(
        productNo: 4,
        price: 34340,
        name: 'Iphone 12 Pro Max 256 GB',
        imageUrls: [
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
          'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
        ],
        productProperties: [
          ProductPropertyModel(property: 'Kho còn', content: '2323'),
          ProductPropertyModel(property: 'Dòng máy', content: 'Apple'),
          ProductPropertyModel(property: 'Chất liệu', content: 'Nhựa 4'),
        ],
        rating: 4.7,
        shippingCost: 2000,
        shopLocation: 'Vinh',
        shopName: 'thegioibanve',
        shopImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJK5ssLOJ_fu9WoRvjZ6e6tQ9LXARku0GfKg&usqp=CAU',
        productReviews: [
          ProductReviewModel(
              rating: 4,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'
              ],
              comment: 'zxcz 1',
              username: 'duykhanh1'),
          ProductReviewModel(
              rating: 3,
              imageUrls: [
                'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg',
              ],
              comment: 'zxcz 2',
              username: 'duykhanh12 4'),
        ]),
  ];
}
