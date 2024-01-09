{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program RGB2HSV;

Var
 R,G,B:Byte;
 Err:Word;
 M,R1,G1,B1,H,S,V:Real;

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
  WriteLn('RGB2HSV : Cette commande permet de convertir les couleurs ',
                'RGB (RVB) en couleur HSV.');
  WriteLn;
  WriteLn('Syntaxe : RGB2HSV r g b');
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
  R1:=R/256;
  G1:=G/256;
  B1:=B/256;
  If(R1>G1)Then Begin
   If(R1>B1)Then v:=R1
            Else v:=B1;
   If(G1<B1)Then m:=G1
            Else m:=B1;
  End
   Else
  Begin
   If(G1>B1)Then v:=G1
            Else v:=B1;
   If(R1<B1)Then m:=R1
            Else m:=B1
  End;
   {En fait V:=Max(r,g,b) M:=Min(r,g,b)}
  If V<>0Then S:=(V-M)/V
         Else S:=0;      {Calcul saturation}
  If S<>0Then Begin      {Calcul de l'angle}
   If(V=R1)Then If(M=G1)Then H:=5+(V-B1)/(V-M)
                        Else H:=1-(V-G1)/(V-M)
   Else If(V=G1)Then If(M=B1)Then H:=1+(v-R1)/(V-M)
                             Else H:=3-(v-B1)/(V-M)
   Else If(V=B1)Then If(M=R1)Then H:=3+(v-G1)/(V-M)
                             Else H:=5-(v-R1)/(V-M);
   H:=H*60;
   If H=360Then H:=0;
  End
   Else
  Begin
    {Noir}
   H:=0;
   S:=0;
  End;
  WriteLn('H = ',H:1:3);
  WriteLn('S = ',S:1:3);
  WriteLn('V = ',V:1:3);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.


