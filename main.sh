#!/bin/bash

echo "Welcome, traveler, to the Labyrinth of Commands!"
echo "What is your name?"

read PLAYER_NAME

echo "A fine name, ${PLAYER_NAME}! Your journey begins now."

echo "You stand at a crossroads. A dark path leads to the LEFT, a bright one to the RIGHT."
echo "Which path will you choose? (Type LEFT or RIGHT)"

read DIRECTION

echo "Player chose path: $DIRECTION" >> quest.log


if [ "$DIRECTION" == "LEFT" ]; then
    echo "You chose the path of shadows. It is cold damp here."
    echo "EVENT: ENTERED_SHADOW_PATH" >> quest.log
elif [ "$DIRECTION" == "RIGHT" ]; then
    echo "You chose the path of light. Birds are singing, and the air is warm."
    echo "EVENT: ENTERED_LIGHT_PATH" >> quest.log
elif [ "$DIRECTION" == "LOOK" ]; then
    if [ $(grep -c "ENTERED_SHADOW_PATH" quest.log) -gt 0 ] && [ $(grep -c "EVENT: FOUND_RUSTY_KEY" quest.log) -eq 0 ]; then
        echo "You look closely at the shadows... and find a rusty key!"
        echo "EVENT: FOUND_RUSTY_KEY" >> quest.log
    else
        echo "You look around, but see nothing of interest."
    fi
else 
    echo "Indecisiveness is a dangerous trait, $PLAYER_NAME. A goblin jumps out of the bushes and eats you."
    echo "GAME OVER"
fi
