import 'package:flutter/material.dart' show immutable;
import 'package:game_design/domain/entities/player_entity.dart';
import 'package:game_design/domain/entities/treasure_entity.dart';

@immutable
class GameEntity {
  final int? gameId;  //no gameId means game is never saved
  final int score;
  final PlayerEntity playerEntity;
  final TreasureEntity treasureEntity;

  GameEntity({
    this.gameId,
    required this.score,
    required this.playerEntity,
    required this.treasureEntity,
  });

  GameEntity copyWith({
    int? gameId,
    int? score,
    PlayerEntity? playerEntity,
    TreasureEntity? treasureEntity,
  }) {
    return GameEntity(
      gameId: gameId,
      score: score ?? this.score,
      playerEntity: playerEntity ?? this.playerEntity,
      treasureEntity: treasureEntity ?? this.treasureEntity,
    );
  }

  // GameEntity clone(){
  //   return copyWith();
  // }
}
