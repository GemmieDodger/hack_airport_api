

//https://docs.hhvm.com/hack/reference/class/AsyncMysqlClient/connect/


//https://docs.hhvm.com/hack/reference/class/AsyncMysqlClient/connect/
// use \usr\local\mysql\bin as CI;
//THIS WORKS TO CONNECT TO DATABASE
async function do_connect(): Awaitable<\AsyncMysqlQueryResult> {

    $host = "";
    $port = 3000;
    $db = "";
    $user = "";
    $passwd = ""; //this needs looking at to not be plain text...
  // Cast because the array from get_connection_info() is a mixed
  $conn = await \AsyncMysqlClient::connect(
    $host,
    $port,
    $db,
    $user,
    $passwd,
  );
  return await $conn->query('SELECT * FROM airports');
}


async function run_it(): Awaitable<void> {
  $res = await do_connect();

  var_dump(get_object_vars($res));
  \var_dump($res->numRows()); // The number of rows from the SELECT statement
}

async function get_connection(): Awaitable<\AsyncMysqlConnection> {

    $host = "localhost";
    $port = 3000;
    $db = "airports";
    $user = "root";
    $passwd = "password"; //this needs looking at to not be plain text...
  // Get a connection pool with default options
  $pool = new \AsyncMysqlConnectionPool(darray[]);
  // Change credentials to something that works in order to test this code
  return await $pool->connect(
    $host,
    $port,
    $db,
    $user,
    $passwd,
  );
}

//READ ALL
async function fetch_airports(
  \AsyncMysqlConnection $conn,
): Awaitable<Vector<Map<string, ?string>>>  {
  $result = await $conn->queryf(
    'SELECT * from airports',
  );
 $map = $result->mapRows();
  return $map;
}

// READ ONE
async function fetch_airport(
  \AsyncMysqlConnection $conn,
  int $id,
): Awaitable<Vector<Map<string, ?string>>>  {
  $result = await $conn->queryf(
    'SELECT * from airports WHERE ID = %d',
    $id,
  );

  invariant($result->numRows() === 1, 'one row exactly');
 $map = $result->mapRows();
  return $map; 
}
//ADD ONE
async function add_airport(
  \AsyncMysqlConnection $conn,
  string $name,
  string $description,
  string $created,
  string $modified
): Awaitable<Vector<Map<string, ?string>>>  {
 $result = await $conn->queryf(
    "INSERT INTO airports (name, description, created, modified) VALUES
(%s, %s, %s, %s)", $name, $description, $created, $modified  
  );
 $map = $result->mapRows();
  return $map; 
}


//DELETE ONE
async function delete_airport(
  \AsyncMysqlConnection $conn,
  int $id,
): Awaitable<Vector<Map<string, ?string>>>  {
  // Your table and column may differ, of course
  $result = await $conn->queryf(
    'DELETE FROM airports WHERE ID = %d',
    $id,
  );
  // There shouldn't be more than one row returned for one user id
  $check = await $conn->queryf(
    'SELECT * from airports',
  );
  // A vector of vector objects holding the string values of each column
  // in the query
  // $vector = $result->vectorRows();
  // $count = $vector->count();
 $map = $result->mapRows();
  return $map; // We had one column in our query
}

//UPDATE ONE
async function update_airport(
  \AsyncMysqlConnection $conn,
  string $col,
  string $string,
  int $id,
): Awaitable<Vector<Map<string, ?string>>>  {
 $result = await $conn->queryf(
    "UPDATE airports SET %C = %s WHERE ID = %d", $col, $string, $id 
  );
 $map = $result->mapRows();
  return $map; 
}

//GETTING AIRPORT NAME
async function fetch_airport_name(
  \AsyncMysqlConnection $conn,
  int $id,
): Awaitable<?string> {
  $result = await $conn->queryf(
    'SELECT name from airports WHERE ID = %d',
    $id,
  );
  invariant($result->numRows() === 1, 'one row exactly');
  $vector = $result->vectorRows();
  return $vector[0][0]; 
}

// async function get_airport_info(
//   \AsyncMysqlConnection $conn,
//   string $name,
// ): Awaitable<Vector<Map<string, ?string>>> {
//   $result = await $conn->queryf(
//     'SELECT * from airports WHERE name = %s',
//     $conn->escapeString($name),
//   );
//   // A vector of map objects holding the string values of each column
//   // in the query, and the keys being the column names
//   $map = $result->mapRows();
//   return $map;
// }

<<__EntryPoint>>
async function async_mysql_tutorial(): Awaitable<void> {
  $conn = await get_connection();
  if ($conn !== null) {
    // $result = await fetch_airport_name($conn, 2);
    // \var_dump($result);
    print("fetch airport 2");
    $airport = await fetch_airport($conn, 2);
    \var_dump($airport);
    // $info = await get_airport_info($conn, 'Chicago');
        print("fetch all airports");
    $airports = await fetch_airports($conn);
    \var_dump($airports);   
    print_r("delete denver"); 
    $airports = await delete_airport($conn, 6); //DENVER
     print_r("fetch all excluding denver"); 
     $airports = await fetch_airports($conn);
    \var_dump($airports);   
    print_r("update airport");
    $airports = await update_airport($conn, "name", "LosAngeles", 2); 
    print_r("fetch airport 2");
    $airport = await fetch_airport($conn, 2);
    \var_dump($airport);
    print_r("create airport Denver");
    $create = await add_airport($conn, 'Denver', 'DEN', '2014-06-01 00:35:07', '2014-05-30 17:34:54');
    \var_dump($create);
    print_r("fetch all including new denver"); //DENVER IS NOW MISSING - ADD IT BACK
    $airports = await fetch_airports($conn); //DENVER
    \var_dump($airports); 
    // \var_dump($info is vec<_>);
    // \var_dump($info[0] is dict<_, _>);
  }
}

