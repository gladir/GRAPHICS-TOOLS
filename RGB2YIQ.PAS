{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program RGB2YIQ;

Var
 R,G,B:Byte;
 Err:Word;
 Y,I,Q:Real;

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
  WriteLn('RGB2YIQ : Cette commande permet de convertir les couleurs ',
                'RGB (RVB) en couleur YIQ.');
  WriteLn;
  WriteLn('Syntaxe : RGB2YIQ r g b');
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
  Y:=((0.299*R)+(0.587*G)+(0.114*B))/256;
  I:=((0.596*R)-(0.274*G)-(0.322*B))/256;
  Q:=((0.212*R)-(0.523*G)+(0.311*B))/256;
  WriteLn('Y = ',Y:1:3);
  WriteLn('I = ',I:1:3);
  WriteLn('Q = ',Q:1:3);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.
