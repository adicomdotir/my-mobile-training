List<int> arr = [2, 5, 3, 8, 1];
int size = arr.length;
List<List<int>> min = [
  [
    -1,
    -1,
    -1,
    -1,
    -1,
  ],
  [
    -1,
    -1,
    -1,
    -1,
    -1,
  ],
  [
    -1,
    -1,
    -1,
    -1,
    -1,
  ],
  [
    -1,
    -1,
    -1,
    -1,
    -1,
  ],
  [
    -1,
    -1,
    -1,
    -1,
    -1,
  ],
];

void main(List<String> args) {
  for (var i = 1; i < size; i++) {
    min[i][i] = 0;
  }

  for (var l = 2; l < size; l++) {
    for (var i = 1; i < size - l + 1; i++) {
      int j = i + l - 1;
      min[i][j] = double.maxFinite.toInt();
      for (var k = i; k < j; k++) {
        int q = min[i][k] + min[k + 1][j] + arr[i - 1] * arr[k] * arr[j];
        if (q < min[i][j]) {
          min[i][j] = q;
        }
      }
    }
  }
  print(min);
  print(min[1][size - 1]);
}
