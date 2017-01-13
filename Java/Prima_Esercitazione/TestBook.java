public class TestBook 
{
    // Test
    
    public static void main (String[ ] args) 
    {
        Book myBk1 = new MyBook("autore1", "titolo1", "editore1", 1900);
        assert myBk1.getTitle( ).equals("titolo1");

        Book myBk2 = new MyBook("autore2", "titolo2", "editore1", 2000);
        assert myBk1.samePublisher(myBk2);
        
        Book myBk3 = new MyBook("autore1", "titolo1", "editore1", 1900);
        assert myBk3.equals(myBk1);
    }
}