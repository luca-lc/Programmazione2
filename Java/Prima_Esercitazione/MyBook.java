public class MyBook implements Book
{
	private String autore, titolo, editore;
	private int anno;
	public MyBook( String author, String title, String pub, int year)
	{
		this.autore = author;
		this.titolo = title;
		this.editore = pub;
		this.anno = year;
	}

	public String getAuthor()
	{
		return autore;
	}
	public String getTitle()
	{
		return titolo;
	}
	public String getPublisher()
	{
		return editore;
	}
	public int getYear()
	{
		return anno;
	}

	public boolean sameAuthor( Book b )
	{
		return autore.equals(b.getAuthor());
	}
	public boolean samePublisher( Book b )
	{
		return editore.equals(b.getPublisher());
	}
	public boolean sameYear( Book b )
	{
		return  ( anno == b.getYear() );
	}


	public boolean equals( Book obj )
	{
		return 
			(
				autore == obj.getAuthor() &&
				titolo == obj.getTitle() &&
				editore == obj.getPublisher() &&
				anno == obj.getYear() 
			);
	}


	public String toString( )
	{
		return this.autore + " - " + this.titolo + " - " + this.editore + " - " + this.anno;
	}
}