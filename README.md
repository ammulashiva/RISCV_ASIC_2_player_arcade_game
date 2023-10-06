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
2 Player Arcade game is a physically interactive fun game where people will play very enthusiastically. here as shown in the above figure the game contains "10x5" led matrix and two push buttions where each user uses a push button to continuously press to increase the number of led's of the user colour.when the green and the red leds meet they collide and the upper hand here between the two colours is the  user colour that came in first. Finally the user who has more rate of pressing the push button, will have all the leds lit up with the user colour and the user wins. There will be a buzzer sound to indicate that the game has ended and the new game has started

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

here each time the led count variable is incremented/decremented it checks weather count2 > 0 and count1 <51 and increments/decrements the count variable.If any condition is not satisified then the user wins and the buzzer function is called.the buzzer function uses the delay input from the 555 timer to make 1 second delay with counter and turns on the buzzeer 3 times with a second delay in middle. after beeping 3 times it initialises the count variables again and returns the function to main.

### code

```
//#include<stdio.h>

unsigned int input_key(unsigned int key);
void buzzer(unsigned int state);
void delay(unsigned int delay_ms);
void display(unsigned int count_1, unsigned int count_2);

int main(void)
{
	unsigned int incr1_en = 1 ;
	unsigned int incr2_en = 1 ;
	unsigned int key_1, key_2 ;
	unsigned int count_1 = 0 ;
	unsigned int count_2 = 51 ;


	while(1)
	{

		//printf("enter user keys\n ") ;          //used for debugging in windows
		//scanf("%d",&key_1);
		//scanf("%d",&key_2);
		key_1 = input_key(1);
		key_2 = input_key(2);

	
		if((key_1 > 0)&&(key_2 > 0))
		{
			if((incr1_en ==1)&&(incr2_en == 1))
			{
				if((count_2 - count_1)>1)
				{
					count_2 = count_2 - 1 ;
					incr2_en = 0 ;
					count_1 = count_1 + 1 ;
					incr1_en = 0 ;
				}
				else
				{
					incr1_en = 0 ;
					incr2_en = 0 ;
				}
			}
			else if((incr1_en ==0)&&(incr2_en == 1))
			{
				if((count_2 - count_1)>1)
				{
					count_2 = count_2 - 1 ;
					incr2_en = 0 ;
				}
				else
				{
					count_2 = count_2 - 1 ;
                    incr2_en = 0 ;
					count_1 = count_1 - 1 ;
				}
			}
			else if((incr1_en ==1)&&(incr2_en == 0))
			{
				if((count_2 - count_1)>1)
				{
					count_1 = count_1 +1 ;
					incr1_en = 0 ;
				}
				else
				{
					count_1 = count_1 + 1 ;
					incr1_en = 0 ;
					count_2 = count_2 + 1 ;
				}
			}
			

	
		}
		else if((key_1 > 0)&&(key_2==0))
		{
			incr2_en = 1 ;
			if(incr1_en)
			{
	        	if((count_2 - count_1)>1)
                {
                    count_1 = count_1 +1 ;
                    incr1_en = 0 ;
            	}
          	  	else
           		{
        	       	count_1 = count_1 + 1 ;
                	incr1_en = 0 ;
                 	count_2 = count_2 + 1 ;
            	}
			}	


		}
		else if((key_1==0)&&(key_2 > 0))
		{
			incr1_en = 1 ;
			if(incr2_en)
        	{
                if((count_2 - count_1)>1)
                {
        	        count_2 = count_2 - 1 ;
    	   	        incr2_en = 0 ;
          		}
            	else
          		{
                	count_2 = count_2 - 1 ;
                  	incr2_en = 0 ;
                  	count_1 = count_1 - 1 ;
               	}
        	}

		}
		else
		{
			incr1_en = 1 ;
			incr2_en = 1 ;
		}
		if((count_1 > 50) | (count_2 < 1) )
		{   buzzer(1);          //first beep indicates the game is ended the leds get halted for 1.5 sec. and resetted to 0
			delay(500);
			buzzer(0);
			delay(1000);
			count_1 = 0 ;
			count_2 = 51 ;
			display(count_1, count_2);

			buzzer(1);          //beep sound for 3 times for every 1 sec.
			delay(400);
			buzzer(0);
			delay(600);

			buzzer(1);
			delay(400);
			buzzer(0);
			delay(600);

			buzzer(1);
			delay(400);
			buzzer(0);
			delay(600);



		}
		display(count_1, count_2) ;          //after every iteration the display is updated.
      	//printf("count_1 = %d ,count_2 = %d \n ", count_1, count_2 ) ;           // used for debugging in windows

	}
	return (0);
	
}

unsigned int input_key(unsigned int key)
{
	 int temp = key*16;               //key_1 = bit-4 , key_2 = bit-5
            asm(
			"addi x29,x30,0\n"          // copy x30 to x29
            "and %0,x29, %1\n\t"     // take the key value from specified bit
            :"=r"(key)
            :"r"(temp)
        );
		return temp;
}

void buzzer(unsigned int state)
{
	int temp = state *4 ;    //buzzer output 2nd bit of x30 reg.
		asm(
			"or x30 , x30, %0"
			:  :"r"(temp)
		);
}

void delay(unsigned int delay_ms)
{
	int counter = 0;
	int timer_inp ;             //555 timer input bit 6 of x30
	int temp = 0 ;
	while(1)
	{
		asm(
			"addi x29, x30, 0\n"
			"and %0 , x29, 64"
			:"=r"(timer_inp)
		);

		if(temp != timer_inp)
		{
			temp = timer_inp;
			counter = counter +1 ;
		}
		if(delay_ms == counter)
		{
			break;
		}
	}
}

void display(unsigned int count_1, unsigned int count_2)
{
	int temp1, temp2 ;
	int rem1, rem2 ;      // rows = 10, column = 5 ;
	int row = 1 , column = 1 ;
	int count1_dec = 1, count2_dec = 1;

	temp1 = count_1/5 ;
	temp2 = count_2/5 ;
	rem1 = count_1 % 5 ;
	rem2 = count_2 % 5 ;
	for(int i= 0; i<= count_1; i++)
	{
		count1_dec = 2*count1_dec ;
	}
	for(row = 1; row < count1_dec; row*2)
	{
		column = 5 ;
		//output(row, column);
		delay(1);
	}
	row = count_1 +1 ;
	column = rem1 ;


}

```
### Assembly Code

```

output.o:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <main>:
   0:	fd010113          	add	sp,sp,-48
   4:	02112623          	sw	ra,44(sp)
   8:	02812423          	sw	s0,40(sp)
   c:	03010413          	add	s0,sp,48
  10:	00100793          	li	a5,1
  14:	fef42623          	sw	a5,-20(s0)
  18:	00100793          	li	a5,1
  1c:	fef42423          	sw	a5,-24(s0)
  20:	fe042223          	sw	zero,-28(s0)
  24:	03300793          	li	a5,51
  28:	fef42023          	sw	a5,-32(s0)

0000002c <.L19>:
  2c:	00100513          	li	a0,1
  30:	00000097          	auipc	ra,0x0
  34:	000080e7          	jalr	ra # 30 <.L19+0x4>
  38:	fca42e23          	sw	a0,-36(s0)
  3c:	00200513          	li	a0,2
  40:	00000097          	auipc	ra,0x0
  44:	000080e7          	jalr	ra # 40 <.L19+0x14>
  48:	fca42c23          	sw	a0,-40(s0)
  4c:	fdc42783          	lw	a5,-36(s0)
  50:	12078263          	beqz	a5,174 <.L2>
  54:	fd842783          	lw	a5,-40(s0)
  58:	10078e63          	beqz	a5,174 <.L2>
  5c:	fec42703          	lw	a4,-20(s0)
  60:	00100793          	li	a5,1
  64:	04f71a63          	bne	a4,a5,b8 <.L3>
  68:	fe842703          	lw	a4,-24(s0)
  6c:	00100793          	li	a5,1
  70:	04f71463          	bne	a4,a5,b8 <.L3>
  74:	fe042703          	lw	a4,-32(s0)
  78:	fe442783          	lw	a5,-28(s0)
  7c:	40f70733          	sub	a4,a4,a5
  80:	00100793          	li	a5,1
  84:	02e7f463          	bgeu	a5,a4,ac <.L4>
  88:	fe042783          	lw	a5,-32(s0)
  8c:	fff78793          	add	a5,a5,-1
  90:	fef42023          	sw	a5,-32(s0)
  94:	fe042423          	sw	zero,-24(s0)
  98:	fe442783          	lw	a5,-28(s0)
  9c:	00178793          	add	a5,a5,1
  a0:	fef42223          	sw	a5,-28(s0)
  a4:	fe042623          	sw	zero,-20(s0)
  a8:	0c80006f          	j	170 <.L6>

000000ac <.L4>:
  ac:	fe042623          	sw	zero,-20(s0)
  b0:	fe042423          	sw	zero,-24(s0)
  b4:	0bc0006f          	j	170 <.L6>

000000b8 <.L3>:
  b8:	fec42783          	lw	a5,-20(s0)
  bc:	04079c63          	bnez	a5,114 <.L7>
  c0:	fe842703          	lw	a4,-24(s0)
  c4:	00100793          	li	a5,1
  c8:	04f71663          	bne	a4,a5,114 <.L7>
  cc:	fe042703          	lw	a4,-32(s0)
  d0:	fe442783          	lw	a5,-28(s0)
  d4:	40f70733          	sub	a4,a4,a5
  d8:	00100793          	li	a5,1
  dc:	00e7fc63          	bgeu	a5,a4,f4 <.L8>
  e0:	fe042783          	lw	a5,-32(s0)
  e4:	fff78793          	add	a5,a5,-1
  e8:	fef42023          	sw	a5,-32(s0)
  ec:	fe042423          	sw	zero,-24(s0)
  f0:	0800006f          	j	170 <.L6>

000000f4 <.L8>:
  f4:	fe042783          	lw	a5,-32(s0)
  f8:	fff78793          	add	a5,a5,-1
  fc:	fef42023          	sw	a5,-32(s0)
 100:	fe042423          	sw	zero,-24(s0)
 104:	fe442783          	lw	a5,-28(s0)
 108:	fff78793          	add	a5,a5,-1
 10c:	fef42223          	sw	a5,-28(s0)
 110:	0600006f          	j	170 <.L6>

00000114 <.L7>:
 114:	fec42703          	lw	a4,-20(s0)
 118:	00100793          	li	a5,1
 11c:	12f71e63          	bne	a4,a5,258 <.L20>
 120:	fe842783          	lw	a5,-24(s0)
 124:	12079a63          	bnez	a5,258 <.L20>
 128:	fe042703          	lw	a4,-32(s0)
 12c:	fe442783          	lw	a5,-28(s0)
 130:	40f70733          	sub	a4,a4,a5
 134:	00100793          	li	a5,1
 138:	00e7fc63          	bgeu	a5,a4,150 <.L10>
 13c:	fe442783          	lw	a5,-28(s0)
 140:	00178793          	add	a5,a5,1
 144:	fef42223          	sw	a5,-28(s0)
 148:	fe042623          	sw	zero,-20(s0)
 14c:	10c0006f          	j	258 <.L20>

00000150 <.L10>:
 150:	fe442783          	lw	a5,-28(s0)
 154:	00178793          	add	a5,a5,1
 158:	fef42223          	sw	a5,-28(s0)
 15c:	fe042623          	sw	zero,-20(s0)
 160:	fe042783          	lw	a5,-32(s0)
 164:	00178793          	add	a5,a5,1
 168:	fef42023          	sw	a5,-32(s0)
 16c:	0ec0006f          	j	258 <.L20>

00000170 <.L6>:
 170:	0e80006f          	j	258 <.L20>

00000174 <.L2>:
 174:	fdc42783          	lw	a5,-36(s0)
 178:	06078263          	beqz	a5,1dc <.L12>
 17c:	fd842783          	lw	a5,-40(s0)
 180:	04079e63          	bnez	a5,1dc <.L12>
 184:	00100793          	li	a5,1
 188:	fef42423          	sw	a5,-24(s0)
 18c:	fec42783          	lw	a5,-20(s0)
 190:	0c078663          	beqz	a5,25c <.L11>
 194:	fe042703          	lw	a4,-32(s0)
 198:	fe442783          	lw	a5,-28(s0)
 19c:	40f70733          	sub	a4,a4,a5
 1a0:	00100793          	li	a5,1
 1a4:	00e7fc63          	bgeu	a5,a4,1bc <.L14>
 1a8:	fe442783          	lw	a5,-28(s0)
 1ac:	00178793          	add	a5,a5,1
 1b0:	fef42223          	sw	a5,-28(s0)
 1b4:	fe042623          	sw	zero,-20(s0)
 1b8:	0a40006f          	j	25c <.L11>

000001bc <.L14>:
 1bc:	fe442783          	lw	a5,-28(s0)
 1c0:	00178793          	add	a5,a5,1
 1c4:	fef42223          	sw	a5,-28(s0)
 1c8:	fe042623          	sw	zero,-20(s0)
 1cc:	fe042783          	lw	a5,-32(s0)
 1d0:	00178793          	add	a5,a5,1
 1d4:	fef42023          	sw	a5,-32(s0)
 1d8:	0840006f          	j	25c <.L11>

000001dc <.L12>:
 1dc:	fdc42783          	lw	a5,-36(s0)
 1e0:	06079263          	bnez	a5,244 <.L15>
 1e4:	fd842783          	lw	a5,-40(s0)
 1e8:	04078e63          	beqz	a5,244 <.L15>
 1ec:	00100793          	li	a5,1
 1f0:	fef42623          	sw	a5,-20(s0)
 1f4:	fe842783          	lw	a5,-24(s0)
 1f8:	06078263          	beqz	a5,25c <.L11>
 1fc:	fe042703          	lw	a4,-32(s0)
 200:	fe442783          	lw	a5,-28(s0)
 204:	40f70733          	sub	a4,a4,a5
 208:	00100793          	li	a5,1
 20c:	00e7fc63          	bgeu	a5,a4,224 <.L17>
 210:	fe042783          	lw	a5,-32(s0)
 214:	fff78793          	add	a5,a5,-1
 218:	fef42023          	sw	a5,-32(s0)
 21c:	fe042423          	sw	zero,-24(s0)
 220:	03c0006f          	j	25c <.L11>

00000224 <.L17>:
 224:	fe042783          	lw	a5,-32(s0)
 228:	fff78793          	add	a5,a5,-1
 22c:	fef42023          	sw	a5,-32(s0)
 230:	fe042423          	sw	zero,-24(s0)
 234:	fe442783          	lw	a5,-28(s0)
 238:	fff78793          	add	a5,a5,-1
 23c:	fef42223          	sw	a5,-28(s0)
 240:	01c0006f          	j	25c <.L11>

00000244 <.L15>:
 244:	00100793          	li	a5,1
 248:	fef42623          	sw	a5,-20(s0)
 24c:	00100793          	li	a5,1
 250:	fef42423          	sw	a5,-24(s0)
 254:	0080006f          	j	25c <.L11>

00000258 <.L20>:
 258:	00000013          	nop

0000025c <.L11>:
 25c:	fe442783          	lw	a5,-28(s0)
 260:	0337b793          	sltiu	a5,a5,51
 264:	0017c793          	xor	a5,a5,1
 268:	0ff7f713          	zext.b	a4,a5
 26c:	fe042783          	lw	a5,-32(s0)
 270:	0017b793          	seqz	a5,a5
 274:	0ff7f793          	zext.b	a5,a5
 278:	00f767b3          	or	a5,a4,a5
 27c:	0ff7f793          	zext.b	a5,a5
 280:	0e078063          	beqz	a5,360 <.L18>
 284:	00100513          	li	a0,1
 288:	00000097          	auipc	ra,0x0
 28c:	000080e7          	jalr	ra # 288 <.L11+0x2c>
 290:	1f400513          	li	a0,500
 294:	00000097          	auipc	ra,0x0
 298:	000080e7          	jalr	ra # 294 <.L11+0x38>
 29c:	00000513          	li	a0,0
 2a0:	00000097          	auipc	ra,0x0
 2a4:	000080e7          	jalr	ra # 2a0 <.L11+0x44>
 2a8:	3e800513          	li	a0,1000
 2ac:	00000097          	auipc	ra,0x0
 2b0:	000080e7          	jalr	ra # 2ac <.L11+0x50>
 2b4:	fe042223          	sw	zero,-28(s0)
 2b8:	03300793          	li	a5,51
 2bc:	fef42023          	sw	a5,-32(s0)
 2c0:	fe042583          	lw	a1,-32(s0)
 2c4:	fe442503          	lw	a0,-28(s0)
 2c8:	00000097          	auipc	ra,0x0
 2cc:	000080e7          	jalr	ra # 2c8 <.L11+0x6c>
 2d0:	00100513          	li	a0,1
 2d4:	00000097          	auipc	ra,0x0
 2d8:	000080e7          	jalr	ra # 2d4 <.L11+0x78>
 2dc:	19000513          	li	a0,400
 2e0:	00000097          	auipc	ra,0x0
 2e4:	000080e7          	jalr	ra # 2e0 <.L11+0x84>
 2e8:	00000513          	li	a0,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	000080e7          	jalr	ra # 2ec <.L11+0x90>
 2f4:	25800513          	li	a0,600
 2f8:	00000097          	auipc	ra,0x0
 2fc:	000080e7          	jalr	ra # 2f8 <.L11+0x9c>
 300:	00100513          	li	a0,1
 304:	00000097          	auipc	ra,0x0
 308:	000080e7          	jalr	ra # 304 <.L11+0xa8>
 30c:	19000513          	li	a0,400
 310:	00000097          	auipc	ra,0x0
 314:	000080e7          	jalr	ra # 310 <.L11+0xb4>
 318:	00000513          	li	a0,0
 31c:	00000097          	auipc	ra,0x0
 320:	000080e7          	jalr	ra # 31c <.L11+0xc0>
 324:	25800513          	li	a0,600
 328:	00000097          	auipc	ra,0x0
 32c:	000080e7          	jalr	ra # 328 <.L11+0xcc>
 330:	00100513          	li	a0,1
 334:	00000097          	auipc	ra,0x0
 338:	000080e7          	jalr	ra # 334 <.L11+0xd8>
 33c:	19000513          	li	a0,400
 340:	00000097          	auipc	ra,0x0
 344:	000080e7          	jalr	ra # 340 <.L11+0xe4>
 348:	00000513          	li	a0,0
 34c:	00000097          	auipc	ra,0x0
 350:	000080e7          	jalr	ra # 34c <.L11+0xf0>
 354:	25800513          	li	a0,600
 358:	00000097          	auipc	ra,0x0
 35c:	000080e7          	jalr	ra # 358 <.L11+0xfc>

00000360 <.L18>:
 360:	fe042583          	lw	a1,-32(s0)
 364:	fe442503          	lw	a0,-28(s0)
 368:	00000097          	auipc	ra,0x0
 36c:	000080e7          	jalr	ra # 368 <.L18+0x8>
 370:	cbdff06f          	j	2c <.L19>

00000374 <input_key>:
 374:	fd010113          	add	sp,sp,-48
 378:	02812623          	sw	s0,44(sp)
 37c:	03010413          	add	s0,sp,48
 380:	fca42e23          	sw	a0,-36(s0)
 384:	fdc42783          	lw	a5,-36(s0)
 388:	00479793          	sll	a5,a5,0x4
 38c:	fef42623          	sw	a5,-20(s0)
 390:	fec42783          	lw	a5,-20(s0)
 394:	000f0e93          	mv	t4,t5
 398:	00fef7b3          	and	a5,t4,a5
 39c:	fcf42e23          	sw	a5,-36(s0)
 3a0:	fec42783          	lw	a5,-20(s0)
 3a4:	00078513          	mv	a0,a5
 3a8:	02c12403          	lw	s0,44(sp)
 3ac:	03010113          	add	sp,sp,48
 3b0:	00008067          	ret

000003b4 <buzzer>:
 3b4:	fd010113          	add	sp,sp,-48
 3b8:	02812623          	sw	s0,44(sp)
 3bc:	03010413          	add	s0,sp,48
 3c0:	fca42e23          	sw	a0,-36(s0)
 3c4:	fdc42783          	lw	a5,-36(s0)
 3c8:	00279793          	sll	a5,a5,0x2
 3cc:	fef42623          	sw	a5,-20(s0)
 3d0:	fec42783          	lw	a5,-20(s0)
 3d4:	00ff6f33          	or	t5,t5,a5
 3d8:	00000013          	nop
 3dc:	02c12403          	lw	s0,44(sp)
 3e0:	03010113          	add	sp,sp,48
 3e4:	00008067          	ret

000003e8 <delay>:
 3e8:	fd010113          	add	sp,sp,-48
 3ec:	02812623          	sw	s0,44(sp)
 3f0:	03010413          	add	s0,sp,48
 3f4:	fca42e23          	sw	a0,-36(s0)
 3f8:	fe042623          	sw	zero,-20(s0)
 3fc:	fe042423          	sw	zero,-24(s0)

00000400 <.L28>:
 400:	000f0e93          	mv	t4,t5
 404:	040ef793          	and	a5,t4,64
 408:	fef42223          	sw	a5,-28(s0)
 40c:	fe842703          	lw	a4,-24(s0)
 410:	fe442783          	lw	a5,-28(s0)
 414:	00f70c63          	beq	a4,a5,42c <.L25>
 418:	fe442783          	lw	a5,-28(s0)
 41c:	fef42423          	sw	a5,-24(s0)
 420:	fec42783          	lw	a5,-20(s0)
 424:	00178793          	add	a5,a5,1
 428:	fef42623          	sw	a5,-20(s0)

0000042c <.L25>:
 42c:	fec42783          	lw	a5,-20(s0)
 430:	fdc42703          	lw	a4,-36(s0)
 434:	00f70463          	beq	a4,a5,43c <.L30>
 438:	fc9ff06f          	j	400 <.L28>

0000043c <.L30>:
 43c:	00000013          	nop
 440:	00000013          	nop
 444:	02c12403          	lw	s0,44(sp)
 448:	03010113          	add	sp,sp,48
 44c:	00008067          	ret

00000450 <display>:
 450:	fb010113          	add	sp,sp,-80
 454:	04112623          	sw	ra,76(sp)
 458:	04812423          	sw	s0,72(sp)
 45c:	05010413          	add	s0,sp,80
 460:	faa42e23          	sw	a0,-68(s0)
 464:	fab42c23          	sw	a1,-72(s0)
 468:	00100793          	li	a5,1
 46c:	fef42223          	sw	a5,-28(s0)
 470:	00100793          	li	a5,1
 474:	fef42023          	sw	a5,-32(s0)
 478:	00100793          	li	a5,1
 47c:	fef42623          	sw	a5,-20(s0)
 480:	00100793          	li	a5,1
 484:	fcf42e23          	sw	a5,-36(s0)
 488:	fbc42703          	lw	a4,-68(s0)
 48c:	00500793          	li	a5,5
 490:	02f757b3          	divu	a5,a4,a5
 494:	fcf42c23          	sw	a5,-40(s0)
 498:	fb842703          	lw	a4,-72(s0)
 49c:	00500793          	li	a5,5
 4a0:	02f757b3          	divu	a5,a4,a5
 4a4:	fcf42a23          	sw	a5,-44(s0)
 4a8:	fbc42703          	lw	a4,-68(s0)
 4ac:	00500793          	li	a5,5
 4b0:	02f777b3          	remu	a5,a4,a5
 4b4:	fcf42823          	sw	a5,-48(s0)
 4b8:	fb842703          	lw	a4,-72(s0)
 4bc:	00500793          	li	a5,5
 4c0:	02f777b3          	remu	a5,a4,a5
 4c4:	fcf42623          	sw	a5,-52(s0)
 4c8:	fe042423          	sw	zero,-24(s0)
 4cc:	01c0006f          	j	4e8 <.L32>

000004d0 <.L33>:
 4d0:	fec42783          	lw	a5,-20(s0)
 4d4:	00179793          	sll	a5,a5,0x1
 4d8:	fef42623          	sw	a5,-20(s0)
 4dc:	fe842783          	lw	a5,-24(s0)
 4e0:	00178793          	add	a5,a5,1
 4e4:	fef42423          	sw	a5,-24(s0)

000004e8 <.L32>:
 4e8:	fe842783          	lw	a5,-24(s0)
 4ec:	fbc42703          	lw	a4,-68(s0)
 4f0:	fef770e3          	bgeu	a4,a5,4d0 <.L33>
 4f4:	00100793          	li	a5,1
 4f8:	fef42223          	sw	a5,-28(s0)
 4fc:	0180006f          	j	514 <.L34>

00000500 <.L35>:
 500:	00500793          	li	a5,5
 504:	fef42023          	sw	a5,-32(s0)
 508:	00100513          	li	a0,1
 50c:	00000097          	auipc	ra,0x0
 510:	000080e7          	jalr	ra # 50c <.L35+0xc>

00000514 <.L34>:
 514:	fe442703          	lw	a4,-28(s0)
 518:	fec42783          	lw	a5,-20(s0)
 51c:	fef742e3          	blt	a4,a5,500 <.L35>
 520:	fbc42783          	lw	a5,-68(s0)
 524:	00178793          	add	a5,a5,1
 528:	fef42223          	sw	a5,-28(s0)
 52c:	fd042783          	lw	a5,-48(s0)
 530:	fef42023          	sw	a5,-32(s0)
 534:	00000013          	nop
 538:	04c12083          	lw	ra,76(sp)
 53c:	04812403          	lw	s0,72(sp)
 540:	05010113          	add	sp,sp,80
 544:	00008067          	ret
```
