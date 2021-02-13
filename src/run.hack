
async function run(): Awaitable<void> {
  $res = await do_connect();

  var_dump(get_object_vars($res));
  \var_dump($res->numRows()); // The number of rows from the SELECT statement
}
