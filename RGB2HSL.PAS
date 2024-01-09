{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program RGB2HSL;

Var
 R,G,B:Byte;
 Err:Word;
 CMax,CMin,Delta,R1,G1,B1,H,S,L:Real;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function Min(A,B,C:Real):Real;
Var
 T:Real;
Begin
 T:=A;
 If A<T Then T:=A;
 If B<T Then T:=B;
 If C<T Then T:=C;
 Min:=T;
End;

Function Max(A,B,C:Real):Real;
Var
 T:Real;
Begin
 T:=A;
 If A>T Then T:=A;
 If B>T Then T:=B;
 If C>T Then T:=C;
 Max:=T;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('RGB2HSL : Cette commande permet de convertir les couleurs ',
                'RGB (RVB) en couleur HSL.');
  WriteLn;
  WriteLn('Syntaxe : RGB2HSL r g b');
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
  R1:=R/255;
  G1:=G/255;
  B1:=B/255;
  Cmax:=Max(r1, g1, b1);
  Cmin:=Min(r1, g1, b1);
  L:=(Cmax+Cmin)/2;
  If Cmax = Cmin Then Begin
   H:=0;
   S:=0;
  End
   Else
  Begin
   Delta := Cmax - Cmin;
   If L<0.5 Then S:=Delta/(Cmax+Cmin)
            Else S:=Delta/(2-Cmax-Cmin);
   If R1=Cmax Then H:=(g1-b1)/Delta Else
   If G1=Cmax Then H:=2+(B1-R1)/Delta
              Else H:=4+(R1-G1)/Delta;
   H:=H/6;
   If H<0 Then H:=H+1
  End;
  WriteLn('H = ',H:1:3);
  WriteLn('S = ',S:1:3);
  WriteLn('L = ',L:1:3);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.

