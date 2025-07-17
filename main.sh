#!/usr/bin/env bash

set -eu

# === COLORS ===
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

# === EXIT CLEANING FUNCTION ===
function on_exit {
    if [ -n "${PLAYER_NAME-}" ]; then # Checking if the PLAYER_NAME variable has been installed
        echo ""
        echo "${BLUE}Farewell, $PLAYER_NAME. Your quest is over... for now.${RESET}"
    else
        echo "${BLUE}The adventure ends before it began...${RESET}"
    fi
}
trap on_exit EXIT

# === CHARACTER ANNOUNCEMENT ===
declare -A player
player[health]=50
player[strength]=5
player[has_key]=0 # 0 - немає, 1 - є

declare -A goblin
goblin[health]=30
goblin[strength]=3
goblin[is_alive]=1

# === GAME INITIALIZATION ===
# Create or clear a log file at the start of the game
> quest.log

echo "${BLUE}Welcome, traveler, to the Labyrinth of Commands!${RESET}"
echo "What is your name?"

read PLAYER_NAME
echo "A fine name,${GREEN}$PLAYER_NAME!${RESET} Your journey begins now."
echo "Type ${YELLOW}QUIT${RESET} to exit the game at any time."

# === MAIN GAME CYCLE ===
while true; do
    echo ""
    echo "You have ${GREEN}${player[health]} HP${RESET}. You see a path leading ${RED}LEFT${RESET} and another leading ${GREEN}RIGHT${RESET}."
    echo "What will you do? (LEFT, RIGHT, LOOK, QUIT)"

    read DIRECTION
    echo "Player command: $DIRECTION" >> quest.log

    # ... попередній код ...

case "$DIRECTION" in
    LEFT)
        if [ ${goblin[is_alive]} -eq 1 ]; then
            echo "${RED}You try to go left, but the goblin attacks you!${RESET}"
            player[health]=$(( ${player[health]} - ${goblin[strength]} ))
            echo "The goblin hits you for ${goblin[strength]} damage. You have ${player[health]} HP left."
        else
             echo "${RED}You chose the path of shadows. It is cold and damp here.${RESET}"
        fi
        ;;
    RIGHT)
        echo "${GREEN}You chose the path of light. Birds are singing, and the air is warm.${RESET}"
        ;;
    LOOK)
        if [ ${player[has_key]} -eq 0 ]; then
            echo "${YELLOW}You look around and find a rusty key under a rock!${RESET}"
            player[has_key]=1
        else
            echo "You already have the key."
        fi
        ;;
    ATTACK)
        if [ ${goblin[is_alive]} -eq 1 ]; then
            # Гравець атакує
            goblin[health]=$(( ${goblin[health]} - ${player[strength]} ))
            echo "You attack the goblin, dealing ${player[strength]} damage. It has ${goblin[health]} HP left."

            # Перевірка, чи переможений гоблін
            if [ ${goblin[health]} -le 0 ]; then
                echo "${GREEN}You have defeated the goblin! The path is clear.${RESET}"
                goblin[is_alive]=0
            else
                # Гоблін атакує у відповідь
                player[health]=$(( ${player[health]} - ${goblin[strength]} ))
                echo "The goblin retaliates, hitting you for ${goblin[strength]} damage. You have ${player[health]} HP left."
            fi
        else
            echo "There is nothing to attack."
        fi
        ;;
    QUIT)
        exit 0
        ;;
    *)
        echo "${RED}I don't understand that command, $PLAYER_NAME.${RESET}"
        ;;
esac
done

# Перевірка на поразку гравця
if [ ${player[health]} -le 0 ]; then
    echo "${RED}You have been defeated. GAME OVER.${RESET}"
    exit 1
fi
