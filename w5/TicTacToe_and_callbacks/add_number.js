var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
})

var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  } else {
    reader.question("Give me a number", function (userInput) {
      var num = parseInt(userInput);
      console.log(sum + num)
      addNumbers(sum + num, numsLeft - 1, completionCallback);
    })
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
