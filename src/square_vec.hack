use namespace HH\Lib\Vec;

//to run tests you... vendor/bin/hacktest tests/
//to run the code you... 

function square_vec(vec<num> $numbers): vec<num> {
  return Vec\map($numbers, $number ==> $number * $number);
}
