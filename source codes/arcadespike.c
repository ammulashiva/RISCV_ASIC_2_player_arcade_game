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
	 int temp = key*16;
         unsigned int out_key ;                     //key_1 = bit-4 , key_2 = bit-5
            asm(
			"addi x29,x30,0\n"          // copy x30 to x29
            "and %0,x29, %1\n\t"     // take the key value from specified bit
            :"=r"(out_key)
            :"r"(temp)
        );
		return out_key;
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

        unsigned int temp1 = count_1 * 1048576  ;    // display output bit-25 to bit-21 , 6-bits of x30 reg.
        unsigned int temp2 = count_2 * 67108864 ;    //  display output bit-31 to bit-26 , 6-bits of x30 reg. count_2
		asm(
                        "or x30 , x30 , %1 \n "
			"or x30 , x30, %0 \n"
			:  :"r"(temp1), "r"(temp2)
		);

	
}  



