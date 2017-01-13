public class MyModString implements ModString
{
	private char[] string;
	private int count;

	public MyModString( String s )
	{
		this.string = StrToArr( s );
		
		for( int i = 0; i < s.length(); i++ )
		{
			System.out.println(string[i]);
		}
	}


	public char[] StrToArr( String s )
	{	
		this.string = new char[s.length()];

		for( int i = 0; i < s.length(); i++ )
		{
			this.string[i] = s.charAt( i );
		}

		return string;
	}


	public int occurrences( char c )
	{
		count = 0;
		for( int i = 0; i < string.length; i++ )
		{
			if( string[i] == c )
			{
				count++;
			}
		}

		return count;
	}

	public int size()
	{
		return string.length;
	}

	public void insert( char c, int num )
	{
		if( num >= 0 && num < this.string.length )
		{
			this.string[num] = c;
		}
		else
		{
			throw new IllegalArgumentException();
		}
	}

	public void remove( int num )
	{
		for( int i = num; i < this.string.length-1; i++ )
		{
			string[i] = string[i+1];
		}

		//string[string.length-1] = '';

		for( int i = 0; i < string.length; i++ )
		{
			System.out.println( string[i] );
		}

	}

	public boolean equals( char c )
	{
		return false;
	}


	public String toString( )
	{
		String a = new String( this.string );
		return a;
	}

}