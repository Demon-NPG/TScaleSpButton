{                                   NPG Inc@ 2021г.
                                  npgincor@gmail.com

1. Для платформы ANDROID снято ограничение на фиксированную высоту кнопки =48;
2. Добавлено новое свойство ScaleGlyph, позволяющее масштабировать картинку внутри кнопки;
3. Добавлено новое свойство ScaleGlyphAlign, позволяющее задавать положение картинки кнопки.}


unit ScaleSpButton;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.StdCtrls, Rtti, System.UITypes;

type

  TScaleSpeedButton = class(TSpeedButton)

  private
    { Private declarations }
    FScaleGlyph : Single;
    FOnScaleGlyphChange : TNotifyEvent;
    FScaleGlyphAlign : TAlignLayout;
    procedure SetScaleGlyph(const Value: Single);
  protected
    { Protected declarations }
    function ReturnSacale (Scale:Single): Single;
    procedure Paint; override;
    procedure AdjustFixedSize(const Ref: TControl); override;
    procedure ResizeGlyph(Sender : TObject);
    property OnScaleGlyphChange : TNotifyEvent read  FOnScaleGlyphChange write FOnScaleGlyphChange;
    procedure DoOnScaleGlyphChange; virtual;
    function GetDefaultStyleLookupName: string; override;
  public
    { Public declarations }
    Constructor Create( AOwner: TComponent); override;
  published
    { Published declarations }
    property ScaleGlyph : Single read FScaleGlyph write SetScaleGlyph;
    property ScaleGlyphAlign : TAlignLayout  read FScaleGlyphAlign write FScaleGlyphAlign;

  end;


procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('NPG Comp', [TScaleSpeedButton]);
  RegisterFmxClasses([TScaleSpeedButton]);
end;

constructor TScaleSpeedButton.Create( AOwner: TComponent );
begin
inherited Create(AOwner);
  Height:=48;
  Width:=48;
  FScaleGlyph := 1;
  AdjustFixedSize(self);
  FScaleGlyphAlign := TAlignLayout.Center;
  StylesData['glyphstyle.align'] := TValue.From<TAlignLayout>(FScaleGlyphAlign);
  Self.GetDefaultStyleLookupName;
end;



procedure TScaleSpeedButton.Resizeglyph(Sender : TObject);
begin
  FScaleGlyph := ReturnSacale(Abs(FScaleGlyph));
  StylesData['glyphstyle.align'] := TValue.From<TAlignLayout>(FScaleGlyphAlign);
  StylesData['glyphstyle.Height'] := Height*FScaleGlyph;
  StylesData['glyphstyle.Width'] := Width*FScaleGlyph;
end;

procedure TScaleSpeedButton.Paint;
begin
inherited Paint;
   Resizeglyph(Self);
end;

procedure TScaleSpeedButton.SetScaleGlyph(const Value: Single);
begin
  if FScaleGlyph <> Value then
     FScaleGlyph := Value;
 DoOnScaleGlyphChange;
end;

procedure TScaleSpeedButton.DoOnScaleGlyphChange;
begin
  if  Assigned(FOnScaleGlyphChange) then FOnScaleGlyphChange(Self);
 Paint;
end;


procedure TScaleSpeedButton.AdjustFixedSize(const Ref: TControl);
begin
  SetAdjustType(TAdjustType.None);
end;

function TScaleSpeedButton.ReturnSacale (scale: single):single;
begin
  if scale <= 1 then
 Result := scale
  else
 Result := 1;
end;

function TScaleSpeedButton.GetDefaultStyleLookupName: string;
begin
  Result := Self.GetParentClassStyleLookupName;
end;



end.
