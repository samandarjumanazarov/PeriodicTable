#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if an argument is provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
fi

# Function to get element details
GET_ELEMENT_INFO() {
  # Check if input is an integer (atomic number)
  if [[ $1 =~ ^[0-9]+$ ]]; then
    # Query for atomic number
    local QUERY_RESULT=$($PSQL "SELECT atomic_number, symbol, name, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types ON properties.type_id = types.type_id WHERE atomic_number = $1;")
  else
    # Query for symbol or name
    local QUERY_RESULT=$($PSQL "SELECT atomic_number, symbol, name, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types ON properties.type_id = types.type_id WHERE symbol = '$1' OR name = '$1';")
  fi

  if [[ -z $QUERY_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    # Read the query result into variables
    IFS="|" read -r ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT <<< "$QUERY_RESULT"
    
    # Print the formatted output
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
}

# Call the function with the provided argument
GET_ELEMENT_INFO "$1"
