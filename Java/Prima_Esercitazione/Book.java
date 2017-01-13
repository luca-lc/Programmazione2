public interface Book 
{
    // Restituisce la stringa che corrisponde al nome dell'autore del libro
    public String getAuthor( );
   
    // Restituisce la stringa che corrisponde al titolo del libro
    public String getTitle( );
  
    // Restituisce la stringa che corrisponde all'editore del libro
    public String getPublisher( );
    
    // Restituisce l'intero che corrisponde all'anno di pubblicazione del libro
    public int getYear( );
    
    // Restituisce true se l'oggetto b ha lo stesso autore di this
    public boolean sameAuthor(Book b);
   
    // Restituisce true se l'oggetto b ha lo stesso editore di this
    public boolean samePublisher(Book b);
    
    // Restituisce true se l'oggetto b ha lo stesso anno di pubblicazione di this
    public boolean sameYear(Book b);

    public boolean equals( Book b );

    public String toString( );
    
}
