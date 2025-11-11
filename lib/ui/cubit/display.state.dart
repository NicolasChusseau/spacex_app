sealed class DisplayCubitState {
  const DisplayCubitState();

  bool get isGridView => this is GridState;
}

class ListState extends DisplayCubitState {
  const ListState();
}

class GridState extends DisplayCubitState {
  const GridState();
}
