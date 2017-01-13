public interface IndexedLibrary extends Library
{
	//return book by index
	public Book getByIndex( int index );

	//remove book by index
	public void remove( int index );

}