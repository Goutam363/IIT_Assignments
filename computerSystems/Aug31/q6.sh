#!/bin/bash

welcome_screen() {
  echo "**** Welcome to My shellATM ****"
  echo "**** Press any key to continue ***"
  read -n 1 -s
}

authenticate_user() {
  while true; do
    echo "Enter Card Number:"
    read card_number
    echo "Enter Password:"
    read -s password

    if grep -q "^$card_number,$password$" Credentials.txt; then
      echo "Authentication successful!"
      break
    else
      echo "Invalid card number or password. Please try again."
    fi
  done
}

update_balance() {
  local card_number="$1"
  local new_balance="$2"

  sed -i "/^.*$card_number .*/s/[0-9]\+$/${new_balance}/" Account.txt
}

withdraw_cash() {
  echo "Enter amount to withdraw:"
  read amount

  if [[ "$amount" =~ ^[0-9]+$ && "$amount" -gt 0 ]]; then
    local line=$(grep "$card_number" Account.txt)
    local balance=$(echo "$line" | cut -d',' -f4)
    local new_balance=$((balance - amount))

    if [[ "$new_balance" -ge 0 ]]; then
      update_balance "$card_number" "$new_balance"
      echo "Withdrawal successful. Your new balance is $new_balance."
    else
      echo "Insufficient funds."
    fi
  else
    echo "Invalid amount entered."
  fi
}

deposit_cash() {
  echo "Enter amount to deposit:"
  read amount

  if [[ "$amount" =~ ^[0-9]+$ && "$amount" -gt 0 ]]; then
    local line=$(grep "$card_number" Account.txt)
    local balance=$(echo "$line" | cut -d',' -f4)
    local new_balance=$((balance + amount))

    update_balance "$card_number" "$new_balance"
    echo "Deposit successful. Your new balance is $new_balance."
  else
    echo "Invalid amount entered."
  fi
}

update_email() {
  echo "Enter new email address:"
  read new_email

  if [[ "$new_email" =~ ^[a-zA-Z][a-zA-Z0-9]*@[a-z][a-z]+\.[a-z]+\.[a-z]+$ ]]; then
    sed -i "/^.*$card_number .*/s/\b[a-zA-Z0-9._%+-]+@[a-z]+\.[a-z]+\.[a-z]+\b/$new_email/" Account.txt
    echo "Email address updated successfully."
  else
    echo "Invalid email address format."
  fi
}

# Flow Starts here
while true; do
  welcome_screen
  authenticate_user

  while true; do
    echo "Choose an option:"
    echo "1. Withdraw cash"
    echo "2. Deposit cash"
    echo "3. Settings"
    echo "4. Exit"
    read option

    case $option in
      1)
        withdraw_cash
        ;;
      2)
        deposit_cash
        ;;
      3)
        update_email
        ;;
      4)
        echo "Thank you for using My shellATM. Goodbye!"
        exit 0
        ;;
      *)
        echo "Invalid option. Please try again."
        ;;
    esac
  done
done
