

async function get_connection(): Awaitable<\AsyncMysqlConnection> {

    $host = "";
    $port = 3000;
    $db = "";
    $user = "";
    $passwd = ""; 
  // Get a connection pool with default options
  $pool = new \AsyncMysqlConnectionPool(darray[]);
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
  $result = await $conn->queryf(
    'DELETE FROM airports WHERE ID = %d',
    $id,
  );
  $check = await $conn->queryf(
    'SELECT * from airports',
  );
 $map = $result->mapRows();
  return $map; 
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


<<__EntryPoint>>
async function async_mysql_tutorial(): Awaitable<void> {
  $conn = await get_connection();
  if ($conn !== null) {

    print("fetch airport 2");
    $airport = await fetch_airport($conn, 2);
    \var_dump($airport);
        print("fetch all airports");
    $airports = await fetch_airports($conn);
    \var_dump($airports);   
    print_r("delete denver"); 
    $airports = await delete_airport($conn, 6); 
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

