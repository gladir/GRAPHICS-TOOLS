{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2022
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal, Free Pascal)
}

Program FindKlr;

Uses Strings;

Const
 ColorList:Array[0..132]of PChar=(
  'aqua','aquamarine','ardoise','ardoise bleu','ardoise bleu fonc‚',
  'ardoise gris','ardoise gris fonc‚','azure','beigne','bisque',
  'bleu ciel','bleu ciel claire','bleu claire','bleu d''Alice',
  'bleu fonc‚','blanc','blanc antique','blanc d''Almond','blanc de Navajo',
  'blanc fant“me','blanc floral','blanc fumeur','bleu','bleu acier',
  'bleu acier l‚ger','bleu cadet','bleu ciel','bleu d''Ardoise',
  'bleu de minuit','bleu de poudre','bleu embusqu‚','bleu fleur de ma‹s',
  'bleu marin','bleu m‚dium','bleu moyen d''Ardoise','bleu profond ciel',
  'bleu royal','bleu violet','brun','brun ar‚nac‚','brun attrayant',
  'brun de selle','brun/maron','Burlywood','chartreuse','chaux vert',
  'coquillage d''oc‚an','coral claire','crŠme de monnayage','crimson',
  'cyan','cyan claire','cyan fonc‚','cyan m‚dium marin','faible gris',
  'fouet de Papaye','Gainsboro','gris','gris claire','gris d''Ardoise',
  'gris fonc‚','gris l‚ger d''Ardoise','Khaki','Khaki fonc‚','indigo',
  'Ivory','jaune','jaune claire','jaune d''Or l‚ger de Rod','jaune/vert',
  'lavande','lavande rougissent','lime','magenta','magenta fonc‚',
  'moccasin','mousseline de soie de citron','navy','noir','olive terne',
  'olive verte fonc‚','Or','orange','orange fonc‚','orange rouge',
  'orchid‚e','orchid‚ fonc‚','orchid‚e moyenne','pourpre','pourpre moyen',
  'prune','Rod d''or fonc‚','Rod d''Or pƒle','Rod dor‚','rose',
  'rose brumeuse','rose chaud','rose claire','ros‚ de miel','rose fonc‚',
  'rouge','rouge am‚rindien','rouge fonc‚','rouge violet moyen','saumon',
  'saumon claire','saumon fonc‚','Sienne','sliver','souffle de pˆche',
  'teal','turquoise','turquoise fonc‚','turquoise moyen','turquoise pƒle',
  'vert','vert/bleu','vert/bleu fonc‚','vert claire','vert fluo',
  'vert fonc‚','vert forˆt','vert/jaune','vert moyen','vert oc‚an',
  'vert oc‚an claire','vert oc‚an fonc‚','vert oc‚an moyen','vert pƒle',
  'vert pelouse','violet','violet fonc‚','violet rouge'
 );

Var
 LineNumber:LongInt;
 Option:Set of (_Lines);
 BeginWord,I,J:Integer;
 FoundMultiWord:Boolean;
 SourceFile:Text;
 FileName,CurrLine,CurrWord:String;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function IsLetter(Chr:Char):Boolean;Begin
 IsLetter:=Chr in ['A'..'Z','a'..'z','‚','ˆ','Š','…','ƒ','“','‡'];
End;

Procedure CompileWord;
Var
 I:Integer;
Begin
 For I:=Low(ColorList) to High(ColorList) do Begin
  If StrToUpper(StrPas(ColorList[I]))=StrToUpper(CurrWord)Then Begin
   If FileName<>''Then Begin
    If(_Lines in Option)Then Begin
     WriteLn('Couleur trouve dans la ligne numero ',LineNumber,' :');
    End;
   End;
   WriteLn(StrPas(ColorList[I]));
   Exit;
  End;
 End;
End;

Procedure ParseLineDetectCity;
Var
 J:Integer;
Begin
 CurrWord:='';
 BeginWord:=1;
 For I:=1 to Length(CurrLine)do Begin
  If(IsLetter(CurrLine[I]))Then CurrWord:=CurrWord+CurrLine[I]
   Else
  Begin
   FoundMultiWord:=False;
   For J:=Low(ColorList) to High(ColorList) do Begin
    If(StrLen(ColorList[J])>Length(CurrWord))and
      (StrToUpper(StrPas(ColorList[J]))=
      StrToUpper(Copy(CurrLine,BeginWord,StrLen(ColorList[J]))))Then Begin
     FoundMultiWord:=True;
     Break;
    End;
   End;
   If(FoundMultiWord)Then Begin
    CurrWord:=CurrWord+CurrLine[I]
   End
    Else
   Begin
    CompileWord;
    CurrWord:='';
    BeginWord:=I+1;
   End;
  End;
 End;
 CompileWord;
End;

BEGIN
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('FINDKLR : Cette commande permet de detecter les couleurs ',
                      'mentionne dans un texte.');
  WriteLn;
  WriteLn('Syntaxe : FINDKLR "message"');
  WriteLn('          FINDKLR /FILE:fichier [/LINES]');
  WriteLn;
  WriteLn(' /FILE:  Ce parametre permet d''indiquer le fichier a analyser');
  WriteLn(' /LINES  Ce parametre permet d''afficher le numero de ligne');
 End
  Else
 Begin
  Option:=[];
  LineNumber:=0;
  FileName:='';
  CurrLine:='';
  For I:=1 to ParamCount do Begin
   If StrToUpper(ParamStr(I))='/LINES'Then Include(Option,_Lines);
   If StrToUpper(Copy(ParamStr(I),1,6))='/FILE:'Then Begin
    FileName:=Copy(ParamStr(I),7,255);
   End
    Else
   Begin
    If CurrLine=''Then CurrLine:=ParamStr(I)
                  Else CurrLine:=CurrLine+' '+ParamStr(I);
   End;
  End;
  If FileName<>''Then Begin
    Assign(SourceFile,FileName);
    Reset(SourceFile);
    While Not EOF(SourceFile)do Begin
     Inc(LineNumber);
     ReadLn(SourceFile,CurrLine);
     ParseLineDetectCity;
    End;
    Close(SourceFile);
   End
    Else
   ParseLineDetectCity;
 End;
END.

