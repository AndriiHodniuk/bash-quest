#!/bin/bash

echo "Welcome, traveler, to the Labyrinth of Commands!"
echo "What is your name?"

read PLAYER_NAME

echo "A fine name, ${PLAYER_NAME}! Your journey begins now."

echo "You stand at a crossroads. A dark path leads to the LEFT, a bright one to the RIGHT."
echo "Which path will you choose? (Type LEFT or RIGHT)"

read DIRECTION

if [ "$DIRECTION" == "LEFT" ]; then
    echo "You chose the path of shadows. It is cold damp here."
elif [ "$DIRECTION" == "RIGHT" ]; then
    echo "You chose the path of light. Birds are singing, and the air is warm."
else 
    echo "Indecisiveness is a dangerous trait, $PLAYER_NAME. A goblin jumps out of the bushes and eats you."
    echo "GAME OVER"
fi
