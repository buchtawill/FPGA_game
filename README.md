# FPGA_game

I got interested in FPGAs and came across Digilent's Basys3 evaluation board. To start learning, I decided to make a VGA controller; that entailed generating the timing signals in hardware. After some development, I made a working timing module. The next logical step was to create an animation of the popular game Among Us, of course.

To do so, I made a Java program that takes an image and gets every pixel's RGB value. It then converts the image into a ROM module as a large case statement. When the module is given the x and y coordinates of the current position, it will return what color should be displayed.
