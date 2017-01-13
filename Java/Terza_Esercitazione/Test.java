public class Test {
	public static void main (String[] args) {
		SMap<Integer, String> test = new TwoListSMap<Integer, String>();

		test.put(new Integer (1) , "uno");
		test.put(new Integer (30), "trenta");

		test.get(new Integer (30) );

		System.out.println( test.getKeys().toString() );
		System.out.println( test.toString() );
	}
}