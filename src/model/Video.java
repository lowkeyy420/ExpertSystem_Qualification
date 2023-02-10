package model;

public class Video {
	private String name;
	private String type;
	private Float rating;
	
	
	public Video() {
	}


	public Video(String name, String type, Float rating) {
		super();
		this.name = name;
		this.type = type;
		this.rating = rating;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public Float getRating() {
		return rating;
	}


	public void setRating(Float rating) {
		this.rating = rating;
	}
	
		

}
