package global.sesoc.lipcoding.vo;

public class Parsing {
	private int key;
	private String name;
	private String title;
	private int parent;

	
	public Parsing(int key, String name, String title) {
		super();
		this.key = key;
		this.name = name;
		this.title = title;
	}
	
	public Parsing(int key, String name, String title, int parent) {
		super();
		this.key = key;
		this.name = name;
		this.title = title;
		this.parent = parent;
	}

	public Parsing() {
		super();
	}

	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	@Override
	public String toString() {
		return "Parsing [key=" + key + ", name=" + name + ", title=" + title + ", parent=" + parent + "]";
	}
}

