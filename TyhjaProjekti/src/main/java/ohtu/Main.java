package ohtu;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.io.IOUtils;
 
public class Main {
 
    public static void main(String[] args) throws IOException {
        String studentNr = "13710688";
        if ( args.length>0) {
            studentNr = args[0];
        }
 
        String url = "http://ohtustats.herokuapp.com/opiskelija/"+studentNr+".json";
 
        HttpClient client = new HttpClient();
        GetMethod method = new GetMethod(url);
        client.executeMethod(method);
 
        InputStream stream =  method.getResponseBodyAsStream();
 
        String bodyText = IOUtils.toString(stream);
 
        System.out.println("json-muotoinen data:");
        System.out.println( bodyText );
 
        Gson mapper = new Gson();
        Palautukset palautukset = mapper.fromJson(bodyText, Palautukset.class);
        
        Palautus p = palautukset.getPalautukset().get(0);
        Palautus minip = palautukset.getPalautukset().get(3);
        
        int yhteensä = 0;
        
        System.out.println(p.getEtunimi() + " " + p.getSukunimi() + " opiskelijanumero " + p.getOpiskelijanumero()
                    + "\n");
        System.out.println("miniprojekti: " + minip.getTehtavat() + "\n");
        for (Palautus palautus : palautukset.getPalautukset()) {
            if(palautus.getViikko() > 7) continue;
            System.out.println("viikko " +palautus.getViikko() + ": " + palautus.getTehtavia() + " tehtävää "
                    + palautus.getTehtavat() + " aikaa kului " + palautus.getTunteja() +" tuntia");
            yhteensä += palautus.getTunteja();
        }
        
        System.out.println("Aikaa kului yhteensä " + yhteensä +" tuntia");
 
    }
}