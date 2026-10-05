unit uService.Imagem;

interface

uses
  Winapi.Windows, System.Classes, System.Types, System.Math, Vcl.Graphics;

type
  TImagemService = class
  public
    procedure GerarMiniatura(Origem: TGraphic; Destino: TMemoryStream; TamanhoMax: Integer);
  end;

implementation

procedure TImagemService.GerarMiniatura(Origem: TGraphic; Destino: TMemoryStream; TamanhoMax: Integer);
var
  Bitmap: TBitmap;
  Proporcao: Double;
begin
  Destino.Clear;

  if (Origem = nil) or (Origem.Width = 0) or (Origem.Height = 0) then
    Exit;

  // Mantém a proporção da foto: o lado maior fica com TamanhoMax pixels
  Proporcao := Min(TamanhoMax / Origem.Width, TamanhoMax / Origem.Height);
  if Proporcao > 1 then
    Proporcao := 1; // não amplia fotos que já são pequenas

  Bitmap := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf24bit;
    Bitmap.SetSize(Round(Origem.Width * Proporcao), Round(Origem.Height * Proporcao));

    // HALFTONE deixa a redução suave, sem serrilhado
    SetStretchBltMode(Bitmap.Canvas.Handle, HALFTONE);
    Bitmap.Canvas.StretchDraw(Rect(0, 0, Bitmap.Width, Bitmap.Height), Origem);

    Bitmap.SaveToStream(Destino);
  finally
    Bitmap.Free;
  end;
end;

end.
