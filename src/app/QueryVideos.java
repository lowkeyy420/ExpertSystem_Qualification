package app;

import jess.JessException;
import jess.QueryResult;
import jess.ValueVector;

public class QueryVideos {

	public QueryVideos() {
		try {
			QueryResult res = Main.engine.runQueryStar("get-all-videos", new ValueVector());
			while(res.next()) {
				System.out.println(res.get("name"));
				System.out.println(res.get("type"));
				System.out.println(res.get("rating"));
			}	
		} catch (JessException e) {
			e.printStackTrace();
		}
	}

}
