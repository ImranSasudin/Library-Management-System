import java.util.Scanner;

public class compile {

	public compile() {
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("resource")
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		 Scanner input = new Scanner (System.in);
	        //initialization of user input N
	        int num1 = 0;
	        boolean threeconsecutive = false;
	        boolean twoconsecutive = false;
	        
	        int num2 = 1;
	        int num3 = 2;
	        int totalsum = num1 + num2 + num3;
	        System.out.println("Enter input N:");
	        int userinput = input.nextInt();
	        if (userinput % 3 == 0) {
	            threeconsecutive = true;
	            while (userinput != totalsum) {
	            //incrementing each to match user input for they are still consecutive
	            
	            num1 ++;
	            num2++;
	            num3++;	       
	            System.out.println(num1 + " " + num2 + " " + num3);
	            }
	        }
	        if (totalsum == userinput && String.valueOf(threeconsecutive) == "true") {
	            System.out.println("3 consecutive numbers that add up to N");
	            System.out.println(num1 + " + " + num2 + " + " + num3);
	        }
	        else if (userinput % 2 == 0) {
	            twoconsecutive = true;
	            while (userinput != totalsum) {
	                //incrementing just two numbers if three isnt possible
	                num1 ++;
	                num2++;
	                System.out.println(num1 + " " + num2 + " " + num3);
	            }
 
	        }

	        else if (totalsum == userinput && String.valueOf(twoconsecutive) == "true") {
	            
	            System.out.println("No solution");
	            System.out.println("All possible consecutive numbers that add up to N");
	            System.out.println("THE TIME WAS TOO LESS I ALMOST FIGURED OUT QUESTION TWO ASWELL OMGG");
	        }

	        }

}
