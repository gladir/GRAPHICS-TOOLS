{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program HSL2RGB;

Var
 Zone:Byte;
 Err:Word;
 M,X,HH,C,R,G,B,F,T,H,S,L:Real;

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
  WriteLn('HSL2RGB : Cette commande permet de convertir les couleurs ',
                'HSL en couleur RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : HSL2RGB h s l');
  WriteLn;
  WriteLn(' h     Ce parametre permet d''indiquer H(ue)');
  WriteLn(' s     Ce parametre permet d''indiquer S(aturation)');
  WriteLn(' l     Ce parametre permet d''indiquer L(ightness)');
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
  Val(ParamStr(3),L,Err);
  If Err>0Then Begin
   WriteLn('Valeur L invalide');
   Halt;
  End;
  If H<0 Then H:=0;
  If S<0 Then S:=0;
  If L<0 Then L:=0;
  If H>=360 Then H:=359;
  If S>100 Then S:=100;
  If L>100 Then L:=100;
  S:=S/100;
  L:=L/100;
  C:=(1-Abs(2*l-1))*S;
  hh:=h/60;
  X:=C*(1-abs((Trunc(hh) mod 2)-1));
  R:=0;
  G:=0;
  B:=0;
  If((hh >= 0) and (hh<1))Then Begin
   R:=C;
   G:=X;
  End
   Else
  If((hh>=1)and(hh<2))Then Begin
   R:=X;
   G:=C;
  End
   Else
  If((hh>=2)and(hh<3))Then Begin
   G:=C;
   B:=X;
  End
   Else
  If((hh>=3) and (hh<4))Then Begin
   G:=X;
   B:=C;
  End
   Else
  If((hh>=4)and(hh<5))Then Begin
   R:=X;
   B:=C;
  End
   Else
  Begin
   R:=C;
   B:=X;
  End;
  M:=L-C/2;
  R:=R+M;
  G:=G+M;
  B:=B+M;
  WriteLn('R = ',R*255:1:0);
  WriteLn('G = ',G*255:1:0);
  WriteLn('B = ',B*255:1:0);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.

