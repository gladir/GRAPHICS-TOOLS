{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program CMYK2RGB;

Var
 R,G,B:Byte;
 Err:Word;
 tk,C,Y,M,K:Real;

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
  WriteLn('CMYK2RGB : Cette commande permet de convertir les couleurs ',
                'CMYK en couleur RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : CMYK2RGB c m y k');
  WriteLn;
  WriteLn(' c     Ce parametre permet d''indiquer Cyan, 0 … 255');
  WriteLn(' m     Ce parametre permet d''indiquer Magenta, 0 … 255');
  WriteLn(' y     Ce parametre permet d''indiquer Jaune, 0 … 255');
  WriteLn(' k     Ce parametre permet d''indiquer Noir, 0 … 255');
 End
  Else
 If ParamCount=4 Then Begin
  Val(ParamStr(1),C,Err);
  If Err>0Then Begin
   WriteLn('Valeur C invalide');
   Halt;
  End;
  Val(ParamStr(2),M,Err);
  If Err>0Then Begin
   WriteLn('Valeur M invalide');
   Halt;
  End;
  Val(ParamStr(3),Y,Err);
  If Err>0Then Begin
   WriteLn('Valeur Y invalide');
   Halt;
  End;
  Val(ParamStr(4),K,Err);
  If Err>0Then Begin
   WriteLn('Valeur K invalide');
   Halt;
  End;
  tk:=(255-K)/255;
  R:=Byte(Round(C*tk+K));
  G:=Byte(Round(Y*tk+K));
  B:=Byte(Round(M*tk+K));
  WriteLn('R = ',R);
  WriteLn('G = ',G);
  WriteLn('B = ',B);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.