# Classic Cassette Deck Processing Sketch

### Maura Gerke

### June 5, 2018

### CE4: Interface Sound Design in Processing


## Design

My cassette deck was inspired by the portable/personal tape players I used in elementary school for listening quizzes. I tried to make a more modern-looking version with the same general UI layout for this project. It's more simplified since it doesn't have the recording and eject features and the volume knob is moved from the side to make it functional as part of the player.
![personal cassette player](https://store.schoolspecialty.com/OA_HTML/xxssi_ibeGetWCCImage.jsp?docName=F1633054&Rendition=Large)

## Functionality

The play, stop, fast forward, and rewind buttons operate as like a real tape player, and the reset button stops the track and sets it back to the beginning. When clicked, the button appears darker as 'pressed down' and remains pressed until the next button is pressed, like a real tape player. 
The volume knob can be turned up and down by clicking and dragging the bar or scrolling with the mouse while hovering over it. This replicates the volume knob on the side of a tape player, but moved to the top.

## Audio Feedback

I chose a mechanical-sounding [button noise](https://freesound.org/people/bubaproducer/sounds/107134/) to be consistant with the visual design inspiration.
I chose not to connect it to the volume control gain because it's not part of the music track and is 'live' feedback.

## Extra Features

In addition to the required controls, I added a control for the volume of the music.

I initally wanted to make the tape gears to rotate forward when playing and backwards when rewinding, but that proved to be more complicated that expected in Processing.
