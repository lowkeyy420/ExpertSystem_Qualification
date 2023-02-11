package app;

import java.util.Scanner;

import jess.Deftemplate;
import jess.Fact;
import jess.JessException;
import jess.Rete;

public class Main {

	public static Rete engine;
	private Scanner scan;
	
	private void cls() {
		for(int i = 0 ; i < 32; i++) {System.out.println(); }
	}
	
	
	private int menu() {
		cls();
		System.out.println("YOutube red");
		System.out.println("1. Upload Video");
		System.out.println("2. View My Videos");
		System.out.println("3. Update Video Information");
		System.out.println("4. Remove Video");
		System.out.println("5. Recommend Video");
		System.out.println("6. Exit");
		System.out.print(">> ");
		
		int input = 0;
		try {
			input = scan.nextInt();
		} catch (Exception e) {
			scan.nextLine();
			return -1;
		}
		scan.nextLine();
		return input;
	}

	public Main() {
		scan = new Scanner(System.in);
		engine = new Rete();
		try {
			engine.batch("app/Main.clp");
			engine.reset();
			engine.run();
			engine.assertString("");
		} catch (JessException e) {
			e.printStackTrace();
		}
		
		
//		while(true) {
//			int options = menu();
//			
//			if(options == 1) {
//				
//			} else if(options == 2) {
//				
//			} else if(options == 3) {
//				
//			} else if(options == 4) {
//				
//			} else if(options == 5) {
//				
//			} else if(options == 6) {
//				System.exit(1);
//			} else {
//				System.out.println("Invalid Input");
//			}
//		}
	}

	public static void main(String[] args) {
		new Main();
	}

}
