public class MyIndexedBook extends MyBook implements IndexedBook
{	
	private int index;
	private String genere;


	public MyIndexedBook( String autore, String titolo, String editore, int anno, String genere )
	{
		super( autore, titolo, editore, anno );
		this.genere = genere;
		
	}

	public MyIndexedBook( int codice, String autore, String titolo, String editore, int anno, String genere )
	{
		super( autore, titolo, editore, anno );
		this.genere = genere;
		this.index = codice;

	}

	public MyIndexedBook( Book b, int codice ,String genere)
	{
		this( codice, b.getAuthor(), b.getTitle(), b.getPublisher(), b.getYear(), genere );
	}


	public String getGenre()
	{
		return this.genere;
	}

	public int getIndex()
	{
		return this.index;
	}

	public boolean sameGenre( IndexedBook b )
	{
		return this.genere.equals( b.getGenre() );
	}
 	
 	public String toString()
 	{
 		return this.index + " - " + super.toString() +  " - " + this.genere;
 	}

 	public boolean equals( IndexedBook obj )
	{
		return 
			(
				super.equals(obj) /*&&
				genere == obj.getGenre()*/
			);
	}
}