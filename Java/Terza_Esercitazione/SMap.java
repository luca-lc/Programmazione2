import java.util.List;
public interface SMap<K,V> {

	// Overview : Tipo modificabile delle funzioni parziali con domino K e codominio V
    // 		      definite solo su un sottoinsieme finito di K
	// Typical Element : funzione parziale f: K -> V , f(k) = v

	//che associa il valore value alla chiave key, 
	//e restituisce il valore precedentemente associato a key se questo esisteva, e null altrimenti;
	public V put(K key, V value);
	// MODIFIES : f
	// EFFECTS  : se key esiste nel dominio di f restituisce il valore ed associa a key value, 
	//			  altrimenti aggiunge una nuova chiave key, gli associa value e ritorna null
	// REQUIRES : key, value | key ≠ null && value ≠ null
	// THROWS	: NullPointerException se key == null OR value == null

	//che restituisce il valore associato alla chiave key se questo esiste, e null altrimenti;
	public V get(K key);
	// EFFECTS  : restituisce il valore associato alla chiave key se questo esiste, null altrimenti
	// REQUIRES : key ≠ null
	// THROWS   : NullPointerException

	// che restituisce una lista delle chiavi che hanno associato un valore.
	public List<K> getKeys();
	// EFFECTS  : restituisce gli elementi definiti del dominio K

	public String toString();
}