use function Facebook\FBExpect\expect;
use type Facebook\HackTest\{DataProvider, HackTest};

//to run     vendor/bin/hacktest tests/


final class AirportTest extends HackTest {

    public function testConnectAirport(): void {
        expect(get_connection())->toNotBeEmpty();
    }
    public async function testFetchAirpots(): Awaitable<void> {
        expect(get_connection())->toNotBeEmpty();
        $conn = await get_connection();
        expect(fetch_airports($conn))->toNotBeEmpty();
    }
    public async function testFetchAirportName(): Awaitable<void> {
        expect(get_connection())->toNotBeEmpty();
        $conn = await get_connection();
        expect( await fetch_airport_name($conn, 1))->toBeSame('Atlanta');
    }
    public async function testFetchAirports2(): Awaitable<void> {
        expect(get_connection())->toNotBeEmpty();
        $conn = await get_connection();
        $airports = await fetch_airports($conn);
        $length = count($airports);
        expect($length)->toEqual($length);
    }
    public async function testAddAirport(): Awaitable<void> {
        expect(get_connection())->toNotBeEmpty();
        $conn = await get_connection();
        $airports = await fetch_airports($conn);
        $length = count($airports);
        expect($length)->toEqual($length);
        await add_airport($conn, 'New York', 'JFK', '2014-06-01 00:35:07', '2014-05-30 17:34:33');
        $airports = await fetch_airports($conn);
        $newLength = count($airports);
        expect($newLength)->toEqual($length+1);
    }
    public async function testDeleteAirport(): Awaitable<void> {
        expect(get_connection())->toNotBeEmpty();
        $conn = await get_connection();
        $airports = await fetch_airports($conn);
        $length = count($airports);
        expect($length)->toEqual($length);
        $delete = 26; 
        await delete_airport($conn, $delete);
        $airports = await fetch_airports($conn);
        $newLength = count($airports);
        expect($newLength)->toEqual($length-1);
    }
    public async function testUpdateAirport(): Awaitable<void> {
        expect(get_connection())->toNotBeEmpty();
        $conn = await get_connection();
        expect( await fetch_airport_name($conn, 7))->toBeSame('LosAngeles');
        await update_airport($conn, "name", "Los Angeles", 7);
        $conn = await get_connection();
        $airports = await fetch_airports($conn);
        expect( await fetch_airport_name($conn, 7))->toBeSame('Los Angeles');
    }
}