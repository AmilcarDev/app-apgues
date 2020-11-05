import 'package:flutter/material.dart';

class CardItemModel {
  String cardTitle;
  IconData icon;
  double tasksRemaining;
  double taskCompletion;

  CardItemModel(
      this.cardTitle, this.icon, this.tasksRemaining, this.taskCompletion);
}
