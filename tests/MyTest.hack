use function Facebook\FBExpect\expect;
use type Facebook\HackTest\{DataProvider, HackTest};
// I think i want to watch this youtube:
// https://www.youtube.com/watch?v=BnJQJNGkUdM
//API's: https://docs.hhvm.com/hsl/reference/
final class MyTest extends HackTest {
  public function provideSquaresExamples(): vec<(vec<num>, vec<num>)> {
    return vec[
      tuple(vec[1, 2, 3], vec[1, 4, 9]),
      tuple(vec[1.1, 2.2, 3.3], vec[1.1 * 1.1, 2.2 * 2.2, 3.3 * 3.3]),
    ];
  }

  <<DataProvider('provideSquaresExamples')>>
  public function testSquares(vec<num> $in, vec<num> $expected_output): void {
    expect(square_vec($in))->toBeSame($expected_output);
  }
}