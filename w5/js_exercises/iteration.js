function bubble_sort(arr) {
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 1; i < arr.length; i++) {
      if (arr[i - 1] > arr[i]) {
        sorted = false;
        var left = arr[i - 1];
        arr[i - 1] = arr[i];
        arr[i] = left;
      }
    }
  }
  return arr;
};

// console.log(bubble_sort([5,4,3,2,1]));

function substrings(str) {
  var result = [];
    for (var i = 0; i < str.length; i++) {
      for (var j = i + 1; j <= str.length; j++) {
        result.push(str.slice(i, j));
      };
    };
    return result;
  };

  // console.log(substrings("abcd"));
