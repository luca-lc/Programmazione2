public class TestLibrary {
    // Test
    public static void main (String[ ] args) {
        Book myBk1 = new MyBook("autore1", "titolo1", "editore1", 1900);
        Book myBk2 = new MyBook("autore2", "titolo2", "editore1", 2000);
 
        Library myL = new MyLibrary();
        myL.insert(myBk1);
        myL.insert(myBk2);
        assert ((myL.getAuthorByPublisher("editore1"))[0]).equals("autore2");

        //System.out.println( (myL.getAuthorByPublisher("editore1"))[0] );

        try {
            myL.remove(myBk2);
            myL.remove(myBk2);
        }
        catch (Exception exc) {
            System.out.println("Ben fatto!");
            System.out.println(exc);
        }
        /*
         la correttezza del frammento dipende dalla specifica
         implementazione dell'ordine di estrazione dalla libreria
        */
        
        
         IndexedBook myBk3 = new MyIndexedBook("autore3", "titolo3", "editore3", 1966, "fiction");
         myL.insert(myBk3);
         assert myBk3.getGenre().equals("fiction");
         
        /*
         per verificare la versione estesa di book
         */
        
        
         //Book[] test = {myBk1,myBk2,myBk3}; 
         IndexedLibrary myIL = new MyIndexedLibrary();
         //myIL.insert(myBk1);
         //myIL.insert(myBk2);
         myIL.insert(myBk3);

         assert myIL.getByIndex(1).equals(myBk3);

         
         
        /*
         per verificare la versione estesa di library;
         la correttezza del frammento dipende dalla specifica
         implementazione dell'indicizzazione
        */


        System.out.println( myBk3.equals(myBk3) );
    }
}