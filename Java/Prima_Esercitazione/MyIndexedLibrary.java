public class MyIndexedLibrary extends MyLibrary implements IndexedLibrary {
    private static int codice = 1;
    
   
    public MyIndexedLibrary( )
	{
		super();
	}

    public MyIndexedLibrary(Book[] start) {
        if (start == null) throw new NullPointerException();

        for(int i = 0; i < start.length; i++)
            insert(new MyIndexedBook(start[i], codice++, "undefined"));
    }

                   
    public Book getByIndex( int index ) {
        if (index <= 0) throw new IllegalArgumentException();
                    
        for(Node tmp = n; tmp != null; tmp = tmp.next)
            if ( ( (IndexedBook) tmp.bk).getIndex() == index)
                return tmp.bk;
                
        return null;
    }
    
    public void remove(int index) {
     	
		Node precc = null;
		Node corr;
		boolean found = false;
		for( corr = n; corr!= null && !found; precc = corr, corr = corr.next ) {
			if( ( (IndexedBook) corr.bk).getIndex() == index ) {
					if( precc == null )
					{
						n = n.next;
						found = true;
					}
					else
					{
						precc.next = corr.next;
						found = true;
					}
				}
			}
    }
 }