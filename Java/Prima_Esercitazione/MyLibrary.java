import java.util.*;


class Node 
{
	protected Book bk;
	protected Node next;

	public Node( Book b )
	{
		this( b, null );
	}

	public Node( Book b, Node n )
	{
		this.bk = b;
		this.next = n;
	}
}


public class MyLibrary implements Library
{
	/*
	private String autore, titolo, editore;
	privare int anno;
	*/

	protected Node n;

	public MyLibrary( )
	{
		n = null;
	}

	public MyLibrary( Book[] b )
	{
		if( b == null ) throw new NullPointerException();

		for( int i = 0; i < b.length; i++ )
		{
			insert( b[i] );
		} 
	}

	//extend interface
	public String[] getByAuthor( String aut )
	{
		if( aut == null ) throw new NullPointerException();

		Vector tmp_aut = new Vector();

		for( Node tmp = n; tmp != null; tmp = tmp.next )
		{
			if( tmp.bk.getAuthor().equals( aut ) )
			{
				tmp_aut.add( tmp.bk );
			}
		} 


		return VetToArr( tmp_aut );
	}

	public String[] getByTitle( String tit )
	{
		if( tit == null ) throw new NullPointerException();

		Vector tmp_tito = new Vector();

		for( Node tmp = n; tmp != null; tmp = tmp.next )
		{
			if( tmp.bk.getTitle().equals( tit ) )
			{
				tmp_tito.add( tmp.bk ); 
			}
		}


		return VetToArr( tmp_tito );
	}

	public String[] getByPublisher( String pub )
	{
		if( pub == null ) throw new NullPointerException();

		Vector tmp_publ = new Vector();

		for( Node tmp = n; tmp != null; tmp = tmp.next )
		{
			if( tmp.bk.getPublisher().equals( pub ) )
			{
				tmp_publ.add( tmp.bk );
			}
		}

		return VetToArr( tmp_publ );
	}

	public String[] getByYear( int y )
	{
		if( y < 1900 ) throw new IllegalArgumentException();
		
		Vector tmp_a = new Vector();
		for( Node tmp = n; tmp != null; tmp = tmp.next )
		{
			if( tmp.bk.getYear() == y )
			{
				tmp_a.add( tmp.bk );		
			}
		}


		return VetToArr( tmp_a ); 
	}

	public String[] getAuthorByPublisher( String pub )
	{
		if( pub == null ) throw new NullPointerException();
		
		Vector abp = new Vector();

		for( Node tmp = n; tmp != null; tmp = tmp.next )
		{
			if( tmp.bk.getPublisher().equals( pub ) )
			{
				if ( abp.indexOf( tmp.bk.getAuthor() ) == -1 )
					abp.add( tmp.bk.getAuthor() );
			}
		}

		return VetToArr( abp );
	}

	public void insert( Book b )
	{
		if( b == null ) throw new NullPointerException();
		n = new Node( b, n );
	}

	public void remove( Book b )
	{
		if( b == null ) throw new NullPointerException();
		
		Node precc = null;
		Node corr;
		for( corr = n; !(corr.bk.equals( b )); precc = corr, corr = corr.next );
		if( corr.bk.equals( b ) )
		{
			if( precc == null )
			{
				n = n.next;
			}
			else
			{
				precc.next = corr.next;
			}
		}
	}

	private String[] VetToArr( Vector v )
	{
		String[] arr = new String[v.size()];
		
		for( int i = 0; i < v.size(); i++ )
			arr[i] = v.get(i).toString();

		return arr;
	}
}




