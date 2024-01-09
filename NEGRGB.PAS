{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program NEGRGB;

Var
 R,G,B:Byte;
 Err:Word;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('NEGRGB : Cette commande permet de retourner les negations ',
                'des couleurs RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : NEGRGB r g b');
  WriteLn;
  WriteLn(' r     Ce parametre permet d''indiquer le rouge entre 0 et 255');
  WriteLn(' g     Ce parametre permet d''indiquer le vert entre 0 et 255');
  WriteLn(' b     Ce parametre permet d''indiquer le bleu entre 0 et 255');
 End
  Else
 If ParamCount=3 Then Begin
  Val(ParamStr(1),R,Err);
  If Err>0Then Begin
   WriteLn('Valeur rouge invalide');
   Halt;
  End;
  Val(ParamStr(2),G,Err);
  If Err>0Then Begin
   WriteLn('Valeur vert invalide');
   Halt;
  End;
  Val(ParamStr(3),B,Err);
  If Err>0Then Begin
   WriteLn('Valeur bleu invalide');
   Halt;
  End;
  WriteLn('R = ',255-R);
  WriteLn('G = ',255-G);
  WriteLn('B = ',255-B);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.


