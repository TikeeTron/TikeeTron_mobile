import 'package:equatable/equatable.dart';

import '../../../../common/utils/extensions/dynamic_parsing.dart';

class TagDataModel extends Equatable {
  final TagDataData data;

  const TagDataModel({
    required this.data,
  });

  factory TagDataModel.fromJson(Map<dynamic, dynamic> json) {
    return TagDataModel(
      data: TagDataData(
        type: TypeTag(
          image: ImageTag(
            back: json['type']['image']['back'],
            front: json['type']['image']['front'],
            orientation: json['type']['image']?['orientation'],
            cardIdPosition: CardIdPosition(
              top: DynamicParsing(json['type']['image']?['cardIdPosition']?['top']).dynamicToDouble,
              left: DynamicParsing(json['type']['image']?['cardIdPosition']?['left']).dynamicToDouble,
              right: DynamicParsing(json['type']['image']?['cardIdPosition']?['right']).dynamicToDouble,
              bottom: DynamicParsing(json['type']['image']?['cardIdPosition']?['bottom']).dynamicToDouble,
            ),
          ),
          type: json['type']['type'],
          isAnimation: json['type']['is_animation'],
        ),
        cardId: json['cardId'],
        cardNumber: json['cardNumber'],
        status: json['status'],
        isBlocked: json['isBlocked'],
        issuedDate: DateTime.parse(json['issuedDate']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        id: json['id'],
      ),
    );
  }

  //create toJson function for serialization
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'type': {
          'image': {
            'back': data.type.image.back,
            'front': data.type.image.front,
            'orientation': data.type.image.orientation,
            'cardIdPosition': {
              'top': data.type.image.cardIdPosition?.top,
              'left': data.type.image.cardIdPosition?.left,
              'right': data.type.image.cardIdPosition?.right,
              'bottom': data.type.image.cardIdPosition?.bottom,
            },
          },
          'type': data.type.type,
          'is_animation': data.type.isAnimation,
        },
        'cardId': data.cardId,
        'cardNumber': data.cardNumber,
        'status': data.status,
        'isBlocked': data.isBlocked,
        'issuedDate': data.issuedDate.toIso8601String(),
        'createdAt': data.createdAt.toIso8601String(),
        'updatedAt': data.updatedAt.toIso8601String(),
        'id': data.id,
      },
    };
  }

  @override
  List<Object> get props => [data];
}

class TagDataData extends Equatable {
  final TypeTag type;
  final String cardId;
  final String cardNumber;
  final String status;
  final bool isBlocked;
  final DateTime issuedDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  const TagDataData({
    required this.type,
    required this.cardId,
    required this.cardNumber,
    required this.status,
    required this.isBlocked,
    required this.issuedDate,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  @override
  List<Object> get props => [
        type,
        cardId,
        cardNumber,
        status,
        isBlocked,
        issuedDate,
        createdAt,
        updatedAt,
        id,
      ];
}

class TypeTag extends Equatable {
  final ImageTag image;
  final String type;
  final bool isAnimation;

  const TypeTag({
    required this.image,
    required this.type,
    required this.isAnimation,
  });

  @override
  List<Object> get props => [image, type, isAnimation];

  @override
  String toString() {
    return 'TypeTag(image: $image, type: $type, isAnimation: $isAnimation)';
  }
}

class ImageTag extends Equatable {
  final String front;
  final String back;
  final String? orientation;
  final CardIdPosition? cardIdPosition;

  const ImageTag({
    required this.front,
    required this.back,
    required this.orientation,
    required this.cardIdPosition,
  });

  @override
  List<Object?> get props => [
        front,
        back,
        orientation,
        cardIdPosition,
      ];

  @override
  String toString() {
    return 'ImageTag(front: $front, back: $back, orientation: $orientation, cardIdPosition: $cardIdPosition)';
  }
}

class CardIdPosition extends Equatable {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const CardIdPosition({
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  List<Object?> get props => [
        top,
        left,
        right,
        bottom,
      ];

  @override
  String toString() {
    return 'CardIdPosition(top: $top, left: $left, right: $right, bottom: $bottom)';
  }
}
