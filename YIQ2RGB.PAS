{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program YIQ2RGB;

Var
 R,G,B:Byte;
 Err:Word;
 R1,G1,B1,Y,I,Q:Real;

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
  WriteLn('YIQ2RGB : Cette commande permet de convertir les couleurs ',
                'YIQ en couleur RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : YIQ2RGB y i q');
  WriteLn;
  WriteLn(' y     Ce parametre permet d''indiquer Y');
  WriteLn(' i     Ce parametre permet d''indiquer I');
  WriteLn(' q     Ce parametre permet d''indiquer Q');
 End
  Else
 If ParamCount=3 Then Begin
  Val(ParamStr(1),Y,Err);
  If Err>0Then Begin
   WriteLn('Valeur Y invalide');
   Halt;
  End;
  Val(ParamStr(2),I,Err);
  If Err>0Then Begin
   WriteLn('Valeur I invalide');
   Halt;
  End;
  Val(ParamStr(3),Q,Err);
  If Err>0Then Begin
   WriteLn('Valeur Q invalide');
   Halt;
  End;
  R1:=(Y+(0.956*I)+(0.621*Q));
  G1:=(Y-(0.272*I)-(0.647*Q));
  B1:=(Y-(1.105*I)+(1.702*Q));
  R:=Byte(Trunc(R1*256));
  G:=Byte(Trunc(G1*256));
  B:=Byte(Trunc(B1*256));
  WriteLn('R = ',R);
  WriteLn('G = ',G);
  WriteLn('B = ',B);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.