#!/bin/bash

# === COLORS ===
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

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
    echo "You stand at a crossroads. A dark path leads to the ${RED}LEFT${RESET}, a bright one to the ${GREEN}RIGHT${RESET}."
    echo "What will you do? (Type LEFT, RIGHT, LOOK, HINT or QUIT)"

    read DIRECTION

    echo "Player command: $DIRECTION" >> quest.log

    if [ "$DIRECTION" == "LEFT" ]; then
        echo "${RED}You chose the path of shadows. It is cold and damp here.${RESET}"
        echo "EVENT: ENTERED_SHADOW_PATH" >> quest.log
    elif [ "$DIRECTION" == "RIGHT" ]; then
        echo "${GREEN}You chose the path of light. Birds are singing, and the air is warm.${RESET}"
        echo "EVENT: ENTERED_LIGHT_PATH" >> quest.log
    elif [ "$DIRECTION" == "LOOK" ]; then
        if [ $(grep -c "ENTERED_SHADOW_PATH" quest.log) -gt 0 ] && [ $(grep -c "EVENT: FOUND_RUSTY_KEY" quest.log) -eq 0 ]; then
            echo "${YELLOW}You look closely at the shadows... and find a rusty key!${RESET}"
            echo "EVENT: FOUND_RUSTY_KEY" >> quest.log
        fi
    elif [ "$DIRECTION" == "HINT" ]; then
        # The hint is only available if the player has been on the shadow path
        if [ $(grep -c "ENTERED_SHADOW_PATH" quest.log) -gt 0 ]; then
             echo "${YELLOW}You feel a strange insight... Sometimes, looking closely is the key.${RESET}"
        else
             echo "You try to concentrate, but no hints come to mind."
        fi
    elif [ "$DIRECTION" == "QUIT" ]; then
        echo "Farewell, $PLAYER_NAME. Your quest is over... for now."
        break
    else
        echo "${RED}I don't understand that command, $PLAYER_NAME.${RESET}"
    fi
done

echo "${BLUE}GAME OVER${RESET}"
