
//if its a php file <?hh //strict
namespace Hack\GettingStarted\MyFirstProgram;
<<__EntryPoint>>

function main(): void {
  echo "Welcome to Hack!\n\n";

  \printf("Table of Squares\n" .
          "----------------\n");
  for ($i = -5; $i <= 5; ++$i) {
    \printf("  %2d        %2d  \n", $i, $i * $i);
  }
  \printf("----------------\n");
  exit(0);
}


//https://codeofaninja.com/2017/02/create-simple-rest-api-in-php.html

//hh_client = type checker
//https://medium.com/@mikeabelar/web-development-with-hhvm-and-hack-hello-world-9652aac6ba44

// const express = require('express')
// const app = express()
// const swaggerUi = require('swagger-ui-express')
// const airports = require('./airports.json')
// const YAML = require('js-yaml')
// const fs = require('fs')
// const docs = YAML.load(fs.readFileSync('./airports-config.yaml').toString())
// const swaggerDocs = require('swagger-jsdoc')({
//     swaggerDefinition: docs,
//     apis: ['./server.js', './Airport.js']
// })
// app.use(express.urlencoded({ extended: true }))
// app.use(express.json())

//https://www.internalfb.com/intern/wiki/EPI/SysEng/Coding/ReactWorkshop/


// final class AirportController {
//     protected static function helloAirport() {
//         return airport.react.js;

//     }


// }
