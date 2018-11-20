import java.util.*;
import java.io.*;

class Read {
    public static void main(String[]args){
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter text file name : ");
        String fileName = sc.nextLine();
        
        System.out.println();
        
        File textFile = new File(fileName);
        InputStream fis = null;
        BufferedReader buffRead = null;
        InputStreamReader inputSR = null;
        try{
            //For Read File
            fis = new FileInputStream(textFile);
            inputSR = new InputStreamReader(fis);
            buffRead = new BufferedReader(inputSR);
            Lexical re = new Lexical(buffRead);
            re.yylex();
        }catch(IOException io){
            io.printStackTrace();
        }
    }
}