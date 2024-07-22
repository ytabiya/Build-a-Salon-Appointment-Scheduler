#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~ My Salon ~~~\n"

MAIN_MENU () {
  if [[ $1 ]]
  then
  echo -e "$1"
  fi
  
  echo -e "\nWelcome to My Salon, please select required service"
  echo -e "\n1) cut\n2) color\n3) trim\n4) exit"
  read SERVICE_ID_SELECTED
  
  case $SERVICE_ID_SELECTED in
    1) APPOINTMENT_MENU ;; 
    2) APPOINTMENT_MENU ;;
    3) APPOINTMENT_MENU ;;
    4) EXIT_MENU ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac 
  }

APPOINTMENT_MENU () {
SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
  then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
fi
INSERT_CUSTOMER=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
echo -e "\nWhat time would you like your $SERVICE_NAME_SELECTED, $CUSTOMER_NAME?"
read SERVICE_TIME
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
  }

EXIT_MENU () {
echo "exit menu"
}

  MAIN_MENU
