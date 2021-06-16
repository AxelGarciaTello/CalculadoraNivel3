package ejemplo_hoc2;
import java_cup.runtime.*;
import java.io.Reader;
%% /* inicio de declaraciones JFlex */
%class AnalizadorLexico
%line	/* Se habilita el contador de lineas. Variable yyline, de tipo integer */
%column	/* Se habilita el contador de columnas. Varible yycolumn, de tipo integer */
%char	/* Se habilita el contador de caracteres. Variable yychar, de tipo long */
%cup	/* Se habilita la compatibilidad con java cup */

/* el codigo entre %{ y %} se copia tal cual dentro de la clase del analizador léxico */
%{
/* Se crean los objetos Symbol para ser utilizados durante la sintésis de los atributos
   Symbol está especificado en java.cup.Symbol*/
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/* Hacemos algunas definiciones regulares, o macro definiciones */
LetraMin = [a-z]
Digito = [0-9]
%% /* Ahora van las expresiones regulares */
"PI"                    { return symbol(AnalizadorSintacticoSym.PI, new Float("3.14159")); }
"E"                     { return symbol(AnalizadorSintacticoSym.E, new Float("2.71828")); }
"GAMMA"                 { return symbol(AnalizadorSintacticoSym.GAMMA, new Float("0.57721")); }
"DEG"                   { return symbol(AnalizadorSintacticoSym.DEG, new Float("57.29577")); }
"PHI"                   { return symbol(AnalizadorSintacticoSym.PHI, new Float("1.61803")); }
"sin"                   { return symbol(AnalizadorSintacticoSym.SIN); }
"cos"                   { return symbol(AnalizadorSintacticoSym.COS); }
"atan"                  { return symbol(AnalizadorSintacticoSym.ATAN); }
"exp"                   { return symbol(AnalizadorSintacticoSym.EXP); }
"log"                   { return symbol(AnalizadorSintacticoSym.LOG); }
"log10"                 { return symbol(AnalizadorSintacticoSym.LOG10); }
"sqrt"                  { return symbol(AnalizadorSintacticoSym.SQRT); }
"int"                   { return symbol(AnalizadorSintacticoSym.INT); }
"abs"                   { return symbol(AnalizadorSintacticoSym.ABS); }
[ \t]+                  { ;}
"\n"			{ return symbol(AnalizadorSintacticoSym.Enter); }
{Digito}+(\.{Digito}+)?	{ return symbol(AnalizadorSintacticoSym.NUM, new Float(yytext())); }
"="			{ return symbol(AnalizadorSintacticoSym.OpAsig); }
"/"			{ return symbol(AnalizadorSintacticoSym.OpDiv); }
"*"			{ return symbol(AnalizadorSintacticoSym.OpProd); }
"-"			{ return symbol(AnalizadorSintacticoSym.OpResta); }
"+"			{ return symbol(AnalizadorSintacticoSym.OpSuma); }
")"			{ return symbol(AnalizadorSintacticoSym.ParDer); }
"("			{ return symbol(AnalizadorSintacticoSym.ParIzq); }
"^"                     { return symbol(AnalizadorSintacticoSym.OpPot); }
{LetraMin} 		{int IndVar; IndVar=(int) (yytext().charAt(0)) - (int)'a'; return symbol(AnalizadorSintacticoSym.VAR, new Integer(IndVar)); }
.			{ return symbol(AnalizadorSintacticoSym.error); }
