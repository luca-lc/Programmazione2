public interface ModString
{
	public int occurrences( char c );

	public int size();

	public void insert( char c, int num );

	public void remove( int num );

	public boolean equals( char c );

	public char[] StrToArr( String s );

	public String toString( );
}