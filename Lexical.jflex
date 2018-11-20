import java.util.List;
import java.util.ArrayList;

%%

%class Lexical
%public
%standalone
%unicode

%{
    List<String> symbolTable = new ArrayList<String>();
%}

InputCharacter = [^\n\r]
LineTerminator = \n|\r|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]
Operators = "+"|"-"|"*"|"/"|"="|">"|">="|"<"|"<="|"=="|"++"|"--"
SomePunctuation = "("|")"|";"
Keywords = "if"|"then"|"else"|"endif"|"while"|"do"|"endwhile"|"print"|"newline"|"read"
DecIntegerLiteral = 0 | [1-9][0-9]*
Identifiers = [A-Za-z][A-Za-z0-9]*
StringWord = \"{InputCharacter}*\"
Comments = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}

%%

<YYINITIAL>
{
    {Operators}
    {
        System.out.println("OPERATORS: "+yytext());
    }
    {SomePunctuation}
    {   
        if(yytext().equals(";")){
            System.out.println("SEMICOLON: "+yytext());
        }else{
            System.out.println("PARENTHESES: "+yytext());
        }
    }
    {Keywords}
    {
        System.out.println("KEYWORD: "+yytext());
    }
    {DecIntegerLiteral}
    {
        System.out.println("DECIMAL INTEGER: "+yytext());
    }
    {Identifiers}
    {
        String newIdentifier = yytext();
        if(symbolTable.size() == 0){
            System.out.println("NEW IDENTIFIER: "+newIdentifier);
            symbolTable.add(newIdentifier);
        }else{
            boolean find = symbolTable.contains(newIdentifier);
            if(find){
                System.out.println("Indetifier "+newIdentifier+" already in symbol table");
            }else{
                System.out.println("NEW IDENTIFIER: "+newIdentifier);
                symbolTable.add(newIdentifier);
            }
        }
    }
    {StringWord}
    {
        System.out.println("STRING: "+yytext());
    }
    {Comments}
    {}
    {WhiteSpace}
    {}
    [^]|\n
    {
        System.out.println("ERROR: "+yytext());
        System.exit(0);
    }
}