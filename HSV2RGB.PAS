{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program HSV2RGB;

Var
 Zone:Byte;
 Err:Word;
 R,G,B,F,T,H,S,V:Real;

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
  WriteLn('HSV2RGB : Cette commande permet de convertir les couleurs ',
                'HSV en couleur RGB (RVB).');
  WriteLn;
  WriteLn('Syntaxe : HSV2RGB h s v');
  WriteLn;
  WriteLn(' h     Ce parametre permet d''indiquer H');
  WriteLn(' s     Ce parametre permet d''indiquer S');
  WriteLn(' v     Ce parametre permet d''indiquer V');
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
  Val(ParamStr(3),V,Err);
  If Err>0Then Begin
   WriteLn('Valeur V invalide');
   Halt;
  End;
  If H=360Then H:=0;
  Zone:=Trunc(H/60);
  F:=H/60-Zone;
  Case(Zone)of
   0:Begin
    r:=v;
    g:=v*(1-s*(1-f));
    b:=v*(1-s);
   End;
   1:Begin
    r:=v*(1-s*f);
    g:=v;
    b:=v*(1-s);
   End;
   2:Begin
    r:=v*(1-s);
    g:=v;
    b:=v*(1-s*(1-f));
   End;
   3:Begin
    r:=v*(1-s);
    g:=v*(1-s*f);
    b:=v;
   End;
   4:Begin
    r:=v*(1-s*(1-f));
    g:=v*(1-s);
    b:=v;
   End;
   5:Begin
    r:=v;
    g:=v*(1-s);
    b:=v*(1-s*f);
   End;
   Else Begin
    R:=0;G:=0;B:=0;
   End;
  End;
  WriteLn('R = ',R*256:1:0);
  WriteLn('G = ',G*256:1:0);
  WriteLn('B = ',B*256:1:0);
 End
  Else
 WriteLn('Nombre de parametre invalide');
END.

