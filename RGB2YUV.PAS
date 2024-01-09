{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program RGB2YUV;

Var
 R,G,B:Byte;
 Err:Word;
 Y,U,V:Real;

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

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('RGB2YUV : Cette commande permet de convertir les couleurs ',
                      'RGB (RVB) en couleur (YUV).');
  WriteLn;
  WriteLn('Syntaxe : RGB2YUV r g b [/HEX]');
  WriteLn;
  WriteLn(' r     Ce parametre permet d''indiquer le rouge entre 0 et 255');
  WriteLn(' g     Ce parametre permet d''indiquer le vert entre 0 et 255');
  WriteLn(' b     Ce parametre permet d''indiquer le bleu entre 0 et 255');
  WriteLn(' /HEX Ce parametre permet de convertir la valeur en hexadecimal');
 End
  Else
 If ParamCount in[3,4]Then Begin
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
  Y:=Trunc(0.3*R+0.59*G+0.11*G);
  U:=Trunc((B-Y)*0.493);
  V:=Trunc((R-Y)*0.877);
  If StrToUpper(ParamStr(4))='/HEX'Then Begin
   WriteLn(ByteHex2Str(Byte(Trunc(Y))),
                       ByteHex2Str(Byte(Trunc(U))),
                       ByteHex2Str(Byte(Trunc(V))));
  End
   Else
  Begin
   WriteLn('Y = ',Y:1:0);
   WriteLn('U = ',U:1:0);
   WriteLn('V = ',V:1:0);
  End;
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.