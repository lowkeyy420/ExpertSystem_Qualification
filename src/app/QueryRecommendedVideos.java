package app;

import jess.JessException;
import jess.QueryResult;
import jess.ValueVector;

public class QueryRecommendedVideos {

	public QueryRecommendedVideos() {
		try {
			QueryResult res = Main.engine.runQueryStar("get-recommended-video", new ValueVector());
			while(res.next()) {
				System.out.println(res.getString("name"));
				System.out.println(res.getInt("price"));
				System.out.println(res.getString("type"));
			}	
		} catch (JessException e) {
			e.printStackTrace();
		}
	}
}

