package app;

import java.util.Scanner;

import jess.Deftemplate;
import jess.Fact;
import jess.JessException;
import jess.Rete;

public class Main {

	public static Rete engine;
	private Scanner scan;
		
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
		
		String input = "";
		while(true) {
			
			
			input = scan.nextLine();
		}
	}

	public static void main(String[] args) {
		new Main();
	}

}
