#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
# Delete the element with atomic_number 1000 from the 'properties' and 'elements' tables, if it exists.
$PSQL "DELETE FROM properties WHERE atomic_number = 1000;"
$PSQL "DELETE FROM elements WHERE atomic_number = 1000;"
echo "Deleted element with atomic_number 1000 from the database."
 
$PSQL "ALTER TABLE properties DROP COLUMN type;"
echo "Deleted column type from properties."