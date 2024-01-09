{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program XYZ2RGB;

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
  WriteLn('XYZ2RGB : Cette commande permet de convertir les couleurs ',
                'XYZ en couleur RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : XYZ2RGB x y z');
  WriteLn;
  WriteLn(' x     Ce parametre permet d''indiquer coordonnee reel');
  WriteLn(' y     Ce parametre permet d''indiquer coordonnee reel');
  WriteLn(' z     Ce parametre permet d''indiquer coordonnee reel');
 End
  Else
 If ParamCount=3 Then Begin
  Val(ParamStr(1),X,Err);
  If Err>0Then Begin
   WriteLn('Valeur X invalide');
   Halt;
  End;
  Val(ParamStr(2),Y,Err);
  If Err>0Then Begin
   WriteLn('Valeur Y invalide');
   Halt;
  End;
  Val(ParamStr(3),Z,Err);
  If Err>0Then Begin
   WriteLn('Valeur Z invalide');
   Halt;
  End;
  R:=Byte(Trunc((3.063*X-1.393*Y-0.476*Z)*255));
  G:=Byte(Trunc((-0.969*X+1.876*Y+0.042*Z)*255));
  B:=Byte(Trunc((0.068*X-0.229*Y+1.069*Z)*255));
  WriteLn('R = ',R);
  WriteLn('G = ',G);
  WriteLn('B = ',B);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.


