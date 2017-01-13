public interface IndexedBook extends Book
{
	//return index code of a book
	public int getIndex();

	//return genre of a book
	public String getGenre();

	//return true if 'b' has same genre of 'this' 
	public boolean sameGenre( IndexedBook b );

	public String toString();

	public boolean equals( IndexedBook b );

}