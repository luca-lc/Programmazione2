public class Main
{
	public static void main( String[] args )
	{
		ModString s = new MyModString( "ciaoc" );
		System.out.println( "i caratteri ripetuti sono: " +  s.occurrences( 'c' ) );
		System.out.println( "La lunghezza stringa è: " + s.size() );
		s.insert( 'e', 2 );
		s.remove( 4 );
		System.out.println( s.toString() );
	}
}