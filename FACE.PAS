{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2024
  @website(https://www.gladir.com/graphics-tools)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program FACE;

Uses {$IFDEF FPC}
      DOS,Crt,PtcGraph,PtcCrt,PtcMouse
     {$ELSE}
      DOS,Crt,Graph
     {$ENDIF};

Var
 ShowGrid,MakeSVG:Boolean;
 XCenter,YCenter:Word;
 FaceWidth,FaceHeight:Word;
 Err:Word;
 I:Integer;
 TargetSVG:Text;
 FileNameSVG:String;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Procedure InitScr;
Var
 Driver,Mode:Integer;
 ErrCode:Integer;
Begin
 {$IFDEF FPC}
  Driver:=VGA;
  Mode:=VGAHi;
 {$ELSE}
  Driver:=Detect;
  Mode:=VGAHi;
 {$ENDIF}
 InitGraph(Driver,Mode,'');
 ErrCode:=GraphResult;
 If ErrCode=grOk Then Begin
  SetColor(White);
  SetLineStyle(0, 0, 1);
 End
  Else
 Begin
  WriteLn('Erreur graphique : ',GraphErrorMsg(ErrCode));
  Halt;
 End;
End;

Procedure ShowFace;
Var
 I,J:Integer;
 EyesWidth:Integer;
Begin
 If(ShowGrid)Then Begin
  SetColor(Green);
  For I:=0 to 10 do Line(I*64,0,I*64,479);
  For J:=0 to 7 do Line(0,J*64+8,639,J*64+8);
 End;
 SetColor(White);
  { Contour du visage }
 Ellipse(XCenter,YCenter,0,360,FaceWidth shr 1,FaceHeight shr 1);
  { Yeux }
 EyesWidth:=FaceWidth div 5;
 Ellipse(XCenter-(FaceWidth shr 1)+EyesWidth+(EyesWidth shr 1),YCenter,0,360,
         EyesWidth shr 1,EyesWidth div 4);
 Ellipse(XCenter-(FaceWidth shr 1)+EyesWidth*2+EyesWidth+(EyesWidth shr 1),YCenter,0,360,
         EyesWidth shr 1,EyesWidth div 4);
  { Nez }
 Line(XCenter,YCenter-(FaceHeight shr 1)+Trunc(FaceHeight*1/2),XCenter,
              YCenter-(FaceHeight shr 1)+Trunc(FaceHeight*2/3));
  { Bouche }
 Line(XCenter-30,YCenter-(FaceHeight shr 1)+Trunc((FaceHeight/3)*2.5),
      XCenter+30,YCenter-(FaceHeight shr 1)+Trunc((FaceHeight/3)*2.5));
End;

Procedure SVGFace;
Var
 I,J:Integer;
 EyesWidth:Integer;
Begin
 EyesWidth:=FaceWidth div 5;
 If FileNameSVG<>''Then Begin
  {$I+}Assign(TargetSVG,FileNameSVG);
  Rewrite(TargetSVG);{$I-}
  If IOResult=0 Then Begin
   WriteLn(TargetSVG,'<svg width="640" height="480" xmlns="http://www.w3.org/2000/svg">');
  If(ShowGrid)Then Begin
   For I:=0 to 10 do Begin
    WriteLn(TargetSVG,'<line x1="',I*64,'" ',
           'y1="',0,'" ',
           'x2="',I*64,'" ',
           'y2="',479,'" stroke="green" />');
   End;
   For J:=0 to 7 do Begin
    WriteLn(TargetSVG,'<line x1="',0,'" ',
           'y1="',J*64+8,'" ',
           'x2="',639,'" ',
           'y2="',J*64+8,'" stroke="green" />');
   End;
  End;
   { Contour du visage }
  WriteLn(TargetSVG,'<ellipse cx="',XCenter,'" cy="',YCenter,'" rx="',FaceWidth shr 1,'" ry="',FaceHeight shr 1,'" stroke="black" fill="none" />');
  { Yeux }
  WriteLn(TargetSVG,'<ellipse cx="',XCenter-(FaceWidth shr 1)+EyesWidth+(EyesWidth shr 1),'" cy="',YCenter,
               '" rx="',EyesWidth shr 1,'" ry="',EyesWidth div 4,'" stroke="black" fill="none" />');
  WriteLn(TargetSVG,'<ellipse cx="',XCenter-(FaceWidth shr 1)+EyesWidth*2+EyesWidth+(EyesWidth shr 1),'" cy="',YCenter,
        '" rx="',EyesWidth shr 1,'" ry="',EyesWidth div 4,'" stroke="black" fill="none" />');
  { Nez }
  WriteLn(TargetSVG,'<line x1="',XCenter,'" ',
         'y1="',YCenter-(FaceHeight shr 1)+Trunc(FaceHeight*1/2),'" ',
         'x2="',XCenter,'" ',
         'y2="',YCenter-(FaceHeight shr 1)+Trunc(FaceHeight*2/3),'" stroke="black" />');
  { Bouche }
  WriteLn(TargetSVG,'<line x1="',XCenter-30,'" ',
         'y1="',YCenter-(FaceHeight shr 1)+Trunc((FaceHeight/3)*2.5),'" ',
         'x2="',XCenter+30,'" ',
         'y2="',YCenter-(FaceHeight shr 1)+Trunc((FaceHeight/3)*2.5),'" stroke="black" />');
   WriteLn(TargetSVG,'</svg>');
   Close(TargetSVG);
  End;
 End
  Else
 Begin
  WriteLn('<svg width="640" height="480" xmlns="http://www.w3.org/2000/svg">');
  If(ShowGrid)Then Begin
   For I:=0 to 10 do Begin
    WriteLn('<line x1="',I*64,'" ',
           'y1="',0,'" ',
           'x2="',I*64,'" ',
           'y2="',479,'" stroke="green" />');
   End;
   For J:=0 to 7 do Begin
    WriteLn('<line x1="',0,'" ',
           'y1="',J*64+8,'" ',
           'x2="',639,'" ',
           'y2="',J*64+8,'" stroke="green" />');
   End;
  End;
   { Contour du visage }
  WriteLn('<ellipse cx="',XCenter,'" cy="',YCenter,'" rx="',FaceWidth shr 1,'" ry="',FaceHeight shr 1,'" stroke="black" fill="none" />');
  { Yeux }
  WriteLn('<ellipse cx="',XCenter-(FaceWidth shr 1)+EyesWidth+(EyesWidth shr 1),'" cy="',YCenter,
               '" rx="',EyesWidth shr 1,'" ry="',EyesWidth div 4,'" stroke="black" fill="none" />');
  WriteLn('<ellipse cx="',XCenter-(FaceWidth shr 1)+EyesWidth*2+EyesWidth+(EyesWidth shr 1),'" cy="',YCenter,
        '" rx="',EyesWidth shr 1,'" ry="',EyesWidth div 4,'" stroke="black" fill="none" />');
  { Nez }
  WriteLn('<line x1="',XCenter,'" ',
         'y1="',YCenter-(FaceHeight shr 1)+Trunc(FaceHeight*1/2),'" ',
         'x2="',XCenter,'" ',
         'y2="',YCenter-(FaceHeight shr 1)+Trunc(FaceHeight*2/3),'" stroke="black" />');
  { Bouche }
  WriteLn('<line x1="',XCenter-30,'" ',
         'y1="',YCenter-(FaceHeight shr 1)+Trunc((FaceHeight/3)*2.5),'" ',
         'x2="',XCenter+30,'" ',
         'y2="',YCenter-(FaceHeight shr 1)+Trunc((FaceHeight/3)*2.5),'" stroke="black" />');
  WriteLn('</svg>');
 End;
End;

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('FACE : Cette commande permet d''afficher un ',
                   ' modäle de visage.');
  WriteLn;
  WriteLn('Syntaxe : FACE [/WIDTH:largeur] [/HEIGHT:hauteur] [SHOWGRID:valeur]');
  WriteLn;
  WriteLn(' /FORMAT:format   Ce paramätre permet d''indiquer le format : SVG. Si aucun ',
                             'paramätre, vers l''Çcran.');
  WriteLn(' /HEIGHT:hauteur  Ce paramätre permet d''indiquer la hauteur du visage.');
  WriteLn(' /SHOWGRID:valeur Ce paramätre permet d''indiquer s''il faut afficher la gris:');
  WriteLn('                   ON=Oui, OFF=Non');
  WriteLn(' /WIDTH:largeur   Ce paramätre permet d''indiquer la largeur du visage.');
 End
  Else
 Begin
  FileNameSVG:='';
  MakeSVG:=False;
  ShowGrid:=True;
  XCenter:=320;
  YCenter:=200;
  FaceWidth:=200;
  FaceHeight:=280;
  For I:=1 to ParamCount do Begin
   If(StrToUpper(ParamStr(I))='/SVG')or
     (StrToUpper(ParamStr(I))='/FORMAT:SVG')Then MakeSVG:=True Else
   If(StrToUpper(Copy(ParamStr(I),1,Length('/WIDTH:')))='/WIDTH:')Then Begin
    Val(Copy(ParamStr(I),Length('/WIDTH:')+1,255),FaceWidth,Err);
   End
    Else
   If(StrToUpper(Copy(ParamStr(I),1,Length('/HEIGHT:')))='/HEIGHT:')Then Begin
    Val(Copy(ParamStr(I),Length('/HEIGHT:')+1,255),FaceHeight,Err);
   End
    Else
   If(StrToUpper(Copy(ParamStr(I),1,Length('/SHOWGRID:')))='/SHOWGRID:')Then Begin
    If StrToUpper(Copy(ParamStr(I),Length('/SHOWGRID:')+1,255))='ON'Then ShowGrid:=True Else
    If StrToUpper(Copy(ParamStr(I),Length('/SHOWGRID:')+1,255))='TRUE'Then ShowGrid:=True Else
    If StrToUpper(Copy(ParamStr(I),Length('/SHOWGRID:')+1,255))='OFF'Then ShowGrid:=False Else
    If StrToUpper(Copy(ParamStr(I),Length('/SHOWGRID:')+1,255))='FALSE'Then ShowGrid:=False;
   End
    Else
   FileNameSVG:=ParamStr(I);
  End;
  If(MakeSVG)Then SVGFace
   Else
  Begin
   InitScr;
   ShowFace;
   If ReadKey=#0 Then ReadKey;
  End;
 End;
END.