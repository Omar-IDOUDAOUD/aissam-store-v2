
enum CardStates {
  trash,
  restored,
  deleted,
  selected,
  none;

  bool get isSelected => this == CardStates.selected;
  bool get isTrash => this == CardStates.trash;
  bool get isRestored => this == CardStates.restored;
  bool get isDeleted => this == CardStates.deleted;
}