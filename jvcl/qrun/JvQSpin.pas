{******************************************************************************}
{* WARNING:  JEDI VCL To CLX Converter generated unit.                        *}
{*           Manual modifications will be lost on next release.               *}
{******************************************************************************}

{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvSpin.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 1997, 1998 Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 2001,2002 SGB Software
All Rights Reserved.

Contributor(s):
  Polaris Software
  boerema1
  roko
  remkobonte

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:

-----------------------------------------------------------------------------}
// $Id$

unit JvQSpin;

{$I jvcl.inc}

interface

uses
  SysUtils, Classes, Qt, QWindows, QMessages,
  QComCtrls, QControls, QExtCtrls, QGraphics, QForms,
  QComboEdits, JvQExComboEdits, QComCtrlsEx,
  JvQEdit, JvQExMask, JvQMaskEdit, JvQComponent;

type
  TSpinButtonState = (sbNotDown, sbTopDown, sbBottomDown);

  TJvSpinButtonStyle = (sbsDefault, sbsClassic); // Polaris

  TJvSpinButton = class(TJvGraphicControl)
  private
    FDown: TSpinButtonState;
    FDragging: Boolean;
    FUpBitmap: TBitmap; // Custom up arrow
    FDownBitmap: TBitmap; // Custom down arrow
    FButtonBitmaps: Pointer;
    FRepeatTimer: TTimer;
    FLastDown: TSpinButtonState;
    FFocusControl: TWinControl;
    FOnTopClick: TNotifyEvent;
    FOnBottomClick: TNotifyEvent;
    FButtonStyle: TJvSpinButtonStyle;
    procedure SetButtonStyle(Value: TJvSpinButtonStyle);
    procedure TopClick;
    procedure BottomClick;
    procedure GlyphChanged(Sender: TObject);
    function GetDownGlyph: TBitmap;
    function GetUpGlyph: TBitmap;
    procedure SetDown(Value: TSpinButtonState);
    procedure SetDownGlyph(Value: TBitmap);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetUpGlyph(Value: TBitmap);
    procedure TimerExpired(Sender: TObject);
    procedure CMSysColorChange(var Msg: TMessage); message CM_SYSCOLORCHANGE;
  protected
    procedure CheckButtonBitmaps;
    procedure RemoveButtonBitmaps;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;

    function MouseInBottomBtn(const P: TPoint): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Down: TSpinButtonState read FDown write SetDown default sbNotDown;
  published
    property ButtonStyle: TJvSpinButtonStyle read FButtonStyle write SetButtonStyle default sbsDefault;
    property DragMode;
    property Enabled;
    property Visible;
    property DownGlyph: TBitmap read GetDownGlyph write SetDownGlyph;
    property UpGlyph: TBitmap read GetUpGlyph write SetUpGlyph;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowHint;
    property ParentShowHint;
    property Anchors;
    property Constraints;
    property OnBottomClick: TNotifyEvent read FOnBottomClick write FOnBottomClick;
    property OnTopClick: TNotifyEvent read FOnTopClick write FOnTopClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
  end;

  TValueType = (vtInteger, vtFloat, vtHex);

  TSpinButtonKind = (bkStandard, bkDiagonal, bkClassic);

  TJvCheckOption = (coCheckOnChange, coCheckOnExit, coCropBeyondLimit);
  TJvCheckOptions = set of TJvCheckOption;

  TJvCustomSpinEdit = class(TJvExCustomComboMaskEdit)
  private
    FShowButton: Boolean;
    FCheckMaxValue: Boolean;
    FCheckMinValue: Boolean;
    FCheckOptions: TJvCheckOptions;
    FDisplayFormat: string;
    FFocused: Boolean;
    FLCheckMaxValue: Boolean;
    FLCheckMinValue: Boolean;
    FAlignment: TAlignment;
    FMinValue: Extended;
    FMaxValue: Extended;
    FOldValue: Extended;
    FIncrement: Extended;
    FDecimal: Byte;
    FChanging: Boolean;
    //FOldValue: Extended; // New
    FEditorEnabled: Boolean;
    FValueType: TValueType;
    FButton: TJvSpinButton;
    FBtnWindow: TWinControl;
    FArrowKeys: Boolean;
    FOnTopClick: TNotifyEvent;
    FOnBottomClick: TNotifyEvent;
    // FButtonKind: TSpinButtonKind;
    FUpDown: TCustomUpDown;
    FThousands: Boolean; // New
    function StoreCheckMaxValue: Boolean;
    function StoreCheckMinValue: Boolean;
    procedure SetCheckMaxValue(NewValue: Boolean);
    procedure SetCheckMinValue(NewValue: Boolean);
    procedure SetMaxValue(NewValue: Extended);
    procedure SetMinValue(NewValue: Extended);

    function CheckDefaultRange(CheckMax: Boolean): Boolean;
    procedure SetDisplayFormat(const Value: string);
    function IsFormatStored: Boolean;
    //function TextToValText(const AValue: string): string;
    procedure SetFocused(Value: Boolean);
    //procedure CheckRange(const AOption: TJvCheckOption);

    //function TryGetValue(var Value: Extended): Boolean; // New
    function GetAsInteger: Longint;
    function GetButtonKind: TSpinButtonKind;
    function GetButtonWidth: Integer;
    function GetMinHeight: Integer;
    function IsIncrementStored: Boolean;
    function IsMaxStored: Boolean;
    function IsMinStored: Boolean;
    function IsValueStored: Boolean;
    procedure GetTextHeight(var SysHeight, Height: Integer);
    procedure ResizeButton;
    procedure SetAlignment(Value: TAlignment);
    procedure SetArrowKeys(Value: Boolean);
    procedure SetAsInteger(NewValue: Longint);
    procedure SetButtonKind(Value: TSpinButtonKind);
    procedure SetDecimal(NewValue: Byte);
    procedure SetEditRect;
    procedure SetThousands(Value: Boolean);
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure SetShowButton(Value: Boolean); 
    procedure WMCut(var Mesg: TMessage); message WM_CUT;
    procedure WMPaste(var Mesg: TMessage); message WM_PASTE;
  protected
    FButtonKind: TSpinButtonKind;
    procedure DoKillFocus(FocusedWnd: HWND); override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;  const  MousePos: TPoint): Boolean; override;
    procedure BoundsChanged; override;
    procedure EnabledChanged; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure FontChanged; override;
    function CheckValue(NewValue: Extended): Extended;
    function CheckValueRange(NewValue: Extended; RaiseOnError: Boolean): Extended;
    function GetValue: Extended; virtual; abstract;
    procedure DataChanged; virtual;
    procedure RecreateButton;
    procedure SetValue(NewValue: Extended); virtual; abstract;
    procedure SetValueType(NewType: TValueType); virtual;

    function DefaultDisplayFormat: string; virtual;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat stored IsFormatStored;
    //    procedure DefinePropertyes(Filer: TFiler); override;

    function IsValidChar(Key: Char): Boolean; virtual;
    procedure Change; override; 
    procedure DownClick(Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure UpClick(Sender: TObject); virtual;
    property ButtonWidth: Integer read GetButtonWidth;
  public
    procedure Loaded; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property AsInteger: Longint read GetAsInteger write SetAsInteger default 0;
    property Text;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ArrowKeys: Boolean read FArrowKeys write SetArrowKeys default True;
    property ButtonKind: TSpinButtonKind read FButtonKind write SetButtonKind default bkDiagonal;
    property Decimal: Byte read FDecimal write SetDecimal default 2;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Extended read FIncrement write FIncrement stored IsIncrementStored;
    property MaxValue: Extended read FMaxValue write SetMaxValue stored IsMaxStored;
    property MinValue: Extended read FMinValue write SetMinValue stored IsMinStored;
    property CheckOptions: TJvCheckOptions read FCheckOptions write FCheckOptions default [coCheckOnChange, coCheckOnExit, coCropBeyondLimit];
    property CheckMinValue: Boolean read FCheckMinValue write SetCheckMinValue stored StoreCheckMinValue;
    property CheckMaxValue: Boolean read FCheckMaxValue write SetCheckMaxValue stored StoreCheckMaxValue;
    property ValueType: TValueType read FValueType write SetValueType
      default  vtInteger ;
    property Value: Extended read GetValue write SetValue stored IsValueStored;
    property Thousands: Boolean read FThousands write SetThousands default False;
    property ShowButton: Boolean read FShowButton write SetShowButton default True;
    property OnBottomClick: TNotifyEvent read FOnBottomClick write FOnBottomClick;
    property OnTopClick: TNotifyEvent read FOnTopClick write FOnTopClick;
  end;

  TJvSpinEdit = class(TJvCustomSpinEdit)
  protected
    procedure SetValue(NewValue: Extended); override;
    function GetValue: Extended; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    //Polaris
    //property CheckOnExit;
    property CheckOptions;
    property CheckMinValue;
    property CheckMaxValue;

    property BeepOnError;

    property Align;
    property Alignment;
    property ArrowKeys;
    property DisplayFormat;
    property ButtonKind default bkDiagonal;
    property Thousands;
    property Decimal;
    property EditorEnabled;
    property Increment;
    property MaxValue;
    property MinValue;
    property ShowButton;
    property ValueType;
    property Value;
    property OnBottomClick;
    property OnTopClick;

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color; 
    property DragMode;
    property Enabled;
    property Font;
    property Anchors;
    property Constraints;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property HideSelection; 
    property ClipboardCommands;
  end;

implementation

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  QConsts,
  JvQThemes, 
  JvQJCLUtils, JvQJVCLUtils, JvQConsts, JvQResources, JvQToolEdit;

{$IFDEF MSWINDOWS}
{$R ..\Resources\JvSpin.Res}
{$ENDIF MSWINDOWS}
{$IFDEF UNIX}
{$R ../Resources/JvSpin.Res}
{$ENDIF UNIX}

const
  sSpinUpBtn = 'JvSpinUP';
  sSpinDownBtn = 'JvSpinDOWN';
  sSpinUpBtnPole = 'JvSpinUPPOLE';
  sSpinDownBtnPole = 'JvSpinDOWNPOLE';

const
  InitRepeatPause = 400; { pause before repeat timer (ms) }
  RepeatPause = 100;

  (*Polaris
procedure TJvSpinButton.DrawBitmap(ABitmap: TBitmap; ADownState: TSpinButtonState);
var
  R, RSrc: TRect;
  dRect: Integer;
  {Temp: TBitmap;}
begin
  ABitmap.Height := Height;
  ABitmap.Width := Width;
  with ABitmap.Canvas do
  begin
    R := Bounds(0, 0, Width, Height);
    Pen.Width := 1;
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    FillRect(R);
    { buttons frame }
    Pen.Color := clWindowFrame;
    Rectangle(0, 0, Width, Height);
    MoveTo(-1, Height);
    LineTo(Width, -1);
    { top button }
    if ADownState = sbTopDown then Pen.Color := clBtnShadow
    else Pen.Color := clBtnHighlight;
    MoveTo(1, Height - 4);
    LineTo(1, 1);
    LineTo(Width - 3, 1);
    if ADownState = sbTopDown then Pen.Color := clBtnHighlight
      else Pen.Color := clBtnShadow;
    if ADownState <> sbTopDown then
    begin
      MoveTo(1, Height - 3);
      LineTo(Width - 2, 0);
    end;
    { bottom button }
    if ADownState = sbBottomDown then Pen.Color := clBtnHighlight
      else Pen.Color := clBtnShadow;
    MoveTo(2, Height - 2);
    LineTo(Width - 2, Height - 2);
    LineTo(Width - 2, 1);
    if ADownState = sbBottomDown then Pen.Color := clBtnShadow
      else Pen.Color := clBtnHighlight;
    MoveTo(2, Height - 2);
    LineTo(Width - 1, 1);
    { top glyph }
    dRect := 1;
    if ADownState = sbTopDown then Inc(dRect);
    R := Bounds(Round((Width / 4) - (FUpBitmap.Width / 2)) + dRect,
      Round((Height / 4) - (FUpBitmap.Height / 2)) + dRect, FUpBitmap.Width,
      FUpBitmap.Height);
    RSrc := Bounds(0, 0, FUpBitmap.Width, FUpBitmap.Height);
    {
    if Self.Enabled or (csDesigning in ComponentState) then
      BrushCopy(R, FUpBitmap, RSrc, FUpBitmap.TransparentColor)
    else
    begin
      Temp := CreateDisabledBitmap(FUpBitmap, clBlack);
      try
        BrushCopy(R, Temp, RSrc, Temp.TransparentColor);
      finally
        Temp.Free;
      end;
    end;
    }
    BrushCopy(R, FUpBitmap, RSrc, FUpBitmap.TransparentColor);
    { bottom glyph }
    R := Bounds(Round((3 * Width / 4) - (FDownBitmap.Width / 2)) - 1,
      Round((3 * Height / 4) - (FDownBitmap.Height / 2)) - 1,
      FDownBitmap.Width, FDownBitmap.Height);
    RSrc := Bounds(0, 0, FDownBitmap.Width, FDownBitmap.Height);
    {
    if Self.Enabled or (csDesigning in ComponentState) then
      BrushCopy(R, FDownBitmap, RSrc, FDownBitmap.TransparentColor)
    else
    begin
      Temp := CreateDisabledBitmap(FDownBitmap, clBlack);
      try
        BrushCopy(R, Temp, RSrc, Temp.TransparentColor);
      finally
        Temp.Free;
      end;
    end;
    }
    BrushCopy(R, FDownBitmap, RSrc, FDownBitmap.TransparentColor);
    if ADownState = sbBottomDown then
    begin
      Pen.Color := clBtnShadow;
      MoveTo(3, Height - 2);
      LineTo(Width - 1, 2);
    end;
  end;
end;
*)

type
  TColorArray = array [0..2] of TColor; 
  THackedCustomForm = class(TCustomForm); 

  TJvUpDown = class(TCustomUpDown)
  private
    FChanging: Boolean;  
  protected
    procedure Click(Button: TUDBtnType); override; 
  public
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnClick;
  end;

  { The face of a spin button is stored because they are a bit to complex to
    calculate everytime in a Paint method. There are multiple bitmaps stored
    for a single spin button, eg disable/top-down/bottom down etc.

    The face bitmaps of a spin button are stored in a TSpinButtonBitmaps
    object. Multiple spin buttons can use the same TSpinButtonBitmaps object.
    (That is, identical spin buttons (same height, width, button kind etc.) use the
    same TSpinButtonbitmaps objects) The TSpinButtonBitmaps objects are managed
    by a single TSpinButtonBitmapsManager object.
  }

  TSpinButtonBitmapsManager = class;

  TSpinButtonBitmaps = class
  private
    FManager: TSpinButtonBitmapsManager;
    FHeight: Integer;
    FWidth: Integer;
    FStyle: TJvSpinButtonStyle;
    FClientCount: Integer;

    FTopDownBtn: TBitmap;
    FBottomDownBtn: TBitmap;
    FNotDownBtn: TBitmap;
    FDisabledBtn: TBitmap;
    FCustomGlyphs: Boolean;
    FResetOnDraw: Boolean; 
  protected
    procedure DrawAllBitmap;
    procedure DrawBitmap(ABitmap: TBitmap; ADownState: TSpinButtonState; const Enabled: Boolean);
    procedure PoleDrawArrows(ACanvas: TCanvas; const AState: TSpinButtonState; const Enabled: Boolean;
      AUpArrow, ADownArrow: TBitmap);
    procedure JvDrawArrows(ACanvas: TCanvas; const AState: TSpinButtonState; const Enabled: Boolean;
      AUpArrow, ADownArrow: TBitmap); 
    procedure Reset;

    function CompareWith(const AWidth, AHeight: Integer; const AStyle: TJvSpinButtonStyle;
      const ACustomGlyphs: Boolean): Integer;
  public
    constructor Create(AManager: TSpinButtonBitmapsManager; const AWidth, AHeight: Integer;
      const AStyle: TJvSpinButtonStyle; const ACustomGlyphs: Boolean); virtual;
    destructor Destroy; override;

    procedure AddClient;
    procedure RemoveClient;

    procedure Draw(ACanvas: TCanvas; const ADown: TSpinButtonState;
      const AEnabled, AMouseInTopBtn, AMouseInBottomBtn: Boolean);
    procedure DrawGlyphs(ACanvas: TCanvas; const AState: TSpinButtonState; const Enabled: Boolean;
      AUpArrow, ADownArrow: TBitmap);

    property Width: Integer read FWidth;
    property Height: Integer read FHeight;
    property Style: TJvSpinButtonStyle read FStyle;
    property CustomGlyphs: Boolean read FCustomGlyphs;
  end;

  TSpinButtonBitmapsManager = class
  private
    FClientCount: Integer;
    FList: TList;
  protected
    function Find(const Width, Height: Integer; const AButtonStyle: TJvSpinButtonStyle;
      const ACustomGlyphs: Boolean; var Index: Integer): Boolean;
    procedure Remove(Obj: TObject);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function WantButtons(const Width, Height: Integer; const AButtonStyle: TJvSpinButtonStyle;
      const ACustomGlyphs: Boolean): TSpinButtonBitmaps;

    procedure AddClient;
    procedure RemoveClient;
  end;

var
  GSpinButtonBitmapsManager: TSpinButtonBitmapsManager = nil;

//=== Local procedures =======================================================

function SpinButtonBitmapsManager: TSpinButtonBitmapsManager;
begin
  if GSpinButtonBitmapsManager = nil then
    GSpinButtonBitmapsManager := TSpinButtonBitmapsManager.Create;
  Result := GSpinButtonBitmapsManager;
end;

function DefBtnWidth: Integer;
begin
  Result := GetSystemMetrics(SM_CXVSCROLL);
  if Result > 15 then
    Result := 15;
end;

function RemoveThousands(const AValue: string): string;
begin
  if DecimalSeparator <> ThousandSeparator then
    Result := DelChars(AValue, ThousandSeparator)
  else
    Result := AValue;
end;


//=== { TJvCustomSpinEdit } ==================================================

procedure TJvCustomSpinEdit.Change;
var
  //  OldText: string;
  OldSelStart: Integer;
begin
  { (rb) Maybe move to CMTextChanged }
  if FChanging or not HandleAllocated then
    Exit;

  FChanging := True;
  try
    //    OldText := inherited Text;
    OldSelStart := SelStart;
    try
      if not (csDesigning in ComponentState) and (coCheckOnChange in CheckOptions) then
      begin
        CheckValueRange(Value, not (coCropBeyondLimit in CheckOptions));
        SetValue(CheckValue(Value));
      end;
    except
      SetValue(CheckValue(Value));
    end;
  finally
    FChanging := False;
  end;
  if FOldValue <> Value then
  begin
    inherited Change;
    FOldValue := Value;
  end;
  //  if AnsiCompareText(inherited Text, OldText) <> 0 then
  //    inherited Change;

  SelStart := OldSelStart;
end;

function TJvCustomSpinEdit.CheckDefaultRange(CheckMax: Boolean): Boolean;
begin
  Result := (FMinValue <> 0) or (FMaxValue <> 0);
end;

function TJvCustomSpinEdit.CheckValue(NewValue: Extended): Extended;
begin
  Result := NewValue;
  {
    if (FMaxValue <> FMinValue) then
    begin
      if NewValue < FMinValue then
        Result := FMinValue
      else
      if NewValue > FMaxValue then
        Result := FMaxValue;
    end;
  }
  if FCheckMinValue or FCheckMaxValue then
  begin
    if FCheckMinValue and (NewValue < FMinValue) then
      Result := FMinValue;
    if FCheckMaxValue and (NewValue > FMaxValue) then
      Result := FMaxValue;
  end;
end;

function TJvCustomSpinEdit.CheckValueRange(NewValue: Extended; RaiseOnError: Boolean): Extended;
begin
  Result := CheckValue(NewValue);
  if (FCheckMinValue or FCheckMaxValue) and
    RaiseOnError and (Result <> NewValue) then
    raise ERangeError.CreateResFmt(@RsEOutOfRangeFloat, [FMinValue, FMaxValue]);
end;



constructor TJvCustomSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FThousands := False; //new

  //Polaris
  FFocused := False;
  FCheckOptions := [coCheckOnChange, coCheckOnExit, coCropBeyondLimit];
  FLCheckMinValue := True;
  FLCheckMaxValue := True;
  FCheckMinValue := False;
  FCheckMaxValue := False;
  //Polaris
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1.0;
  FDecimal := 2;
  FEditorEnabled := True;
  FButtonKind := bkDiagonal;
  FArrowKeys := True;
  FShowButton := True;
  RecreateButton;
end;



procedure TJvCustomSpinEdit.DataChanged;
var
  EditFormat: string;
  WasModified: Boolean;
begin
  if (ValueType = vtFloat) and FFocused and (FDisplayFormat <> '') then
  begin
    EditFormat := '0';
    if FDecimal > 0 then
      EditFormat := EditFormat + '.' + MakeStr('#', FDecimal);
    { Changing EditText sets Modified to false }
    WasModified := Modified;
    try
      Text := FormatFloat(EditFormat, Value);
    finally
      Modified := WasModified;
    end;
  end;
end;

function TJvCustomSpinEdit.DefaultDisplayFormat: string;
begin
  Result := ',0.##';
end;

destructor TJvCustomSpinEdit.Destroy;
begin
  Destroying;
  FChanging := True;
  if FButton <> nil then
  begin
    FButton.Free;
    FButton := nil;
    FBtnWindow.Free;
    FBtnWindow := nil;
  end;
  if FUpDown <> nil then
  begin
    FUpDown.Free;
    FUpDown := nil;
  end;
  inherited Destroy;
end;

procedure TJvCustomSpinEdit.BoundsChanged;
var
  MinHeight: Integer;
begin
  MinHeight := GetMinHeight;
  { text edit bug: if size to less than minheight, then edit ctrl does
    not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else
  begin
    ResizeButton;
    SetEditRect;
    inherited BoundsChanged;
  end;
end;

procedure TJvCustomSpinEdit.WMCut(var Mesg: TMessage);
begin
  if FEditorEnabled then
    inherited;
end;

procedure TJvCustomSpinEdit.WMPaste(var Mesg: TMessage);
begin
  if FEditorEnabled then
    inherited ;

  { Polaris code:
  if not FEditorEnabled or ReadOnly then
    Exit;
  V := Value;
  inherited;
  try
    StrToFloat(Text);
  except
    SetValue(V);
  end;
  }
end;

procedure TJvCustomSpinEdit.DoEnter;
begin
  SetFocused(True);
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited DoEnter;
end;

procedure TJvCustomSpinEdit.DoExit;
begin
  SetFocused(False);
  try
    if not (csDesigning in ComponentState) and (coCheckOnExit in CheckOptions) then
    begin
      CheckValueRange(Value, not (coCropBeyondLimit in CheckOptions));
      SetValue(CheckValue(Value));
    end;
  except
    SetFocused(True);
    SelectAll;
    if CanFocus then
      SetFocus;
    raise;
  end;
  inherited DoExit;
end;

procedure TJvCustomSpinEdit.DoKillFocus(FocusedWnd: HWND);
begin
  if ([coCropBeyondLimit, coCheckOnExit] <= CheckOptions) and
    not (csDesigning in ComponentState) then
    SetValue(CheckValue(Value));
  inherited DoKillFocus(FocusedWnd);
end;

function TJvCustomSpinEdit.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;  const  MousePos: TPoint): Boolean;
begin
  if WheelDelta > 0 then
    UpClick(nil)
  else
    DownClick(nil);
  Result := True;
end;

procedure TJvCustomSpinEdit.DownClick(Sender: TObject);
var
  OldText: string;
begin
  if ReadOnly then
    DoBeepOnError
  else
  begin
    FChanging := True;
    try
      OldText := inherited Text;
      Value := Value - FIncrement;
    finally
      FChanging := False;
    end;
    if AnsiCompareText(inherited Text, OldText) <> 0 then
    begin
      Modified := True;
      Change;
    end;
    if Assigned(FOnBottomClick) then
      FOnBottomClick(Self);
  end;
end;

procedure TJvCustomSpinEdit.EnabledChanged;
begin
  inherited EnabledChanged;
  if FUpDown <> nil then
  begin
    FUpDown.Enabled := Enabled;
    ResizeButton;
  end;
  if FButton <> nil then
    FButton.Enabled := Enabled;
end;

procedure TJvCustomSpinEdit.FontChanged;
begin
  inherited FontChanged;
  ResizeButton;
  SetEditRect;
end;

{function TJvCustomSpinEdit.TryGetValue(var Value: Extended): Boolean;
var
  S: string;
begin
  try
    S := StringReplace(Text, ThousandSeparator, '', [rfReplaceAll]);
    if ValueType = vtFloat then
      Value := StrToFloat(S)
    else
      if ValueType = vtHex then
        Value := StrToInt('$' + Text)
      else
        Value := StrToInt(S);
    Result := True;
  except
    if ValueType = vtFloat then
      Value := FMinValue
    else
      Value := Trunc(FMinValue);
    Result := False;
  end;
end;}

function TJvCustomSpinEdit.GetAsInteger: Longint;
begin
  Result := Trunc(GetValue);
end;

function TJvCustomSpinEdit.GetButtonKind: TSpinButtonKind;
begin
  if NewStyleControls then
    Result := FButtonKind
      //>Polaris
  else
  begin
    Result := bkDiagonal;
    if Assigned(FButton) and (FButton.ButtonStyle = sbsClassic) then
      Result := bkClassic;
  end;
  //<Polaris
end;

function TJvCustomSpinEdit.GetButtonWidth: Integer;
begin
  if ShowButton then
  begin
    if FUpDown <> nil then
      Result := FUpDown.Width
    else
    if FButton <> nil then
      Result := FButton.Width
    else
      Result := DefBtnWidth;
  end
  else
    Result := 0;
end;

function TJvCustomSpinEdit.GetMinHeight: Integer;
var
  I, H: Integer;
begin
  GetTextHeight(I, H);
  if I > H then
    I := H;
  Result := H + (GetSystemMetrics(SM_CYBORDER) * 4) + 1;
end;

procedure TJvCustomSpinEdit.GetTextHeight(var SysHeight, Height: Integer);
var
  DC: HDC;
  SaveFont: HFONT;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(HWND_DESKTOP);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(HWND_DESKTOP, DC);
  SysHeight := SysMetrics.tmHeight;
  Height := Metrics.tmHeight;
end;

function TJvCustomSpinEdit.IsFormatStored: Boolean;
begin
  Result := DisplayFormat <> DefaultDisplayFormat;
end;

function TJvCustomSpinEdit.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

function TJvCustomSpinEdit.IsMaxStored: Boolean;
begin
  Result := MaxValue <> 0.0;
end;

function TJvCustomSpinEdit.IsMinStored: Boolean;
begin
  Result := MinValue <> 0.0;
end;

function TJvCustomSpinEdit.IsValidChar(Key: Char): Boolean;
var
  ValidChars: set of Char;
begin
  ValidChars := DigitChars + ['+', '-'];
  if ValueType = vtFloat then
  begin
    if Pos(DecimalSeparator, Text) = 0 then
    begin
      if not Thousands or (ThousandSeparator <> '.') then
        ValidChars := ValidChars + [DecimalSeparator, '.'] // Polaris
      else
        ValidChars := ValidChars + [DecimalSeparator];
    end;
    if Pos('E', AnsiUpperCase(Text)) = 0 then
      ValidChars := ValidChars + ['e', 'E'];
  end
  else
  if ValueType = vtHex then
  begin
    ValidChars := ValidChars + ['A'..'F', 'a'..'f'];
  end;
  Result := (Key in ValidChars) or (Key < #32);
  if not FEditorEnabled and Result and ((Key >= #32) or
    (Key = BackSpace) or (Key = Del)) then
    Result := False;
end;

function TJvCustomSpinEdit.IsValueStored: Boolean;
begin
  Result := GetValue <> 0.0;
end;

procedure TJvCustomSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if ArrowKeys and ((Key = VK_UP) or (Key = VK_DOWN)) then
  begin
    if Key = VK_UP then
      UpClick(Self)
    else
    if Key = VK_DOWN then
      DownClick(Self);
    Key := 0;
  end;
end;

procedure TJvCustomSpinEdit.KeyPress(var Key: Char);
var
  I: Integer;
begin
  // andreas
  if (Key = DecimalSeparator) and (ValueType = vtFloat) then
  begin
    { If the key is the decimal separator move the caret behind it. }
    I := Pos(DecimalSeparator, Text);
    if I <> 0 then
    begin
      Key := #0;
      SelLength := 0;
      SelStart := I;
      Exit;
    end;
  end;

  if not IsValidChar(Key) then
  begin
    Key := #0;
    DoBeepOnError;
  end;
  //Polaris
  if (Key = '.') and (not Thousands or (ThousandSeparator <> '.')) then
    Key := DecimalSeparator;

  if Key <> #0 then
  begin
    inherited KeyPress(Key);
    if (Key = Cr) or (Key = Esc) then
    begin
      { must catch and remove this, since is actually multi-line }  
      THackedCustomForm(GetParentForm(Self)).WantKey(Integer(Key), [], Key); 
      if Key = Cr then
        Key := #0;
    end;
  end;
end;

procedure TJvCustomSpinEdit.Loaded;
begin
  inherited Loaded;
  FLCheckMinValue := True;
  FLCheckMaxValue := True;
  FOldValue := Value;
end;

procedure TJvCustomSpinEdit.RecreateButton;
begin
  if csDestroying in ComponentState then
    Exit;
  FButton.Free;
  FButton := nil;
  FBtnWindow.Free;
  FBtnWindow := nil;
  FUpDown.Free;
  FUpDown := nil;
  if ShowButton then
    if GetButtonKind = bkStandard then
    begin
      FUpDown := TJvUpDown.Create(Self);
      with TJvUpDown(FUpDown) do
      begin
        Visible := True;
        //Polaris
//        SetBounds(0, 1, DefBtnWidth, Self.Height);
        SetBounds(0, 0, DefBtnWidth, Self.Height);
        if BiDiMode = bdRightToLeft then
          Align := alLeft
        else
          Align := alRight;
        Parent := Self.ClientArea;
        OnClick := UpDownClick;
      end;
    end
    else
    begin
      FBtnWindow := TWinControl.Create(Self);
      FBtnWindow.Visible := True;
      FBtnWindow.Parent := Self.ClientArea;
      if FButtonKind <> bkClassic then
        FBtnWindow.SetBounds(0, 0, DefBtnWidth, Height)
      else
        FBtnWindow.SetBounds(0, 0, Height, Height);
      FBtnWindow.Align := alRight;
      FButton := TJvSpinButton.Create(Self);
      FButton.Visible := True;
      if FButtonKind = bkClassic then
        FButton.FButtonStyle := sbsClassic;
      FButton.Parent := FBtnWindow;
      FButton.FocusControl := Self;
      FButton.OnTopClick := UpClick;
      FButton.OnBottomClick := DownClick;
      //Polaris
      //FButton.SetBounds(1, 1, FBtnWindow.Width - 1, FBtnWindow.Height - 1);
      FButton.SetBounds(0, 0, FBtnWindow.Width, FBtnWindow.Height);
    end;
end;

procedure TJvCustomSpinEdit.ResizeButton;
var
  R: TRect;
begin
  if FUpDown <> nil then
  begin
    FUpDown.Width := DefBtnWidth;
    if BiDiMode = bdRightToLeft then
      FUpDown.Align := alLeft
    else
      FUpDown.Align := alRight;
  end
  else
  if FButton <> nil then
  begin { bkDiagonal }
    if NewStyleControls and  (BorderStyle = bsSingle) then
      if FButtonKind = bkClassic then
        R := Bounds(Width - DefBtnWidth - 4, -1, DefBtnWidth, Height - 3)
      else
        R := Bounds(Width - Height - 1, -1, Height - 3, Height - 3)
    else
      if FButtonKind = bkClassic then
      R := Bounds(Width - DefBtnWidth, 0, DefBtnWidth, Height)
    else
      R := Bounds(Width - Height, 0, Height, Height);
    if BiDiMode = bdRightToLeft then
    begin
      if NewStyleControls and  (BorderStyle = bsSingle) then
      begin
        R.Left := -1;
        R.Right := Height - 4;
      end
      else
      begin
        R.Left := 0;
        R.Right := Height;
      end;
    end;
    with R do
      FBtnWindow.SetBounds(Left, Top, Right - Left, Bottom - Top);
    if BiDiMode = bdRightToLeft then
      FBtnWindow.Align := alLeft
    else
      FBtnWindow.Align := alRight;
    //Polaris
    FButton.SetBounds(1, 1, FBtnWindow.Width - 1, FBtnWindow.Height - 1);
  end;
end;

procedure TJvCustomSpinEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TJvCustomSpinEdit.SetArrowKeys(Value: Boolean);
begin
  FArrowKeys := Value;
  ResizeButton;
end;

procedure TJvCustomSpinEdit.SetAsInteger(NewValue: Longint);
begin
  SetValue(NewValue);
end;

procedure TJvCustomSpinEdit.SetButtonKind(Value: TSpinButtonKind);
var
  OldKind: TSpinButtonKind;
begin
  OldKind := FButtonKind;
  FButtonKind := Value;
  if OldKind <> GetButtonKind then
  begin
    RecreateButton;
    ResizeButton;
    SetEditRect;
  end;
end;

procedure TJvCustomSpinEdit.SetCheckMaxValue(NewValue: Boolean);
begin
  if FMaxValue <> 0 then
    NewValue := True;
  FCheckMaxValue := NewValue;
  if csLoading in ComponentState then
    FLCheckMaxValue := False;
  SetValue(Value);
end;

procedure TJvCustomSpinEdit.SetCheckMinValue(NewValue: Boolean);
begin
  if FMinValue <> 0 then
    NewValue := True;
  FCheckMinValue := NewValue;
  if csLoading in ComponentState then
    FLCheckMinValue := False;
  SetValue(Value);
end;

procedure TJvCustomSpinEdit.SetShowButton(Value: Boolean);
begin
  if FShowButton <> Value then
  begin
    FShowButton := Value;
    RecreateButton;
    ResizeButton;
    SetEditRect;
  end;
end;

procedure TJvCustomSpinEdit.SetDecimal(NewValue: Byte);
begin
  if FDecimal <> NewValue then
  begin
    FDecimal := NewValue;
    Value := GetValue;
  end;
end;

procedure TJvCustomSpinEdit.SetDisplayFormat(const Value: string);
begin
  if DisplayFormat <> Value then
  begin
    FDisplayFormat := Value;
    Invalidate;
  end;
end;

procedure TJvCustomSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
  //Polaris
  if BiDiMode = bdRightToLeft then
  begin
    SetRect(Loc, GetButtonWidth + 1, 0, ClientWidth - 1, ClientHeight + 1);
  end
  else
  begin
    SetRect(Loc, 0, 0, ClientWidth - GetButtonWidth - 2, ClientHeight + 1);
  end;
  SendMessage(Handle, EM_SETRECT, 0, Longint(@Loc));
  //SetEditorRect(@Loc);
end;

procedure TJvCustomSpinEdit.SetFocused(Value: Boolean);
begin
  if Value <> FFocused then
  begin
    FFocused := Value;
    Invalidate;
    DataChanged;
  end;
end;

procedure TJvCustomSpinEdit.SetMaxValue(NewValue: Extended);
var
  Z: Boolean;
  b: Boolean;
begin
  if NewValue <> FMaxValue then
  begin
    b := not StoreCheckMaxValue;
    Z := (FMaxValue = 0) <> (NewValue = 0);
    FMaxValue := NewValue;
    if Z and FLCheckMaxValue then
    begin
      SetCheckMaxValue(CheckDefaultRange(True));
      if b and FLCheckMinValue then
        SetCheckMinValue(CheckDefaultRange(False));
    end;
    SetValue(Value);
  end;
end;

procedure TJvCustomSpinEdit.SetMinValue(NewValue: Extended);
var
  Z: Boolean;
  b: Boolean;
begin
  if NewValue <> FMinValue then
  begin
    b := not StoreCheckMinValue;
    Z := (FMinValue = 0) <> (NewValue = 0);
    FMinValue := NewValue;
    if Z and FLCheckMinValue then
    begin
      SetCheckMinValue(CheckDefaultRange(False));
      if b and FLCheckMaxValue then
        SetCheckMaxValue(CheckDefaultRange(True));
    end;
    SetValue(Value);
  end;
end;

procedure TJvCustomSpinEdit.SetThousands(Value: Boolean);
begin
  if ValueType <> vtHex then
    FThousands := Value;
end;

procedure TJvCustomSpinEdit.SetValueType(NewType: TValueType);
begin
  if FValueType <> NewType then
  begin
    FValueType := NewType;
    Value := GetValue;
    if FValueType in [ vtInteger , vtHex] then
    begin
      FIncrement := Round(FIncrement);
      if FIncrement = 0 then
        FIncrement := 1;
    end;
    if FValueType = vtHex then
      Thousands := False;
  end;
end;

function TJvCustomSpinEdit.StoreCheckMaxValue: Boolean;
begin
  Result := (FMaxValue = 0) and (FCheckMaxValue = (FMinValue = 0));
end;

function TJvCustomSpinEdit.StoreCheckMinValue: Boolean;
begin
  Result := (FMinValue = 0) and (FCheckMinValue = (FMaxValue = 0));
end;

procedure TJvCustomSpinEdit.UpClick(Sender: TObject);
var
  OldText: string;
begin
  if ReadOnly then
    DoBeepOnError
  else
  begin
    FChanging := True;
    try
      OldText := inherited Text;
      Value := Value + FIncrement;
    finally
      FChanging := False;
    end;
    if AnsiCompareText(inherited Text, OldText) <> 0 then
    begin
      Modified := True;
      Change;
    end;
    if Assigned(FOnTopClick) then
      FOnTopClick(Self);
  end;
end;

procedure TJvCustomSpinEdit.UpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  if TabStop and CanFocus then
    SetFocus;
  case Button of
    btNext:
      UpClick(Sender);
    btPrev:
      DownClick(Sender);
  end;
end;

//=== { TJvSpinButton } ======================================================

procedure TJvSpinButton.BottomClick;
begin
  if Assigned(FOnBottomClick) then
  begin
    FOnBottomClick(Self);
    if not (csLButtonDown in ControlState) then
      FDown := sbNotDown;
  end;
end;

procedure TJvSpinButton.CheckButtonBitmaps;
begin
  if Assigned(FButtonBitmaps) and
    ((TSpinButtonBitmaps(FButtonBitmaps).Height <> Height) or
     (TSpinButtonBitmaps(FButtonBitmaps).Width <> Width)) then
    RemoveButtonBitmaps;

  if FButtonBitmaps = nil then
  begin
    FButtonBitmaps := SpinButtonBitmapsManager.WantButtons(Width, Height, ButtonStyle,
      not FUpBitmap.Empty or not FDownBitmap.Empty);
    TSpinButtonBitmaps(FButtonBitmaps).AddClient;
  end;
end;

procedure TJvSpinButton.CMSysColorChange(var Msg: TMessage);
begin
  // The buttons we draw are buffered, thus we need to repaint them to theme changes etc.
  if FButtonBitmaps <> nil then
    TSpinButtonBitmaps(FButtonBitmaps).Reset;
end;

constructor TJvSpinButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtonStyle := sbsDefault;
  FUpBitmap := TBitmap.Create;
  FDownBitmap := TBitmap.Create;
  FUpBitmap.OnChange := GlyphChanged;
  FDownBitmap.OnChange := GlyphChanged;
  Height := 20;
  Width := 20;
  FLastDown := sbNotDown;
  FButtonBitmaps := nil;

  SpinButtonBitmapsManager.AddClient;
end;

destructor TJvSpinButton.Destroy;
begin
  RemoveButtonBitmaps;
  SpinButtonBitmapsManager.RemoveClient;

  FUpBitmap.Free;
  FDownBitmap.Free;
  FRepeatTimer.Free;
  inherited Destroy;
end;

function TJvSpinButton.GetDownGlyph: TBitmap;
begin
  Result := FDownBitmap;
end;

function TJvSpinButton.GetUpGlyph: TBitmap;
begin
  Result := FUpBitmap;
end;

procedure TJvSpinButton.GlyphChanged(Sender: TObject);
begin
  if Sender is TBitmap then
  (Sender as TBitmap).Transparent := True;
  RemoveButtonBitmaps;
  Invalidate;
end;

procedure TJvSpinButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    if (FFocusControl <> nil) and FFocusControl.TabStop and
      FFocusControl.CanFocus and (GetFocus <> FFocusControl.Handle) then
      FFocusControl.SetFocus;
    if FDown = sbNotDown then
    begin
      FLastDown := FDown;
      //>Polaris
      if ((FButtonStyle = sbsDefault) and (Y > (-(Height / Width) * X + Height))) or
        ((FButtonStyle = sbsClassic) and (Y > (Height div 2))) then
      begin
        FDown := sbBottomDown;
        BottomClick;
      end
      else
      begin
        FDown := sbTopDown;
        TopClick;
      end;
      if FLastDown <> FDown then
      begin
        FLastDown := FDown;
        Repaint;
      end;
      if FRepeatTimer = nil then
        FRepeatTimer := TTimer.Create(Self);
      FRepeatTimer.OnTimer := TimerExpired;
      FRepeatTimer.Interval := InitRepeatPause;
      FRepeatTimer.Enabled := True;
    end;
    FDragging := True;
  end;
end;



function TJvSpinButton.MouseInBottomBtn(const P: TPoint): Boolean;
begin
  with P do
    Result :=
      ((FButtonStyle = sbsDefault)) and (Y > (-(Width / Height) * X + Height)) or
      ((FButtonStyle = sbsClassic) and (Y > (Height div 2)));
end;



procedure TJvSpinButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TSpinButtonState;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
    begin
      NewState := FDown;
      //>Polaris
      if MouseInBottomBtn(Point(X, Y)) then
      begin
        if FDown <> sbBottomDown then
        begin
          if FLastDown = sbBottomDown then
            FDown := sbBottomDown
          else
            FDown := sbNotDown;
          if NewState <> FDown then
            Repaint;
        end;
      end
      else
      begin
        if FDown <> sbTopDown then
        begin
          if FLastDown = sbTopDown then
            FDown := sbTopDown
          else
            FDown := sbNotDown;
          if NewState <> FDown then
            Repaint;
        end;
      end;
    end
    else
    if FDown <> sbNotDown then
    begin
      FDown := sbNotDown;
      Repaint;
    end;
  end 
end;

procedure TJvSpinButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    FDragging := False;
    if (X >= 0) and (X <= Width) and (Y >= 0) and (Y <= Height) then
    begin
      FDown := sbNotDown;
      FLastDown := sbNotDown;
      Repaint;
    end;
  end;
end;

procedure TJvSpinButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TJvSpinButton.Paint;
begin
  CheckButtonBitmaps;

  if not Enabled and not (csDesigning in ComponentState) then
    FDragging := False;
 
  TSpinButtonBitmaps(FButtonBitmaps).Draw(Canvas, FDown, Enabled, False, False); 
  if not FUpBitmap.Empty or not FDownBitmap.Empty then
    TSpinButtonBitmaps(FButtonBitmaps).DrawGlyphs(Canvas, FDown, Enabled, FUpBitmap, FDownBitmap);
end;

procedure TJvSpinButton.RemoveButtonBitmaps;
begin
  if Assigned(FButtonBitmaps) then
  begin
    TSpinButtonBitmaps(FButtonBitmaps).RemoveClient;
    FButtonBitmaps := nil;
  end;
end;

procedure TJvSpinButton.SetButtonStyle(Value: TJvSpinButtonStyle);
begin
  if Value <> FButtonStyle then
  begin
    FButtonStyle := Value;
    GlyphChanged(Self);
  end;
end;

procedure TJvSpinButton.SetDown(Value: TSpinButtonState);
var
  OldState: TSpinButtonState;
begin
  OldState := FDown;
  FDown := Value;
  if OldState <> FDown then
    Repaint;
end;

procedure TJvSpinButton.SetDownGlyph(Value: TBitmap);
begin
  if Value <> nil then
    FDownBitmap.Assign(Value)
  else
    FDownBitmap.Handle := NullHandle;
end;

procedure TJvSpinButton.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

procedure TJvSpinButton.SetUpGlyph(Value: TBitmap);
begin
  if Value <> nil then
    FUpBitmap.Assign(Value)
  else
    FUpBitmap.Handle := NullHandle;
end;

procedure TJvSpinButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FDown <> sbNotDown) and MouseCapture then
  begin
    try
      if FDown = sbBottomDown then
        BottomClick
      else
        TopClick;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TJvSpinButton.TopClick;
begin
  if Assigned(FOnTopClick) then
  begin
    FOnTopClick(Self);
    if not (csLButtonDown in ControlState) then
      FDown := sbNotDown;
  end;
end;

//=== { TJvSpinEdit } ========================================================

// (rom) quite unusual not to have it in the Custom base class

constructor TJvSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text := '0';
end;

function TJvSpinEdit.GetValue: Extended;
begin
  try
    case ValueType of
      vtFloat:
        begin
          if FDisplayFormat <> '' then
          try
            Result := StrToFloat(TextToValText(Text));
          except
            Result := FMinValue;
          end
          else
          if not TextToFloat(PChar(RemoveThousands(Text)), Result, fvExtended) then
            Result := FMinValue;
        end;
      vtHex:
        Result := StrToIntDef('$' + Text, Round(FMinValue));
    else {vtInteger}
      Result := StrToIntDef(RemoveThousands(Text), Round(FMinValue));
    end;
  except
    if ValueType = vtFloat then
      Result := FMinValue
    else
      Result := Round(FMinValue);
  end;
end;

procedure TJvSpinEdit.SetValue(NewValue: Extended);
var
  FloatFormat: TFloatFormat;
  WasModified: Boolean;
begin
  if Thousands then
    FloatFormat := ffNumber
  else
    FloatFormat := ffFixed;

  { Changing EditText sets Modified to false }
  WasModified := Modified;
  try
    case ValueType of
      vtFloat:
        if FDisplayFormat <> '' then
          Text := FormatFloat(FDisplayFormat, CheckValue(NewValue))
        else
          Text := FloatToStrF(CheckValue(NewValue), FloatFormat, 15, FDecimal);
      vtHex:
        if ValueType = vtHex then
          Text := IntToHex(Round(CheckValue(NewValue)), 1);
    else {vtInteger}
      //Text := IntToStr(Round(CheckValue(NewValue)));
      Text := FloatToStrF(CheckValue(NewValue), FloatFormat, 15, 0);
    end;
    DataChanged;
  finally
    Modified := WasModified;
  end;
end;

//=== { TJvUpDown } ==========================================================

constructor TJvUpDown.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Orientation := udVertical;
  Min := -1;
  Max := 1;
  Position := 0;
end;

destructor TJvUpDown.Destroy;
begin
  OnClick := nil;
  inherited Destroy;
end;

procedure TJvUpDown.Resize;
begin
  if Width <> DefBtnWidth then
    Width := DefBtnWidth
  else
    inherited Resize;
end;




procedure TJvUpDown.Click(Button: TUDBtnType);
var
  Pos: Integer;
begin
  if not FChanging then
  begin
    FChanging := True;
    try
      Pos := Position;
      UpdatePosition(0);
    finally
      FChanging := False;
    end;
    if Pos < 0 then
      inherited Click(btPrev)
    else
      inherited Click(btPrev)
  end;
end;


//=== { TSpinButtonBitmaps } =================================================

procedure TSpinButtonBitmaps.AddClient;
begin
  Inc(FClientCount);
end;

function TSpinButtonBitmaps.CompareWith(const AWidth, AHeight: Integer;
  const AStyle: TJvSpinButtonStyle; const ACustomGlyphs: Boolean): Integer;
begin
  // used by the binary search
  Result := Self.Width - AWidth;
  if Result = 0 then
  begin
    Result := Self.Height - AHeight;
    if Result = 0 then
    begin
      Result := Ord(Self.Style) - Ord(AStyle);
      if Result = 0 then
        Result := Ord(Self.CustomGlyphs) - Ord(ACustomGlyphs);
    end;
  end;
end;

constructor TSpinButtonBitmaps.Create(AManager: TSpinButtonBitmapsManager;
  const AWidth, AHeight: Integer; const AStyle: TJvSpinButtonStyle; const ACustomGlyphs: Boolean);
begin
  inherited Create;
  FManager := AManager;
  FWidth := AWidth;
  FHeight := AHeight;
  FStyle := AStyle;
  FCustomGlyphs := ACustomGlyphs;

  FTopDownBtn := TBitmap.Create;
  FBottomDownBtn := TBitmap.Create;
  FNotDownBtn := TBitmap.Create;
  FDisabledBtn := TBitmap.Create; 

  DrawAllBitmap;
end;

destructor TSpinButtonBitmaps.Destroy;
begin
  FManager.Remove(Self);

  FTopDownBtn.Free;
  FBottomDownBtn.Free;
  FNotDownBtn.Free;
  FDisabledBtn.Free; 

  inherited Destroy;
end;

procedure TSpinButtonBitmaps.Draw(ACanvas: TCanvas;
  const ADown: TSpinButtonState; const AEnabled, AMouseInTopBtn, AMouseInBottomBtn: Boolean);
begin
  if FResetOnDraw then
  begin
    DrawAllBitmap;
    FResetOnDraw := False;
  end;

  with ACanvas do
    if not AEnabled then
      Draw(0, 0, FDisabledBtn)
    else
      case ADown of
        sbNotDown: 
            Draw(0, 0, FNotDownBtn);
        sbTopDown:
          Draw(0, 0, FTopDownBtn);
        sbBottomDown:
          Draw(0, 0, FBottomDownBtn);
      end;
end;

procedure TSpinButtonBitmaps.DrawAllBitmap;
begin 

  DrawBitmap(FTopDownBtn, sbTopDown, True);
  DrawBitmap(FBottomDownBtn, sbBottomDown, True);
  DrawBitmap(FNotDownBtn, sbNotDown, True);
  DrawBitmap(FDisabledBtn, sbNotDown, False);
end;



procedure TSpinButtonBitmaps.DrawBitmap(ABitmap: TBitmap;
  ADownState: TSpinButtonState; const Enabled: Boolean);
const
  CColors: TColorArray = (clBtnShadow, clBtnHighlight, cl3DDkShadow);
var
  ButtonRect: TRect;
  LColors: TColorArray;
  UpArrow, DownArrow: TBitmap;

  procedure JvDraw;
  var
    TopFlags, BottomFlags: DWORD;
    R: TRect;
  begin
    TopFlags := EDGE_RAISED;
    BottomFlags := EDGE_RAISED;
    R := ButtonRect;

    with ABitmap.Canvas do
    begin 
      Start; 
      LColors := CColors;
      if ADownState = sbTopDown then
      begin
        LColors[0] := clBtnFace;
        LColors[2] := clBtnHighlight;
        TopFlags := EDGE_SUNKEN;
      end;
      if ADownState = sbBottomDown then
      begin
        LColors[1] := clWindowFrame;
        LColors[2] := clBtnShadow;
        BottomFlags := EDGE_SUNKEN;
      end;
      DrawEdge(Handle, R, TopFlags, BF_TOPLEFT or BF_SOFT);
      DrawEdge(Handle, R, BottomFlags, BF_BOTTOMRIGHT or BF_SOFT);
      InflateRect(R, -1, -1);

      Pen.Color := LColors[0];
      MoveTo(R.Left, R.Bottom - 2);
      LineTo(R.Right - 1, R.Top - 1);

      Pen.Color := LColors[2];
      MoveTo(R.Right - 1, R.Top);
      LineTo(R.Right - 1, R.Top);
      LineTo(R.Left, R.Bottom - 1);

      Pen.Color := LColors[1];
      MoveTo(R.Left + 1, R.Bottom - 1);
      LineTo(R.Right, R.Top);

      if not CustomGlyphs then
      begin
        UpArrow.LoadFromResourceName(HInstance, sSpinUpBtn);
        UpArrow.TransparentColor := clWhite;
        UpArrow.Transparent := True;
        DownArrow.LoadFromResourceName(HInstance, sSpinDownBtn);
        DownArrow.TransparentColor := clWhite;
        DownArrow.Transparent := True;
        JvDrawArrows(ABitmap.Canvas, ADownState, Enabled, UpArrow, DownArrow);
      end; 
      Stop; 
    end;
  end;

  procedure PoleDraw;
  var
    H: Integer;
    TopFlags, BottomFlags: DWORD;
    R, R1: TRect;
    RSrc: TRect;
  begin
    TopFlags := EDGE_RAISED;
    BottomFlags := EDGE_RAISED;

    with ABitmap.Canvas do
    begin 
      Start; 
      { top glyph }
      H := Height div 2;
      R := Bounds(0, 0, Width, H);
      if ADownState = sbTopDown then
        TopFlags := EDGE_SUNKEN
      else
        R.Bottom := R.Bottom + 1;
      if ADownState = sbBottomDown then
        BottomFlags := EDGE_SUNKEN;
      RSrc := R;
      DrawEdge(Handle, R, TopFlags, BF_RECT or BF_SOFT or BF_ADJUST);
      R1 := Bounds(0, H, Width, Height);
      R1.Bottom := Height;
      DrawEdge(Handle, R1, BottomFlags, BF_RECT or BF_SOFT or BF_ADJUST);
      if not CustomGlyphs then
      begin
        UpArrow.LoadFromResourceName(HInstance, sSpinUpBtnPole);
        UpArrow.TransparentColor := clWhite;
        UpArrow.Transparent := True;
        DownArrow.LoadFromResourceName(HInstance, sSpinDownBtnPole);
        DownArrow.TransparentColor := clWhite;
        DownArrow.Transparent := True;
        PoleDrawArrows(ABitmap.Canvas, ADownState, Enabled, UpArrow, DownArrow);
      end; 
      Stop; 
    end;
  end;

begin
  UpArrow := nil;
  DownArrow := nil;
  try
    if not CustomGlyphs then
    begin
      UpArrow := TBitmap.Create;
      DownArrow := TBitmap.Create;
    end;

    ABitmap.Height := Height;
    ABitmap.Width := Width;

    with ABitmap.Canvas do
    begin
      ButtonRect := Bounds(0, 0, Width, Height);
      Pen.Width := 1;
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      FillRect(ButtonRect);
    end;
    if FStyle = sbsClassic then
      PoleDraw
    else
      JvDraw;
  finally
    UpArrow.Free;
    DownArrow.Free;
  end;
end;



procedure TSpinButtonBitmaps.DrawGlyphs(ACanvas: TCanvas; const AState: TSpinButtonState; const Enabled: Boolean;
  AUpArrow, ADownArrow: TBitmap);
begin 
  if FStyle = sbsClassic then
    PoleDrawArrows(ACanvas, AState, Enabled, AUpArrow, ADownArrow)
  else
    JvDrawArrows(ACanvas, AState, Enabled, AUpArrow, ADownArrow)
end;

procedure TSpinButtonBitmaps.JvDrawArrows(ACanvas: TCanvas; const AState: TSpinButtonState;
  const Enabled: Boolean; AUpArrow, ADownArrow: TBitmap);
var
  Dest, Source: TRect;
  DeltaRect: Integer;
  DisabledBitmap: TBitmap;
begin
  { buttons }
  with ACanvas do
  begin
    { top glyph }
    DeltaRect := 1;
    if AState = sbTopDown then
      Inc(DeltaRect);

    Dest := Bounds(Round((Width / 4) - (AUpArrow.Width / 2)) + DeltaRect,
      Round((Height / 4) - (AUpArrow.Height / 2)) + DeltaRect, AUpArrow.Width,
      AUpArrow.Height);
    Source := Bounds(0, 0, AUpArrow.Width, AUpArrow.Height);

    if Enabled then
      BrushCopy( ACanvas,  Dest, AUpArrow, Source, AUpArrow.TransparentColor)
    else
    begin
      DisabledBitmap := CreateDisabledBitmap(AUpArrow, clBlack);
//        DisabledBitmap := CreateMonoBitmap(AUpArrow, clWhite);//, clBlack);
      try
        BrushCopy( ACanvas,  Dest, DisabledBitmap, Source, DisabledBitmap.TransparentColor);
      finally
        DisabledBitmap.Free;
      end;
    end;

    { bottom glyph }
    Dest := Bounds(Round((3 * Width / 4) - (ADownArrow.Width / 2)) - 1,
      Round((3 * Height / 4) - (ADownArrow.Height / 2)) - 1,
      ADownArrow.Width, ADownArrow.Height);
    Source := Bounds(0, 0, ADownArrow.Width, ADownArrow.Height);

    if Enabled then
      BrushCopy( ACanvas,  Dest, ADownArrow, Source, ADownArrow.TransparentColor)
    else
    begin
      DisabledBitmap := CreateDisabledBitmap(ADownArrow, clBlack);
//      DisabledBitmap := CreateMonoBitmap(ADownArrow, clWhite);
      try
        BrushCopy( ACanvas,  Dest, DisabledBitmap, Source, DisabledBitmap.TransparentColor);
      finally
        DisabledBitmap.Free;
      end;
    end;
  end;
end;

procedure TSpinButtonBitmaps.PoleDrawArrows(ACanvas: TCanvas;
  const AState: TSpinButtonState; const Enabled: Boolean; AUpArrow, ADownArrow: TBitmap);
var
  X, Y, I, J, H: Integer;
  R1: TRect;
  R: TRect;
  DisabledBitmap: TBitmap;
begin
  with ACanvas do
  begin
    H := Height div 2;
    R := Bounds(0, 0, Width, H);
    if AState = sbTopDown then
    else
      R.Bottom := R.Bottom + 1;
    R1 := Bounds(0, H, Width, Height);
    R1.Bottom := Height;
    I := R.Bottom - R.Top - 1;
    J := R1.Bottom - R1.Top - 1;
    Y := R.Top + (H - AUpArrow.Height) div 2;
    if AState = sbTopDown then
      OffsetRect(R1, 0, 1);

    R1.Bottom := R1.Top + I;
    if J - AUpArrow.Height < 0 then
      Y := R.Top;
    X := (Width - AUpArrow.Width) div 2;

    IntersectClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
    if Enabled then
      Draw(X, Y, AUpArrow)
    else
    begin
//      DisabledBitmap := CreateDisabledBitmap(AUpArrow, clBlack);
      DisabledBitmap := CreateMonoBitmap(AUpArrow, clWhite);
      try
        Draw(X, Y, DisabledBitmap);
      finally
        DisabledBitmap.Free;
      end;
    end;
    SelectClipRgn(Handle, 0);
    X := (Width - ADownArrow.Width) div 2;
    Y := R1.Top + (I - ADownArrow.Height) div 2;
    if I - ADownArrow.Height < 0 then
    begin
      Dec(R1.Top);
      Y := R1.Bottom - ADownArrow.Height
    end;

    IntersectClipRect(Handle, R1.Left, R1.Top, R1.Right, R1.Bottom);
    if Enabled then
      Draw(X, Y, ADownArrow)
    else
    begin
      DisabledBitmap := CreateMonoBitmap(ADownArrow, clWhite);
      try
        Draw(X, Y, DisabledBitmap);
      finally
        DisabledBitmap.Free;
      end;
    end;
    SelectClipRgn(Handle, 0);
  end;
end;

procedure TSpinButtonBitmaps.RemoveClient;
begin
  Dec(FClientCount);
  if FClientCount = 0 then
    Self.Free;
end;

procedure TSpinButtonBitmaps.Reset;
begin
  FResetOnDraw := True;
end;

//=== { TSpinButtonBitmapsManager } ==========================================

procedure TSpinButtonBitmapsManager.AddClient;
begin
  Inc(FClientCount);
end;

constructor TSpinButtonBitmapsManager.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TSpinButtonBitmapsManager.Destroy;
begin
  while FList.Count > 0 do
    // this will implicitly remove the object from the list
    TObject(FList[0]).Free;

  FList.Free;
  inherited Destroy;
end;

function TSpinButtonBitmapsManager.Find(const Width, Height: Integer;
  const AButtonStyle: TJvSpinButtonStyle; const ACustomGlyphs: Boolean;
  var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  // same binary search as Classes.TStringList.Find
  Result := False;
  L := 0;
  H := FList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := TSpinButtonBitmaps(FList[I]).CompareWith(Width, Height, AButtonStyle, ACustomGlyphs);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TSpinButtonBitmapsManager.Remove(Obj: TObject);
begin
  FList.Remove(Obj);
end;

procedure TSpinButtonBitmapsManager.RemoveClient;
begin
  Dec(FClientCount);
  if FClientCount = 0 then
  begin
    if Self = GSpinButtonBitmapsManager then
      GSpinButtonBitmapsManager := nil;
    Self.Free;
  end;
end;

function TSpinButtonBitmapsManager.WantButtons(const Width, Height: Integer;
  const AButtonStyle: TJvSpinButtonStyle; const ACustomGlyphs: Boolean): TSpinButtonBitmaps;
var
  Index: Integer;
begin
  if not Find(Width, Height, AButtonStyle, ACustomGlyphs, Index) then
    FList.Insert(Index, TSpinButtonBitmaps.Create(Self, Width, Height, AButtonStyle, ACustomGlyphs));
  Result := TSpinButtonBitmaps(FList[Index]);
end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile$';
    Revision: '$Revision$';
    Date: '$Date$';
    LogPath: 'JVCL\run'
  );

initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
