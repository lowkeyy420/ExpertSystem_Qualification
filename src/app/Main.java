package app;


import jess.JessException;
import jess.Rete;

public class Main {

	public static Rete engine;

	public Main() {
		engine = new Rete();
		try {
			engine.batch("app/Main.clp");
			engine.reset();
			engine.run();
			engine.assertString("");
		} catch (JessException e) {
			e.printStackTrace();
		}


	}

	public static void main(String[] args) {
		new Main();
	}

}
