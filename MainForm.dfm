object Form1: TForm1
  Left = 1045
  Top = 366
  Caption = 'EZClient Delphi Demo'
  ClientHeight = 511
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000000200000000
    0000000000001000000010000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    00000000000000000000000000000009999999F0000000F00000000000000009
    999999F0000000F777700000000000099FFFFFF000FFFFF00000000000000009
    90009930000800800B0000000000000999999F3F000080807B00000000000009
    99999F30F00008800B000000000000099FFFFF30FF0000807B00000000000009
    9000993FF8F000F00B00000000000009999999F0000000F70B00000000000009
    999999F0000000F8700000000000000FFFFFFFFFFFFFFFF88707000000000000
    000099300000000F88707000000000000000993000000000F887070000000000
    000099300000000F0088707777700000000099300000000FF0F8870000070000
    000099300000000FBB0F88777770000000009970000000000000F88FF8870000
    00009930000000008000F8700F87000000000000000000008000F70000F70700
    00000800000000008000F70880F7007000770807007700008000F8700F0F0007
    07000800770070008000F88770F00070000788870077007080000FFFF7000087
    777888887787000F870000000000000F888888888888000F8700000000000000
    FFFFFFFF0088070F8700000000000000000000000000700F8700000000000000
    000000000000000FF70000000000000000000000000000000000000000000000
    0000000000000000000000000000FFFFFFFFFFFFFFFFE0001FFFE00001FFE000
    01FFE600C1FFE00041FFE00001FFE00001FFE60001FFE00001FFE00001FFE000
    00FFFE0FC07FFE0FC03FFE0FC001FE0FC000FE0FC000FE0FE200FE0FE200FE0F
    E218BF1FE2009C0CE200880062008000420180004181C00041FFE00001FFF00C
    41FFFFFFC1FFFFFFC1FFFFFFFFFF280000001000000020000000010004000000
    0000800000000000000000000000100000001000000000000000000080000080
    000000808000800000008000800080800000C0C0C000808080000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000000007B000000999
    9F0000F0000009FFF300FFF000000999F3F007B0000009FFF3FF00B000000999
    9F0000F0000000FFF3FFFFF800000000930000788088000093007F0788080000
    9300700070000000000000008080000878000000F0007008780800000F000F77
    77770F800000000000000F8000000000000000000000FF0F0000800F0000800F
    0000800F0000800F0000800F0000C00F0000E1040000E1000000E1000000E191
    00006390000020980000809F0000C29F0000FF9F0000}
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    752
    511)
  PixelsPerInch = 96
  TextHeight = 13
  object MsgList: TListBox
    Left = 8
    Top = 190
    Width = 744
    Height = 325
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  object edServerAddress: TEdit
    Left = 136
    Top = 8
    Width = 313
    Height = 21
    TabOrder = 1
    Text = 'localhost'
    OnChange = edServerAddressChange
  end
  object staticServer: TStaticText
    Left = 58
    Top = 12
    Width = 63
    Height = 17
    Alignment = taCenter
    Caption = 'EZForecourt'
    TabOrder = 2
  end
  object chProcEvents: TCheckBox
    Left = 480
    Top = 8
    Width = 169
    Height = 17
    Caption = 'Processar por Eventos'
    TabOrder = 3
    OnClick = chProcEventsClick
  end
  object btLogon: TButton
    Left = 8
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Logon'
    TabOrder = 4
    OnClick = btLogonClick
  end
  object btCheckConnection: TButton
    Left = 136
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Verifica Conex'#227'o'
    TabOrder = 5
    OnClick = btCheckConnectionClick
  end
  object btLoadConfig: TButton
    Left = 263
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Carrega Configura'#231#227'o'
    TabOrder = 6
    OnClick = btLoadConfigClick
  end
  object btGetAllDeliveries: TButton
    Left = 390
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Ler Abastecimentos'
    TabOrder = 7
    OnClick = btGetAllDeliveriesClick
  end
  object btClearMessages: TButton
    Left = 519
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Limpa Mensagens'
    TabOrder = 8
    OnClick = btClearMessagesClick
  end
  object btPreset: TButton
    Left = 519
    Top = 122
    Width = 113
    Height = 25
    Caption = 'Predetermina'#231#227'o'
    TabOrder = 9
    OnClick = btPresetClick
  end
  object PriceChange: TButton
    Left = 519
    Top = 91
    Width = 113
    Height = 25
    Caption = 'Trocar Pre'#231'o'
    TabOrder = 10
    OnClick = PriceChangeClick
  end
  object cbPump: TComboBox
    Left = 136
    Top = 66
    Width = 113
    Height = 21
    TabOrder = 11
  end
  object cbHose: TComboBox
    Left = 390
    Top = 66
    Width = 113
    Height = 21
    TabOrder = 12
  end
  object staticPump: TStaticText
    Left = 85
    Top = 66
    Width = 36
    Height = 17
    Alignment = taCenter
    Caption = 'Bomba'
    TabOrder = 13
  end
  object staticHose: TStaticText
    Left = 350
    Top = 66
    Width = 23
    Height = 17
    Alignment = taCenter
    Caption = 'Bico'
    TabOrder = 14
  end
  object edtPrice1: TMaskEdit
    Left = 136
    Top = 93
    Width = 113
    Height = 21
    EditMask = '#,000'
    MaxLength = 5
    TabOrder = 15
    Text = ' ,   '
  end
  object edtPrice2: TMaskEdit
    Left = 390
    Top = 93
    Width = 113
    Height = 21
    EditMask = '#,000'
    MaxLength = 5
    TabOrder = 16
    Text = ' ,   '
  end
  object edtPreset: TMaskEdit
    Left = 390
    Top = 124
    Width = 111
    Height = 21
    EditMask = '#0,000'
    MaxLength = 6
    TabOrder = 17
    Text = '  ,   '
  end
  object StaticText1: TStaticText
    Left = 81
    Top = 99
    Width = 40
    Height = 17
    Alignment = taRightJustify
    Caption = 'Pre'#231'o 1'
    TabOrder = 18
  end
  object StaticText2: TStaticText
    Left = 333
    Top = 99
    Width = 40
    Height = 17
    Caption = 'Pre'#231'o 2'
    TabOrder = 19
  end
  object cbPresetType: TComboBox
    Left = 266
    Top = 126
    Width = 110
    Height = 21
    TabOrder = 20
  end
  object btAuthorize: TButton
    Left = 8
    Top = 159
    Width = 113
    Height = 25
    Caption = 'Autoriza Bomba'
    TabOrder = 21
    OnClick = btAuthorizeClick
  end
  object btLock: TButton
    Left = 136
    Top = 159
    Width = 113
    Height = 25
    Caption = 'Bloqueia Bomba'
    TabOrder = 22
    OnClick = btLockClick
  end
  object btTotals: TButton
    Left = 266
    Top = 159
    Width = 107
    Height = 25
    Caption = 'Ler Encerrantes'
    TabOrder = 23
    OnClick = btTotalsClick
  end
  object btReadCards: TButton
    Left = 390
    Top = 159
    Width = 113
    Height = 25
    Caption = 'Ler Cart'#245'es'
    TabOrder = 24
    OnClick = btReadCardsClick
  end
  object TimerAppLoop: TTimer
    Interval = 300
    OnTimer = TimerAppLoopTimer
    Left = 24
    Top = 72
  end
end
