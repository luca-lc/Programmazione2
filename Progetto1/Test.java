public class Test
{
	public static void main (String[] args)
	{
		boolean displayGraphOnline = true; //variabile che permette di stampare il grafo sul browser se true, se false viene visualizzato in modalità testo
		System.out.println("Ecco qui il grafo\n\n");

		Graph<String> graph = new MyGraph<>();
		Graph<Integer> graph_num = new MyGraph<>();

		graph.addNode("Pippo");
		graph.addNode("Pluto");
		graph.addNode("Paperino");
		graph.addNode("Paperina");
		graph.addNode("Qui");
		graph.addNode("Quo");
		graph.addNode("Qua");
		graph.addNode("Topolino");
		graph.addNode("Minnie");
		graph.addEdge("Pippo", "Pluto");
		graph.addEdge("Pluto", "Paperino");
		graph.addEdge("Paperino", "Paperina");
		graph.addEdge("Paperina", "Qui");
		graph.addEdge("Qui", "Quo");
		graph.addEdge("Quo", "Qua");
		graph.addEdge("Qua", "Topolino");
		graph.addEdge("Topolino", "Minnie");
		graph.addEdge("Minnie", "Pippo");
		graph.addEdge("Topolino", "Paperina");
		graph.addEdge("Paperina", "Minnie");
		graph.addEdge("Minnie", "Paperino");
		graph.addEdge("Qui", "Qua");

		//graph.removeNode("Topolino");
		if( displayGraphOnline ){
			try{
				graph.graphViewer();
			}
			catch( Exception e ){
				System.out.println( e );
			}
		}
		else{
			System.out.println(graph.toString());
			System.out.println("Cammino minimo Pluto->Quo: " + graph.min_edge("Pluto", "Quo"));
			System.out.println("Diametro del grafo: " + graph.diameter() );
			System.out.println( "I nodi in comune a Paperina e Minnie sono:" + graph.nodeFriends( "Paperina", "Minnie" ).toString() + "\n\n" );
		}
		graph.removeEdge("Paperino", "Pluto");
		graph.removeEdge("Paperina", "Qui");
		graph.removeEdge("Qua", "Topolino");
		if( displayGraphOnline ){
			try{
				graph.graphViewer();
			}
			catch( Exception e ){
				System.out.println( e );
			}
		}
		else{
			System.out.println("Modificando: \n" + graph.toString());
			System.out.println("Cammino minimo Pluto->Topolino: " + graph.min_edge("Pluto", "Topolino"));
			System.out.println("Cammino minimo Pluto->Qua: " + graph.min_edge("Pluto", "Qua"));
			System.out.println("Diametro del grafo: " + graph.diameter() );
			System.out.println( "I nodi in comune a Topolino e Paperino sono:" + graph.nodeFriends( "Topolino", "Paperino" ).toString() + "\n\n" );
		}


		/**********************************************
		* CODICE CHE SOLLEVA ECCEZIONI O CASI LIMITE *
		***********************************************/

		// graph.addEdge("Pippo", "Pippo"); //aggiunta del nodo nella sua lista
		// graph.removeNode("ZioPaperone"); //rimozione di nodo inesistente
		// graph.removeEdge("Pippo", "Qui"); //rimozione di arco inesistente
		// graph.addNode("Minnie"); //aggiunta di nodo già esistente
		// graph.addEdge("ZioPaperone", "Paperino"); //aggiunta di arco tra un elemento esistente ed uno inesistente
		// graph.addNode(null); //aggiunta di un nodo vuoto
		// graph.min_edge("ZioPaperone","Bruto"); //cammino minimo tra due elementi insesistenti
		// graph_num.diameter(); //diametro di un grafo vuoto


	}


}
