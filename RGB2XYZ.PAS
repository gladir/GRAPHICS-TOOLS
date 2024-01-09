{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program RGB2XYZ;

Var
 R,G,B:Byte;
 Err:Word;
 R1,G1,B1,X,Y,Z:Real;

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
  WriteLn('RGB2XYZ : Cette commande permet de convertir les couleurs ',
                'RGB (RVB) en couleur XYZ.');
  WriteLn;
  WriteLn('Syntaxe : RGB2XYZ r g b');
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
  R1:=0.0039215*R; { 0..1 }
  G1:=0.0039215*G; { 0..1 }
  B1:=0.0039215*B; { 0..1 }
  X:=0.431*R1+0.342*G1+0.178*B1;
  Y:=0.222*R1+0.707*G1+0.071*B1;
  Z:=0.020*R1+0.130*G1+0.939*B1;

  WriteLn('X = ',X:1:3);
  WriteLn('Y = ',Y:1:3);
  WriteLn('Z = ',Z:1:3);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.

