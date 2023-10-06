# RISCV_ASIC_2_player_arcade_game

### RISCV GNU tool chain

RISCV GNU tool chain is a C & C++ cross compiler. It has two modes: ELF/Newlib toolchain and Linux-ELF/glibc toolchain. We are using ELF/Newlib toolchain.

We are building a custom RISCV based application core for a specific application for 32 bit processor. 

Following are tools required to compile & execute the application:

1. RISCV GNU toolchain with dependent libraries as specified in [RISCV-GNU-Toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain).

2. Spike simulator - Spike is a functional RISC-V ISA simulator that implements a functional model of one or more RISC-V harts. [RISCV-SPIKE](https://github.com/riscv-software-src/riscv-isa-sim.git).

### RISCV 32 bit compiler installation.

```
sudo apt install libc6-dev
git clone https://github.com/riscv/riscv-gnu-toolchain --recursive
mkdir riscv32-toolchain
cd riscv-gnu-toolchain
./configure --prefix=/home/ammula-shiva-kumar/riscv32-toolchain/ --with-arch=rv32i --with-abi=ilp32
sudo apt-get install libgmp-dev
make
```

Access the riscv32-unknown-elf-gcc inside bin folder of riscv32-toolchain folder in home folder of user as shown.

```
/home/ammula-shiva-kumar/riscv32-toolchain/bin/riscv32-unknown-elf-gcc --version

```

### 2 Player Arcade Game

![arcade_game](./Images/arcade_game.png)

**Description**
2 Palyer Arcade game is a physically interactive fun game where people will play very enthusiastically. here as shown in the above figure the game contains "10x5" led matrix and two push buttions where each user uses a push button to continuously press to increase the number of led's of the user colour.when the green and the red leds meet they collide and the upper hand here between the two colours is the  user colour that came in first. Finally the user who has more rate of pressing the push button, will have all the leds lit up with the user colour and the user wins. There will be a buzzer sound to indicate that the game has ended and the new game has started

### Block Diagram

![Block_diagram](./Images/Block_diagram.png)

### Functionality -

- In this architecture the microcontroller samples the user input on every loop and checks weather the user input status(pressed or released) is changed or not . 1 will be transmitted if button is pressed and 0 is transmitted if button is released.
- In the middle of the loop if the status of the button changes from '0' to '1' then led count value of that particular user is incremented.
- If the push bution status stays constant then no change is done on the led count variables.
- Here a variable incr_en is used to signify that the push buttion status is changed and you can increment the user count variable.
- The above mentioned logic is mandatory to ensure that every time user presses the key once only one led is incremented.
- When both leds collide led count variables are incremented or decremented based on which user input is given respectively.
- here led counts are initialised with 0 and 51 for user 1 and 2 respectively.
- if user 1 presses the button then count 1 is incremented and if user 2 presses the key then count 2 is decremented .
- the user with all the leds as the same user colour wins.
- A buzzer sound is provided which beeps three times with a second delay each to indicate that the previous game has ended and new game starts after the 3 beeps so users should get ready to play in the mean time.
  
### Flow Chart

![flow_chart](./Images/flow_chart.png)

here each time the led count variable is incremented/decremented it checks weather count2 > 0 and count1 <51 and increments/decrements the count variable.If any condition is not satisified then the user wins and the buzzer function is called.the buzzer function uses the delay input from the 555 timer to make 1 second delay with counter and turns on the buzzeer 3 times with a second delay in middle
