import java.util.*;

public class Elemento<E>
{
	/*
	**	OVERVIEW:	tipo modificabile che contiene un generico elemento E ed una lista di tipo E
	*/

	//variabili di istanza
	private E dato;
	private int n_Edge;
	private List<E> lista_di_archi;
	public String color;
	public int depth;



	public Elemento()
	{
		dato = null;
		n_Edge = 0;
		lista_di_archi = new Vector<>();
		color = "white";
		depth = 0;
	}


	/*
	**	MODIFIES:	dato
	**	EFFECTS:	aggiorna l'elemento di tipo E
	**	REQUIRES:	un elemento di tipo E diverso da null
	**	THROWS: sollevo un'eccezzione se el == null
	*/
	public void changeE( E el )
	{
		if( el == null ) throw new NullPointerException( "Can not set element" );
		dato = el;
	}


	/*
	**	EFFECTS:	restituisce il numero di archi che ha l'oggetto, che corrisponde alla lunghezza della lista dove sono salvati gli elementi collegati
	**	RETURNS:	n_Edge
	*/
	public int getNedge()
	{
		return n_Edge;
	}


	/*
	**	EFFECTS:	restituisce l'elemento di tipo E presente nell'oggetto
	**	RETURNS:	dato
	*/
	public E getE()
	{
		return dato;
	}


	/*
	**	EFFECTS:	copio la lista di archi in una lista temporanea
	**	RETURNS:	_tmp_list (restituisce la lista temporanea con gli archi dell'oggetto)
	*/
	public List<E> getEdge()
	{
		List<E> _tmp_list = new ArrayList<>();

		for( int i = 0; i < lista_di_archi.size(); i++ )
		{
				_tmp_list.add( lista_di_archi.get(i) );
		}

		return _tmp_list;
	}


	/*
	**	MODIFIES: 	lista_di_archi
	**	EFFECTS: 	aggiunge alla lista degli archi l'elemento che si vuole collegare all'oggetto
	**	REQUIRES:	un elemento di tipo E diverso da null e non presente nella lista
	**	THROWS:		solleva un'eccezione se x == null e se x è già presente nella lista
	*/
	public void addE( E x )
	{
		if( x == null ) throw new NullPointerException("Can not add egde with empty element"); //se x è null sollevo un'eccezzione
		if( lista_di_archi.indexOf( x ) != -1 ) throw new IllegalArgumentException("Element is already connect!!!"); //se nella lista esiste già l'elemento sollevo un'eccezzione

		lista_di_archi.add( x ); //aggiungo alla lista dell'oggetto l'elemento 'x'
		n_Edge++;
	}


	/*
	**	MODIFIES: 	lista_di_archi
	**	EFFECTS: 	rimuove dalla lista degli archi l'elemento che si vuole scollegare dall'oggetto
	**	REQUIRES:	un elemento di tipo E diverso da null e presente nella lista
	**	THROWS:		solleva un'eccezione se x == null e se x è non presente nella lista
	*/
	public void removeE( E x )
	{
		if( x == null ) throw new NullPointerException("Can not remove egde with empty element"); //se x è null sollevo un'eccezzione
		if( lista_di_archi.indexOf( x ) == -1 ) throw new IllegalArgumentException("Element does not exist!!!"); //se nella lista non esiste l'elemento sollevo un'eccezzione

		lista_di_archi.remove( x ); //rimuovo dalla lista dell'oggeto l'elemento 'x'
		n_Edge--;
	}


	/*
	**	EFFECTS:	restituisce una stringa con le informazioni principali dell'oggetto
	**	RETURNS:	s
	*/
	public String toString()
	{
		String s = dato.toString() + "\n" + n_Edge + "\n" + lista_di_archi.toString() + "\n\n";
		return s;  //stampo su ogni riga un dato del nodo
	}


	/*
	**	EFFECTS:		eguaglia la variabile dato con el
	**	REQUIRES:	un oggetto di tipo generico Elemento<E> diverso da null
	**	RETURNS:		true se l'elemento el.dato è ugule ad this.dato, false altrimenti
	**	THROWS:		solleva un'eccezzione se el == null
	*/
	public boolean equals( Elemento<E> el )
	{
		if( el == null ) throw new NullPointerException(); //se x è null sollevo un'eccezzione

		return ( dato.equals( el.dato ) );
	}


}
