{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program HSI2RGB;

Var
 R,G,B:Byte;
 Err:Word;
 R1,G1,B1,T,H,S,I:Real;

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
  WriteLn('HSI2RGB : Cette commande permet de convertir les couleurs ',
                'HSI en couleur RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : HSI2RGB h s i');
  WriteLn;
  WriteLn(' h     Ce parametre permet d''indiquer H');
  WriteLn(' s     Ce parametre permet d''indiquer S');
  WriteLn(' i     Ce parametre permet d''indiquer I');
 End
  Else
 If ParamCount=3 Then Begin
  Val(ParamStr(1),H,Err);
  If Err>0Then Begin
   WriteLn('Valeur H invalide');
   Halt;
  End;
  Val(ParamStr(2),S,Err);
  If Err>0Then Begin
   WriteLn('Valeur S invalide');
   Halt;
  End;
  Val(ParamStr(3),I,Err);
  If Err>0Then Begin
   WriteLn('Valeur I invalide');
   Halt;
  End;
  T:=H;
  R1:=1+S*Sin(t-2*pi/3);
  G1:=1+S*Sin(t);
  B1:=1+S*Sin(t+2*pi/3);
  T:=255.999*i/2;
  B:=Byte(Trunc(B1*T));
  G:=Byte(Trunc(G1*T));
  R:=Byte(Trunc(R1*T));
  WriteLn('R = ',R);
  WriteLn('G = ',G);
  WriteLn('B = ',B);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.
