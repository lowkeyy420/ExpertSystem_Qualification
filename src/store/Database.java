package store;

import java.util.Vector;

import app.Main;
import jess.JessException;
import jess.QueryResult;
import jess.ValueVector;

import model.Video;

public class Database {

	private Vector<Video> videos;

	private static Database instance;
	
	public static Database getInstance() {
		if (instance == null) instance = new Database();
		return instance;
	}
	
	private Database() {
		videos = new Vector<>();
	}
	
	public Vector<Video> getVideos() {
		return videos;
	}
	
	public void refreshDatas() {
		Video vid = new Video();
		QueryResult res;
		try {
			res = Main.engine.runQueryStar("get-recommended-videos", new ValueVector());
			while(res.next()) {
				System.out.println(res.get("name"));
				System.out.println(res.get("price"));
				System.out.println(res.get("type"));
				
				vid.setName(res.getString("name"));
				vid.setType(res.getString("type"));
				vid.setRating(res.getFloat("rating"));
				
				videos.add(vid);
			}
		} catch (JessException e) {
		}

	}


}
