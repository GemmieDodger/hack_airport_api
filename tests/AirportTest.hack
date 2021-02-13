use function Facebook\FBExpect\expect;
use type Facebook\HackTest\{DataProvider, HackTest};

final class AirportTest extends HackTest {
    // public function addAirport(): vec<(vec<num>, vec<num>)> {
    //     return vec[
    //         tuple(vec[1])
    //     ]
    // }
    // public function connectAirport(): void {

    // }

    //check connection to airport

    public function testConnectAirport(): void {
        expect(do_connect())->toNotBeEmpty();
    }
    public function testFetchAirports(): void {
        // \AsyncMysqlConnection $conn = do_connect();
        expect(fetch_airports(AsyncMysqlConnection $conn))->toNotBeEmpty();
    }
}