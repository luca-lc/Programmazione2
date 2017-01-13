public interface Library 
{
    // Restituisce l'elenco dei titoli con lo stesso autore aut
    public String[] getByAuthor(String aut);
    
    // Restituisce l'elenco dei libri che hanno titolo tit
    public String[] getByTitle(String tit);
    
    
    // Restituisce l'elenco dei libri pubblicati da pub
    public String[] getByPublisher(String pub);
    
    // Restituisce l'elenco dei libri pubblicati nell'anno y
    public String[] getByYear(int y);
    

    // Restituisce l'elenco degli autori che hanno pubblicato per pub
    public String[] getAuthorByPublisher(String pub);
    
    
    // Rimuove tutti i libri identici a b dalla libreria, lancia un'eccezione
    // se il libro non e' presente
    public void remove(Book b);
    
    // inserisce il libro b nella libreria 
    public void insert(Book b);
   
}