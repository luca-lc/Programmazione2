import java.util.*;
import java.awt.Desktop;
import java.net.URL;
import java.net.URI;


class MalformedURLException extends Exception
{
	public MalformedURLException()
	{
		super();
	}
	public MalformedURLException( String s )
	{
		super( s );
	}
}



public class MyGraph<E> implements Graph<E>
{
	/*
	**	OVERVIEW:	dato modificabile rappresentante un grafo non orientanto di tipo generico E
	**	AF:	[node_1] -> {el_1, el_2, ..., el_i}
					[node_2] -> {el_1, el_2, ..., el_z}
					[node_3] -> {el_1, el_2, ..., el_k}
					. . .
					[node_n] -> {el_1, el_2, ..., el_j}


	**	IR: node == elementi.size() && elementi != null
					forall i. 0 <= i < node ==> elementi.get(i) != null
	 				forall i,j . 0 <= i,j < node && i != j ==> elementi.get(i) != elementi.get(j)
					forall i,j . 0 <= i < node && 0 <= j < elementi.get(i).getNedge() ==> elementi.get(i) != elementi.get(i).getEdge().get(j)
	*/


	//variabili di istanza
	private Vector<Elemento<E>> elementi;
	private int node; //number of node in elementi



	public MyGraph()
	{
		elementi = new Vector<>();
		node = 0;
	}


	/*
	**	EFFECTS:	restituisce la variabile che rappresenta il numero di nodi del grafo e la lunghezza del vettore elementi
	**	RETURNS: 	node
	*/
	public int size()
	{
		return node;
	}


	/*
	**	EFFECTS: copia il vettore di nodi in un secondo vettore utilizzabile dal cliente
	**	RETURNS: restituisce il vettore con i nodi del grafo
	*/
	public Vector<Elemento<E>> getGraph()
	{
		Vector<Elemento<E>> tmp_el = new Vector<>();
		for( int i = 0; i < size(); i++ )
			tmp_el.add(elementi.get(i));

		return tmp_el;
	}


	/*
	**	MODIFIES:	elementi, node
	**	EFFECTS:	aggiunge al vettore contenente gli oggetti 'Elemento<E>' un nuovo oggetto con l'elemento 'el' ed incrementa la variabile 'node' che rappresenta il numero di nodi
	**	REQUIRES:	un elemento di tipo generico E diverso da null e non presente nel grafo
	**	THROWS:		se el == null solleva l'eccezione NullPointerException (UNCHECKED), se el è già presente solleva l'eccezione IllegalArgumentException (UNCHECKED)
	*/
	public void addNode( E el )
	{

		if( el == null ) throw new NullPointerException("Can not add an empty element"); //se 'el' è null sollevo un'eccezione
		if( searchforadd( el ) != -1 ) throw new IllegalArgumentException("Can not add an element already exist"); //se l'elemento che si vuole aggiungere esiste già sollevo un'eccezione

		Elemento<E> element = new Elemento<E>(); //creo un elemento da aggiungere al vettore di nodi
		element.changeE( el );
		elementi.add( element );	//aggiungo l'elemento creato al vettore di nodi

		node++; //incremento la lunghezza del vettore (il numero di nodi)
	}


	/*
	**	MODIFIES:	elementi, node
	**	EFFECTS:	rimuove dal vettore contenente gli oggetti 'Elemento<E>' l'oggetto con l'elemento 'el' e tutte le sue occorenze dagli altri oggetti e decrementa la variabile 'node' che rappresenta il numero di nodi
	**	REQUIRES:	un elemento di tipo generico E diverso da null e presente nel grafo
	**	THROWS:		se el == null e se el non è presente solleva l'eccezione IllegalArgumentException (UNCHECKED)
	*/
	public void removeNode( E el )
	{
		if( searchforadd( el ) == -1 ) throw new IllegalArgumentException( "Can not delete element " + el + ", it does not exist" );//se l'elemento da eliminare non esiste o è 'null' solleva l'eccezione

		Elemento<E> elem = searchE( el ); //ricerca nel vettore di nodi l'elemento 'el'
		List<E> elem_edges = elem.getEdge(); //prendo la lista di elementi associata a 'el'

		E current;
		int size_list = elem_edges.size();

		while ( elem_edges.size() > 0 ) //rimuovo da tutte le liste dei nodi l'elemento 'el'
		{
			current = elem_edges.get(0);
			removeEdge( current , el );
		}

		elementi.remove( elem ); //rimuovo dal vettore l'elemento 'el'

		node--; //decremento la lunghezza del vettore (il numero di nodi)
	}


	/*
	**	MODIFIES:	la lista di elementi di tipo 'E' collegata al nodo
	**	EFFECTS:	aggiunge un arco tra due nodi inserendo nella lista del nodo l'elemento da collegare
	**	REQUIRES: due elementi di tipo generico E diversi da null e presenti nel grafo
	**	THROWS:		se x o y non sono presenti solleva l'eccezione IllegalArgumentException (UNCHECKED), se x e y sono uguali solleva l'eccezione IllegalArgumentException (UNCHECKED)
	*/
	public void addEdge( E x, E y )
	{
		if( x.equals( y ) ) throw new IllegalArgumentException("Can not add an edge itself");
		if( searchforadd( x ) == -1 || searchforadd( y ) == -1 ) throw new IllegalArgumentException( "Can not add edge between " + x + "-" + y + ", an elements not exist" ); //controllo che x e y esistono

		elementi.get( elementi.indexOf( searchE( x ) ) ).addE( y ); //aggiungo alla lista del nodo 'x' l'elemento 'y'
		elementi.get( elementi.indexOf( searchE( y ) ) ).addE( x ); //aggiungo alla lista del nodo 'y' l'elemento 'x'
	}


	/*
	**	MODIFIES:	la lista di elementi di tipo 'E' collegata al nodo
	**	EFFECTS:	rimuovo un arco tra due nodi eliminando dalla lista del nodo l'elemento da scollegare
	**	REQUIRES: due elementi di tipo generico E diversi da null e presenti nel grafo
	**	THROWS:		se x o y non sono presenti sollevo l'eccezione IllegalArgumentException (UNCHECKED)
	*/
	public void removeEdge( E x, E y )
	{
		if( (searchforadd( x ) == -1) || (searchforadd( y ) == -1) ) throw new IllegalArgumentException( "Can not remove edge between " + x + "-" + y + ", an elements not exist" ); //controllo che x e y esistano

		elementi.get( elementi.indexOf( searchE( x ) ) ).removeE( y ); //rimuovo dalla lista del nodo 'x' l'elemento 'y'
		elementi.get( elementi.indexOf( searchE( y ) ) ).removeE( x ); //rimuovo dlla lista del nodo 'y' l'elemento 'x'
	}


	/*
	**	EFFECTS:	cerco il nodo che corrisponde all'elemento 'el' in 'elementi' cioè nel vettore, se non esiste restituisce null
	**	RETURNS:	restituisce il nodo corrispondente all'elemento el se presente, null altrimenti
	**	REQUIRES:	un elemento di tipo generico E diverso da null
	**	THROWS:		se el == null sollevo l'eccezione NullPointerException (UNCHECKED)
	*/
	private Elemento<E> searchE( E el )
	{
		if( el == null ) throw new NullPointerException( "Can not search an empty element" ); //controllo che 'el' non sia null

		int i;
		for( i = 0; i < node; i++ ) //cerco l'oggetto in cui è 'el' nel vettore
		{
			if( elementi.get(i).getE().equals( el ) )
				return elementi.get(i);
		}

		return null;
	}


	/*
	**	EFFECTS:	calcola il cammino minimo tra il nodo contenente l'elemento 'start' e il nodo contenente l'elemento 'end' utilizzando l'algoritmo BFS se esiste un cammino tra i due, altrimenti restituisce -1
	**	RETURNS:	restituisce la distanza tra i due nodi salvata nella variabile di istanza del nodo oppure -1
	**	REQUIRES: due elementi di tipo generico E diversi da null e presenti nel grafo
	**	THROWS:		se start o end non esistono sollevo l'eccezione IllegalArgumentException (UNCHECKED)
	*/
	public int min_edge( E start, E end )
	{
		if( searchforadd( start ) == -1 || searchforadd( end ) == -1 ) throw new IllegalArgumentException( "Can not search the minimum edge between " + start + "-" + end + ", an elements not exist" ); //controllo che start e end esistono

		List<Elemento<E>> queue = new ArrayList<>(); //creo una coda per aggiungere gli elementi che stanno al primo livello del nodo che visito

		Elemento<E> first = searchE( start ); //cerco l'oggetto in cui sta 'start'
		Elemento<E> last = searchE( end ); //cerco l'oggetto in cui sta 'stop'
		Elemento<E> tmp; //oggetto in cima alla coda
		Elemento<E> tmp2; //oggetto di livello 1 a tmp

		boolean trovato = false;

		first.color = "grey";
		first.depth = 0;
		queue.add( first );

		while( queue.size() > 0 && !trovato) //BFS
		{
			tmp = queue.get(0);
			for( int j = 0; j < tmp.getEdge().size() && !trovato; j++ )
			{
				tmp2 = searchE( tmp.getEdge().get(j) );
				if( tmp2.color == "white" )
				{
					tmp2.color = "grey";
					tmp2.depth = tmp.depth + 1;
					queue.add( tmp2 );
				}
				if(tmp2.getE().equals( last ) )
				{
					trovato = true;
				}
			}
			queue.remove(0);
		}

		int temp;
		if( last.depth != 0 && !start.equals( end ) ) //controllo che la distanza calcolata sia tra due elementi collegati
		{
			temp = last.depth;
		}
		else
		{
			temp = -1;
		}

		reset();
		return temp;
	}


	/*
	**	EFFECTS:	cerca il massimo tra le minime distanze tra i nodi di tutto il grafo utilizzando il metodo min_edge()
	**	RETURNS:	restituisce il valore della distanza maggiore tra tutti i cammini di tutti i nodi
	*/
	public int diameter()
	{
		int dist = 0;
		E elem1;
		E elem2;

		for( int i = 0; i < node - 1; i++ )
		{
			elem1 = elementi.get(i).getE();
			for( int j = i+1; j < node; j++ )
			{
				elem2 = elementi.get(j).getE();
				dist = dist < min_edge(elem1, elem2) ? min_edge(elem1, elem2) : dist;
			}
		}

		return dist;
	}


	/*
	**	EFFECTS:	reimposta le variabili di istanza color e depth di tutti i nodi presenti nel grafo per riportarle alla situazione iniziale
	*/
	private void reset()
	{
		Elemento<E> elem;

		for( int i = 0; i < node; i++ ) //resetto le variabili del nodo
		{
			elem = elementi.get(i);
			elem.depth = 0;
			elem.color = "white";
		}
	}


	/*
	**	EFFECTS:	cerca l'indice del nodo che ha l'elemento 'el'
	**	RETURNS:	restituisce l'indice se l'elemento è presente, -1 altrimenti
	**	REQUIRES:	un elemento di tipo generico E diverso da null
	**	THROWS:		se el == null sollevo l'eccezione NullPointerException (UNCHECKED)
	*/
	public int searchforadd( E el )
	{

		if( el == null ) throw new NullPointerException( "Can not search an empty element" );

		int i, trovato = 0;

		for( i = 0; i < node && trovato == 0; i++ ) //cerco l'indice del elemento 'el' nel vettore di nodi
		{
			if( elementi.get(i).getE().equals( el ) )
				trovato = 1;
		}

		if( trovato == 1 ) //controllo esista l'elemento
			return ( i - 1 );
		else
			return -1;
	}


	/*
	**	EFFECTS:	cerca all'interno delle liste adiacenti ai due nodi gli elementi in comune
	**	RETURNS:	restituisce il vettore di tipo generico E che contiene gli elementi in comune
	**	REQUIRES:	due elementi di tipo generico E diversi da null e presenti nel grafo
	**	THROWS:		se elem1 o elem2 non esiste o sono uguali a null lancia l'eccezione IllegalArgumentException (UNCHECKED)
	*/
	public Vector<E> nodeFriends( E elem1, E elem2 )
	{
		if( searchforadd( elem1 ) == -1 || searchforadd( elem2 ) == -1 ) throw new IllegalArgumentException( "Can not search common friends, an element not exist" );
		Vector<E> commonFriends = new Vector<>();
		Elemento<E> _elem1 = searchE( elem1 );
		Elemento<E> _elem2 = searchE( elem2 );
		E tmp1, tmp2;

		for( int i = 0; i < _elem1.getEdge().size(); i++ ) //scorro la lista di elem1
		{
			tmp1 = _elem1.getEdge().get( i ); //mi salvo l'elemento i-esimo in una variabile per allegerire la lettura del codice

			for( int j = 0; j < _elem2.getEdge().size(); j++ ) //scorro la lista di elem2
			{
				tmp2 = _elem2.getEdge().get( j ); //mi salvo l'elemento j-esimo in una variabile per allegerire la lettura del codice

				if( tmp1.equals( tmp2 ) ) //controllo se i due elementi sono uguali
				{
					commonFriends.add( tmp1 ); //aggiungo l'elemento al vettore di amici
				}
			}
		}
		return commonFriends;
	}


	/*
	**	EFFECTS:	controllo se due grafi sono uguali controllando le stringhe che rappresentano i grafi
	**	RETURNS:	restituisce true se i grafi sono uguali, false altrimenti
	**	REQUIRES: grafo di tipo E diverso da null
	**	THROWS:		se graph_p == null sollevo l'eccezione NullPointerException (UNCHECKED)
	*/
	public boolean equals( Graph<E> graph_p )
	{
		if( graph_p == null ) throw new NullPointerException("This graph is null");
		if( size() != graph_p.size() )
			return false;

		int j, i = 0;
		while( i < size() )
		{
			j = graph_p.searchforadd( elementi.get(i).getE() );
			if( j != -1 && graph_p.getGraph().get(j).getNedge() != elementi.get(i).getNedge() )
			{
				return false;
			}
			for( int k = 0; k < graph_p.getGraph().get(j).getNedge(); k++ )
			{
				if( graph_p.getGraph().get(j).getEdge().indexOf( elementi.get(i).getEdge().get( k ) ) == -1 )
				{
					return false;
				}
			}
			i++;
		}
		return true;
	}


	/*
	**	EFFECTS:	creo la stringa che rappresenta il grafo
	**	RETURNS: 	restituisce la stringa creata
	*/
	public String toString()
	{
		String r = "";
		for( int i = 0; i < node; i++ )
		{
			r += elementi.get(i).toString() + "\n";
		}
		return r;
	}



	/***********************************
	** VISUALIZZAZIONE GRAFO ONLINE **
	************************************/


	/*
	**	EFFECTS:	crea la stringa con i nodi e gli archi del grafo per utilizzarla come url per creare il grafo online
	**	RETURNS:	restituisce la stringa che rappresenta l'url
	*/
	private String buildUrl()
	{
		int i=0, j = 0;

		String base_url = "http://graphviewer.altervista.org/?nodes=";


		//mi stampa nell'url i nodi
		for( i = 0; i < node-1; i++ )
		{
			base_url += elementi.get(i).getE().toString()+",";
		}
		//aggiungo l'ultimo nodo
		base_url += elementi.get(i).getE().toString();

		boolean inserito_edges = false;
		boolean inserito_primo_n_edges = false;

		for ( i = 0 ; i < size() ; i++ )
		{
				Elemento<E> current = elementi.get(i);
				if ( current.getNedge() != 0 && !inserito_edges )
				{
					inserito_edges =  true;
					base_url += "&edges=";
				}
				if ( current.getNedge() != 0 && inserito_primo_n_edges )
					base_url += ",";

				if ( current.getNedge() != 0 )
				{
					base_url += current.getE().toString() + ":" ;
					inserito_primo_n_edges = true;

					for ( j = 0 ; j < current.getNedge() ; j++)
					{
						base_url += current.getEdge().get(j).toString();
						if ( j  != current.getNedge() - 1 )
							base_url += "-";
					}
				}
			//aggingo all'url gli archi

			}
		return base_url;
		}



	/*
	**	EFFECTS:	apre una pagina del browser verso l'indirizzo della url
	*/
	private void openWebpage( URL url )
	{
		Desktop desktop = Desktop.isDesktopSupported() ? Desktop.getDesktop() : null;
		if (desktop != null && desktop.isSupported( Desktop.Action.BROWSE ) )
		{
					try
					{
							desktop.browse( url.toURI() );
					}
					catch( Exception e )
					{
							e.printStackTrace();
							System.out.println("impossible to open page on browser");
							System.exit(-1);
					}
		}
	}


	/*
	**	EFFECTS:	lancia il browser per visualizzare il grafo
	*/
	public void graphViewer()
	{
		try
		{
			String s = buildUrl();
			URL url = new URL(s);
			openWebpage(url);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}



}
