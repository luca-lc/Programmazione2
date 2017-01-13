 import java.util.List;
 import java.util.ArrayList;
 public class TwoListSMap<K,V> implements SMap<K,V> {

 	// Overview : Classe di tipo modificabile che implementa SMap, funzione parziale tra il dominio sottoinsieme di K 
 	//			  e il codominio sottoinsieme V
 	

 	// AF : f : K -> V | f(keys.get(i)) = f(values.get(i))

 	// IR : keys ≠ null 
 	//		&& values ≠ null 
 	//		&& key.size() == dim
 	//		&& values.size() == dim
 	// 	&& for all i,j . 0 ≤ i,j < dim => (keys.get(i) == keys.get(j)) ==> (values.get(i) == values.get(j))
 	// 	&& for all i . 0 ≤ i,j ≤ dim && i ≠ j => keys.get(i) ≠ keys.get(j)

 	private List<K> keys;
   	private List<V> values;
   	private int dim;

   	public TwoListSMap() {
   		dim = 0;
   		keys = new ArrayList<K>();
   		values = new ArrayList<V>();
   	}


   	public V put(K key, V value) {
   		if ( key == null || value == null ) throw new NullPointerException("Mi hai passato parametri uguali a null");

   		int i = keys.indexOf(key);

   		if ( i < 0 ) {
   			keys.add(key);
   			values.add(value);
   			dim ++;
   			return null;
   		}
   		else {
   			V temp = values.get(i);
   			values.set(i, value);
   			return temp;
   		}
   	}

	public V get(K key) {
		if ( key == null ) throw new NullPointerException("Mi hai passato una chiave null");
		int i = keys.indexOf(key);
		return values.get(i);

	}

	public List<K> getKeys() {
		List<K> temp = new ArrayList<K>();
		for (int i = 0 ; i < dim; i++) {
			temp.add(keys.get(i));
		} 
		return temp;
	}


	public String toString() {
		String temp = new String();
		for ( int i = 0; i < dim ; i++ ) {
			temp += keys.get(i) + " --> " + values.get(i) + "\n" ; 
		}

		return temp;
	} 








 }