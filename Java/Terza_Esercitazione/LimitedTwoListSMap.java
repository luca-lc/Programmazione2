public class LimitedTwoListSMap<K,V> extends TwoListSMap {

	private int stop;

	public LimitedTwoListSMap(int n) {
		super();
		stop = n;
	}

	public V put(K key, V value) {
   		if (super.size() == stop ) throw new Exception();

   		super.put(key, value);


   	}
}