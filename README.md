# processing_chronophotographie

A small app made with processing to experiment with chronophotography from video files.

Chronophotgraphy is a graphic process to visualize movement. You can learn a lot more about it on wikipedia : https://en.wikipedia.org/wiki/Chronophotography

![gif](gif.gif)

This app is built with [processing](https://processing.org/) and GLSL shaders.

To run this app either, grab the latest release from the release tab **or** download the source code from this repo and run the program.

To do this you will need to install processing [processing](https://processing.org/download/) 

An you will also need to install the following libraries from "**sketch**" => "**import a library**" => "**add a library**" menu :

- Processing video from the Processing Foundation
    
- Control P5 from Andreas Schlegel
    
- Post-FX from Florian Bruggisser

- Video Export from Abe Pazos.

For this last one to work you'll need ffmpeg :

- on windows : http://blog.gregzaal.com/how-to-install-ffmpeg-on-windows/

- on mac : https://timrodenbroeker.de/processing-tutorial-video-export/

- on linux it should be available from your packet manager


## Instructions 

To get record a video :

- press l to load a custom video
- enter a file name to record to in the "file_name field" and press ENTER.
- press reset before recording
- toggle record
- untoggle record to finish the recording
- press render to actually export the movie file in the program folder.