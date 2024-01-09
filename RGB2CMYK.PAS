{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program RGB2CMYK;

Var
 R,G,B:Byte;
 Err:Word;
 R1,G1,B1,C,M,Y,K:Real;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function ByteHex2Str(value:Byte):String;
Const
 matrix:Array[0..15]of Char = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
Begin
 ByteHex2Str:=matrix[(value shr 4) and $0F]+matrix[value and $F];
End;

Function Max(A,B,C:Real):Real;
Var
 T:Real;
Begin
 T:=0;
 If A>T Then T:=A;
 If B>T Then T:=B;
 If C>T Then T:=C;
 Max:=T;
End;


BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('RGB2CMYK : Cette commande permet de convertir les couleurs ',
                      'RGB (RVB) en couleur CMYK.');
  WriteLn;
  WriteLn('Syntaxe : RGB2CMYK r g b');
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
  R1:=R/255.0;
  G1:=G/255.0;
  B1:=B/255.0;
  K:=1-Max(R1,G1,B1);
  C:=(1-R1);
  If 1-K<>0Then C:=C/(1-K);
  M:=(1-G1);
  If 1-K<>0Then M:=M/(1-K);
  Y:=(1-B1);
  If 1-K<>0Then Y:=Y/(1-K);
  WriteLn('C = ',C*100:1:0,'%');
  WriteLn('M = ',M*100:1:0,'%');
  WriteLn('Y = ',Y*100:1:0,'%');
  WriteLn('K = ',K*100:1:0,'%');
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.
