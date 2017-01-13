import java.util.*;

public interface Graph<E>
{

	/*
	**	OVERVIEW: tipo modificabile di grafo contenente generici oggetti di tipo Elemento<E>
	**	TYPICAL-ELEMENT:	grafo non orientato
	*/


	/*
	**	RETURNS: restituisce la quantità dei nodi presenti nel grafo
	*/
	public int size();


	/*
	**	EFFECTS: copia i nodi in un vettore
	**	RETURNS: il vettore contenente i nodi
	*/
	public Vector<Elemento<E>> getGraph();


	/*
	**	EFFECTS:	aggiunge i nodi al grafo e incrementa la variabile che li conta
	**	MODIFIES: il grafo modificando il vettore di nodi
	**	REQUIRES:	un elemento di tipo generico E
	*/
	public void addNode( E elem );


	/*
	**	EFFECTS:	rimuove il nodo, contenente elem, dal grafo e decrementa la variabile che li conta
	**	MODIFIES:	il grafo modificando il vettore di nodi
	**	REQUIRES:	un elemento di tipo generico E
	*/
	public void removeNode( E elem );


	/*
	**	EFFECTS:	aggiunge un arco tra due nodi
	**	MODIFIES: modifica il grafo creando un collegamento tra i nodi contenenti elem1 ed elem2
	**	REQUIRES:	due elementi di tipo generico E
	*/
	public void addEdge(E elem1, E elem2 );


	/*
	**	EFFECTS: 	rimuove un arco tra i nodi
	**	MODIFIES: modifica il grafo eliminando il collegamento tra i nodi contenenti elem1 ed elem2
	**	REQUIRES:	due elementi di tipo generico E
	*/
	public void removeEdge(E elem1, E elem2 );


	/*
	**	EFFECTS: 	calcola la distanza minima tra due nodi del grafo
	**	RETURNS: 	restituisce la distanza minima tra il nodo di 'elem1' e quello di 'elem2'
	**	REQUIRES:	due elementi di tipo generico E
	*/
	public int min_edge( E start, E end );


	/*
	**	EFFECTS: calcola il diametro del grafo
	**	RETURNS: il massimo dei cammini minimi tra i nodi del grafo
	*/
	public int diameter();


	/*
	**	EFFETCS:	cerca gli amici in comune a due elementi
	**	RETURNS:	il vettore con gli elementi in comune a due nodi
	**	REQUIRES:	due elementi di tipo generico E
	*/
	public Vector<E> nodeFriends( E elem1, E elem2 );


	/*
	**	EFFECTS: 	controlla se due grafi sono uguali
	**	RETURNS:	true se sono uguali, false altrimenti
	**	REQUIRES:	un grafo di tipo generico E
	*/
	public boolean equals( Graph<E> graph_p );


	/*
	**	EFFECTS: costruisce una stringa che rappresenta il grafo
	**	RETURNS: la stringa che è stata costruita
	*/
	public String toString();


	/*
	**	EFFECTS: visualizza il grafo utilizzando il browser
	*/
	public void graphViewer();


	/*
	**	EFFECTS:	cerca l'indice del nodo che ha l'elemento 'el'
	**	RETURNS:	l'indice del nodo
	*/
	public int searchforadd( E el );


}
