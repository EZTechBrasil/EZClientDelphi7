{
  Empresa     :  EzTech Tecnologia e Automação Ltda
        				 http://www.eztech.ind.br/

  Autor       : Otavio Venezian Junior - 05/03/2012
 				        Sinapse Sistemas para Automacao
         				http://www.sinapseautomacao.com.br

  Descricao   : Programa Delphi 7.0 de demonstracao para interface
                com EZForecourt atravez da biblioteca EZClient.dll

  Observacoes :
}

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Forms, Dialogs, ExtCtrls, Mask, StdCtrls, Classes,
  Controls, EZClient, DateUtils;
{  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EZClient, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, ExtCtrls, Mask, StdCtrls, Classes, Controls; }

type
  TForm1 = class(TForm)
    MsgList: TListBox;
    edServerAddress: TEdit;
    staticServer: TStaticText;
    chProcEvents: TCheckBox;
    btLogon: TButton;
    btCheckConnection: TButton;
    btLoadConfig: TButton;
    btGetAllDeliveries: TButton;
    btClearMessages: TButton;
    TimerAppLoop: TTimer;
    btPreset: TButton;
    PriceChange: TButton;
    cbPump: TComboBox;
    cbHose: TComboBox;
    staticPump: TStaticText;
    staticHose: TStaticText;
    edtPrice1: TMaskEdit;
    edtPrice2: TMaskEdit;
    edtPreset: TMaskEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    cbPresetType: TComboBox;
    btAuthorize: TButton;
    btLock: TButton;
    btTotals: TButton;
    btReadCards: TButton;
    procedure FormCreate(Sender: TObject);
    procedure edServerAddressChange(Sender: TObject);
    procedure chProcEventsClick(Sender: TObject);
    procedure TimerAppLoopTimer(Sender: TObject);
    procedure btClearMessagesClick(Sender: TObject);
    procedure btLogonClick(Sender: TObject);
    procedure btCheckConnectionClick(Sender: TObject);
    procedure btPresetClick(Sender: TObject);
    procedure PriceChangeClick(Sender: TObject);
    procedure btAuthorizeClick(Sender: TObject);
    procedure btLockClick(Sender: TObject);
    procedure btGetAllDeliveriesClick(Sender: TObject);
    procedure btLoadConfigClick(Sender: TObject);
    procedure btTotalsClick(Sender: TObject);
    procedure btReadCardsClick(Sender: TObject);

  private
    { Private declarations }
    lastStatus : WideString;
    EZInterface : TEZClient;   // Objeto TEZClient

    procedure ReadPumpsStatus();
    procedure InternalProccessEvents();

    procedure ListGrades();
    procedure ListTanks();
    procedure ListPumps();
    procedure ListHoses();

    procedure WriteMessage(msg : String );
    procedure SetMsgListScrollBar();

  public
    { Public declarations }

    function GoodResult(res : Integer) : bool;
    function CompanyID(HoseNumber: SmallInt; PumpNumber: SmallInt ) : String;

  end;

//------------------------------------------------------------------------------
Var
  Form1 : TForm1;

implementation

{$R *.dfm}

  //----------------------------------------------------------------------------
  procedure TForm1.FormCreate(Sender: TObject);
  Var
    Version : String;
    Index   : Integer;

  begin
    EZInterface := TEZClient.Create;  // Instancia TEZClient

    //self.edServerAddress.Text := 'localhost';
    //self.edServerAddress.Text := '127.0.0.1';
    //self.edServerAddress.Text := '192.168.0.11';

    if EZInterface.IsLoaded = True then
    begin
      Version := '';
      EZInterface.DllVersion( @Version );
      WriteMessage( Version );
    end;

    chProcEventsClick( self );

    // O correto ao fazer login seria levantar a lista de bombas e bicos
    // para preencher os ComboBox dinamicamente

    // Preenche lista de bombas
    for Index := 1 to 32 do
      cbPump.Items.Add( IntToStr(Index) );

    cbPump.ItemIndex := 0;   // Seleciona primeiro Item da lista

    // Preenche lista de bicos
    for Index := 1 to 4 do
      cbHose.Items.Add( IntToStr(Index) );

    cbHose.ItemIndex := 0;   // Seleciona primeiro Item da lista

    // Preenche lista de tipos de preset
    cbPresetType.Items.Add('Dinheiro');
    cbPresetType.Items.Add('Volume');
    cbPresetType.ItemIndex := 0;

    // Seta lista de estado de bombas
    lastStatus := '00000000000000000000000000000000000000000000000000';

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btAuthorizeClick(Sender: TObject);
  var
    Bomba   : Integer;
    IdBomba : Integer;

  begin

    Bomba := cbPump.ItemIndex+1;   // Le o numero da bomba no combo

    // Verifica conexao
    if not GoodResult( EZInterface.TestConnection ) then
      System.Exit;

    // Pega Id da Bomba escolhida
    if not GoodResult( EZInterface.GetPumpByOrdinal(Bomba, @IdBomba) ) then
      System.Exit;

    // Envia Autorizacao para bomba
    if GoodResult( EZInterface.Authorise(IdBomba) ) then
      WriteMessage('Bomba ' + IntToStr(Bomba) + ' Autorizada!');

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btLoadConfigClick(Sender: TObject);
  begin

    ListGrades();
    ListTanks();
    ListPumps();
    ListHoses();

  end;

  //----------------------------------------------------------------------------
  // Lista configuracao de produtos
  procedure TForm1.ListGrades();
  var
    Idx: Integer;
    Ct: Integer;
    Id: Integer;
    Number: Integer;
    Name: WideString;
    ShortName: WideString;
    Code: WideString;
    Tipo: SmallInt ;

  begin

    WriteMessage( '[Produtos]---------------------------------------------------');

    //--------------------------------------------------------------------
    // Le o numero de produtos configurados
    if not GoodResult( EZInterface.GetGradesCount( @Ct ) ) then
      System.Exit;

    for Idx := 1 to Ct do
    begin

       if not GoodResult( EZInterface.GetGradeByOrdinal( Idx, @Id ) ) then
          System.Exit;

       if GoodResult( EZInterface.GetGradePropertiesEx(Id, @Number, @Name, @ShortName,
                                                @Code, @Tipo) ) then
          WriteMessage( '      Grade: ' + IntToStr(Number) +
                             ', Nome: ' + Name +
                        ', Abreviado: ' + ShortName +
                           ', Codigo: ' + Code +
                           ',   Tipo: ' + IntToStr(Tipo)
                        );
    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.ListTanks();
  var
    Idx: Integer;
    Ct: Integer;
    Id: Integer;
    Number: Integer;
    Name: WideString;
    GradeID: Integer;
    TType: Smallint;
    Capacity: Double;
    Diameter: Double;
    TheoVolume: Double;
    GaugeVolume: Double;
    GaugeTCVolume: Double;
    GaugeUllage: Double;
    GaugeTemperature: Double;
    GaugeLevel: Double;
    GaugeWaterVolume: Double;
    GaugeWaterLevel: Double;
    GaugeID: Integer;
    ProbeNo: Smallint;
    GaugeAlarmsMask: Integer;

  begin

    WriteMessage( '[Tanques]---------------------------------------------------');

    //--------------------------------------------------------------------
    // Le o numero de produtos configurados
    if not GoodResult( EZInterface.GetTanksCount( @Ct ) ) then
      System.Exit;

    for Idx := 1 to Ct do
    begin

       if not GoodResult( EZInterface.GetTankByOrdinal( Idx, @Id ) ) then
          System.Exit;

       if GoodResult( EZInterface.GetTankPropertiesEx(Id, @Number, @Name, @GradeID,
                                                    @TType, @Capacity, @Diameter,
                                                    @TheoVolume, @GaugeVolume,
                                                    @GaugeTCVolume, @GaugeUllage,
                                                    @GaugeTemperature, @GaugeLevel,
                                                    @GaugeWaterVolume, @GaugeWaterLevel,
                                                    @GaugeID, @ProbeNo, @GaugeAlarmsMask ) ) then
          WriteMessage( '     Tanque: ' + IntToStr(Number) +
                             ', Nome: ' + Name +
                          ', Produto: ' + IntToStr(GradeID) +
                             ', Tipo: ' + IntToStr(TType) +
                       ', Capacidade: ' + FloatToStr(Capacity) +
                         ', Diametro: ' + FloatToStr(Diameter) +
                       ', TheoVolume: ' + FloatToStr(TheoVolume) +
                      ', GaugeVolume: ' + FloatToStr(GaugeVolume) +
                    ', GaugeTCVolume: ' + FloatToStr(GaugeTCVolume) +
                      ', GaugeUllage: ' + FloatToStr(GaugeUllage) +
                 ', GaugeTemperature: ' + FloatToStr(GaugeTemperature) +
                       ', GaugeLevel: ' + FloatToStr(GaugeLevel) +
                 ', GaugeWaterVolume: ' + FloatToStr(GaugeWaterVolume) +
                  ', GaugeWaterLevel: ' + FloatToStr(GaugeWaterLevel) +
                          ', GaugeID: ' + IntToStr(GaugeID) +
                          ', ProbeNo: ' + IntToStr(ProbeNo) +
                  ', GaugeAlarmsMask: ' + IntToStr(GaugeAlarmsMask) );

    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.ListPumps();
  var
    Idx: Integer;
    Ct: Integer;
    Id: Integer;
    Number: Integer;
    Name: WideString;
    PhysicalNumber: Smallint;
    Side: Smallint;
    Address: Smallint;
    PriceLevel1: Smallint;
    PriceLevel2: Smallint;
    PriceDspFormat: Smallint;
    VolumeDspFormat: Smallint;
    ValueDspFormat: Smallint;
    PType: Smallint;
    PortID: Integer;
    AttendantID: Integer;
    AuthMode: Smallint;
    StackMode: Smallint;
    PrepayAllowed: Smallint;
    PreauthAllowed: Smallint;
    SlotZigBeeID: Integer;
    MuxSlotZigBeeID: Integer;
    PriceControl: Smallint;
    HasPreset: Smallint;

  begin

    WriteMessage( '[Bombas]---------------------------------------------------');

    //--------------------------------------------------------------------
    // Le o numero de produtos configurados
    if not GoodResult( EZInterface.GetPumpsCount( @Ct ) ) then
      System.Exit;

    for Idx := 1 to Ct do
    begin

       if not GoodResult( EZInterface.GetPumpByOrdinal( Idx, @Id ) ) then
          System.Exit;

       if GoodResult( EZInterface.GetPumpPropertiesEx(Id, @Number, @Name, @PhysicalNumber,
                                                      @Side, @Address, @PriceLevel1,
                                                      @PriceLevel2, @PriceDspFormat,
                                                      @VolumeDspFormat, @ValueDspFormat,
                                                      @PType, @PortID, @AttendantID,
                                                      @AuthMode, @StackMode, @PrepayAllowed,
                                                      @PreauthAllowed, @SlotZigBeeID,
                                                      @MuxSlotZigBeeID, @PriceControl,
                                                      @HasPreset) ) then
          WriteMessage( '            Bomba: ' + IntToStr(Number) +
                                   ', Nome: ' + Name +
                           ', PhicalNumber: ' + IntToStr(PhysicalNumber) +
                                   ', Side: ' + IntToStr(Side) +
                                ', Address: ' + IntToStr(Address) +
                            ', PriceLevel1: ' + IntToStr(PriceLevel1) +
                            ', PriceLevel2: ' + IntToStr(PriceLevel2) +
                         ', PriceDspFormat: ' + IntToStr(PriceDspFormat) +
                        ', VolumeDspFormat: ' + IntToStr(VolumeDspFormat) +
                         ', ValueDspFormat: ' + IntToStr(ValueDspFormat) +
                                  ', PTipe: ' + IntToStr(PType) +
                                 ', PortID: ' + IntToStr(PortID) +
                            ', AttendantID: ' + IntToStr(AttendantID) +
                               ', AutoMode: ' + IntToStr(AuthMode) +
                              ', StackMode: ' + IntToStr(StackMode) +
                           ', PrepayAllwed: ' + IntToStr(PrepayAllowed) +
                         ', PreauthAllowed: ' + IntToStr(PreauthAllowed) +
                           ', SlotZigBeeID: ' + IntToStr(SlotZigBeeID) +
                        ', MuxSlotZigBeeID: ' + IntToStr(MuxSlotZigBeeID) +
                           ', PriceControl: ' + IntToStr(PriceControl) +
                              ', HasPreset: ' + IntToStr(HasPreset) );
    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.ListHoses();
  var
    Idx: Integer;
    Ct: Integer;
    Id: Integer;
    Number: Integer;
    PumpID: Integer;
    TankID: Integer;
    PhysicalNumber: Integer;
    MtrTheoValue: Double;
    MtrTheoVolume: Double;
    MtrElecValue: Double;
    MtrElecVolume: Double;
    UVEAntenna: Smallint;
    Price1: Double;
    Price2: Double;
    Enabled: Smallint;

  begin

    WriteMessage( '[Bicos]---------------------------------------------------');


    //--------------------------------------------------------------------
    // Le o numero de produtos configurados
    if not GoodResult( EZInterface.GetHosesCount( @Ct ) ) then
      System.Exit;

    for Idx := 1 to Ct do
    begin

       if not GoodResult( EZInterface.GetHoseByOrdinal( Idx, @Id ) ) then
          System.Exit;

       if GoodResult( EZInterface.GetHosePropertiesEx2( ID, @Number, @PumpID, @TankID,
                                                        @PhysicalNumber, @MtrTheoValue,
                                                        @MtrTheoVolume, @MtrElecValue,
                                                        @MtrElecVolume, @UVEAntenna,
                                                        @Price1, @Price2,
                                                        @Enabled ) ) then
          WriteMessage( '            Bico: ' + IntToStr(Number) +
                                ', PumpID: ' + IntToStr(PumpID) +
                                ', TankID: ' + IntToStr(TankID) +
                        ', PhisicalNumber: ' + IntToStr(PhysicalNumber) +
                          ', MtrTheoValue: ' + FloatToStr(MtrTheoValue) +
                         ', MtrTheoVolume: ' + FloatToStr(MtrTheoVolume) +
                          ', MtrElecValue: ' + FloatToStr(MtrElecValue) +
                         ', MtrElecVolume: ' + FloatToStr(MtrElecVolume) +
                             ', UVEAntena: ' + IntToStr(UVEAntenna) +
                                ', Price1: ' + FloatToStr(Price1) +
                                ', Price2: ' + FloatToStr(Price2) +
                               ', Enables: ' + IntToStr(Enabled) );
    end;
  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btLockClick(Sender: TObject);
  var
    Bomba   : Integer;
    IdBomba : Integer;

  begin

    Bomba := cbPump.ItemIndex+1;   // Le o numero da bomba no combo

    // Verifica conexao
    if not GoodResult( EZInterface.TestConnection ) then
      System.Exit;

    // Pega Id da Bomba escolhida
    if not GoodResult( EZInterface.GetPumpByOrdinal(Bomba, @IdBomba) ) then
      System.Exit;

    // Envia bloqueio (desautorizacao) para bomba
    if GoodResult( EZInterface.CancelAuthorise(IdBomba) ) then
      WriteMessage('Bomba ' + IntToStr(Bomba) + ' Desautorizada!');

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btLogonClick(Sender: TObject);
  var
    ITmp : Integer;

  begin

    if chProcEvents.Checked = true then
    begin
       ITmp := 7;
    end
    else
       ITmp := 1;

    if edServerAddress.Enabled = True then
    begin
      WriteMessage('Conectando no servidor: ' + edServerAddress.Text);

      if GoodResult( EZInterface.ClientLogonEx( 25, ITmp, edServerAddress.Text, 5123, 5124, 10000, 0, 0, 0) ) then
      begin
        edServerAddress.Enabled := false;
        chProcEvents.Enabled := false;
        btLogon.Caption := 'Logoff';

        EZInterface.SetClientType(70);

        if GoodResult( EZInterface.SetDateTime( Now ) ) then
        begin
          WriteMessage('Data e Hora do concentrador atualizada com sucesso');
        end;


        //self.ReadPumpsStatus;
      end;

    end
    else
    begin

      WriteMessage('Desconectando do servidor: ' + edServerAddress.Text);
      GoodResult( EZInterface.ClientLogoff );

      edServerAddress.Enabled := true;
      chProcEvents.Enabled := true;
      btLogon.Caption := 'Logon';

    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btPresetClick(Sender: TObject);
  var
    Bomba   : Integer;
    Bico    : Integer;
    IdBomba : Integer;
    IdBico  : SmallInt;
    LType   : SmallInt;
    PsValue : Double;

  begin

    Bomba        := cbPump.ItemIndex+1;   // Le o numero da bomba no combo
    Bico         := cbHose.ItemIndex+1;   // Le o numero da bico no combo

    LType        := cbPresetType.ItemIndex+2;  // SmallInt(EZClient.DOLLAR_PRESET_TYPE);
    PsValue      := strtofloat(edtPreset.Text);  // Le valor do campo de predeterminacao

    // Verifica conexao
    if not GoodResult( EZInterface.TestConnection ) then
      System.Exit;

    // Pega Id da Bomba escolhida
    if not GoodResult( EZInterface.GetPumpByOrdinal(Bomba, @IdBomba) ) then
      System.Exit;

    IdBico := 1 shl (Bico-1);  // Calcula ID do bico escolhido

    // Envia preset para bomba
    if( GoodResult( EZInterface.LoadPreset(IdBomba, LType, PsValue, IdBico, 1) ) ) then
      WriteMessage( 'Preset Enviado: Bomba ' + IntToStr(Bomba) +
                                   ', Bico ' + IntToStr(Bico) +
                                   ', Tipo ' + IntToStr(LType) +
                                  ', Valor ' + FloatToStr(PsValue) +
                                  ', Nivel de Preco 1' ) ;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btReadCardsClick(Sender: TObject);
  Var
    CardID:    Integer;
    Number:    Integer ;
    Name:      WideString ;
    PumpID:    Integer ;
    CardType:  Smallint ;
    ParentID:  Integer ;
    Tag:       Int64;
    TimeStamp: TDateTime;

  begin

    // Verifica conexao
    if not GoodResult( EZInterface.TestConnection ) then
      System.Exit;

    while True do
    begin

      // Le ID do primeiro cartao da lista
      if EZInterface.GetCardReadByOrdinal(1, @CardID)<>0 then
        System.Break;

      // LE dados do cartao
      if not GoodResult( EZInterface.GetCardReadProperties(CardID, @Number, @Name, @PumpID, @CardType, @ParentID, @Tag, @TimeStamp) ) then
        System.Break;

      WriteMessage(' --- Cartao Lido: ' +
                                 ' ID= ' + IntToStr(CardID) +
                            ', Numero= ' + IntToStr(Number) +
                              ', Nome= ' + Name +
                            ', PumpID= ' + IntToStr(PumpID) +
                          ', CardType= ' + IntToStr(CardType) +
                          ', ParentID= ' + IntToStr(ParentID) +
                               ', Tag= ' + IntToHex(Tag, 10) +
                         ', TimeStamp= ' + DateTimeToStr(TimeStamp) );

	  // Esta função so funciona se a Autorizacao estiver configurada com um tipo de cartao: 
	  //		"Carta/Placa", "Frentista", "Cliente", "Frentista E Cliente", "Frentista OU Cliente"
      if not GoodResult( EZInterface.TagAuthorise(PumpID, Tag, SmallInt(NO_LIMIT_TYPE), 0, $FF, 1)  ) then
        System.Break;

      WriteMessage(' --- Bomba ' + IntToStr(PumpID) + 'Autorizada com Cartao ' + IntToStr(Tag) );


      // Apaga Cartao da lista
      if not GoodResult( EZInterface.DeleteCardRead(CardID) ) then
        System.Break;

    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btTotalsClick(Sender: TObject);
  var
    IdBomba: Integer;
    IdBico:  Integer;

    Bomba:   Integer;
    Bico:    Integer;

    Number: Integer;
    PumpID: Integer;
    TankID: Integer;
    PhysicalNumber: Integer;
    MtrTheoValue: Double;
    MtrTheoVolume: Double;
    MtrElecValue: Double;
    MtrElecVolume: Double;
    UVEAntenna: Smallint;
    Price1: Double;
    Price2: Double;
    Enabled: Smallint;

  begin

    Bomba        := cbPump.ItemIndex+1;   // Le o numero da bomba no combo
    Bico         := cbHose.ItemIndex+1;   // Le o numero da bico no combo

    // Verifica conexao
    if not GoodResult( EZInterface.TestConnection ) then
      System.Exit;

    // Pega Id da Bomba escolhida
    if not GoodResult( EZInterface.GetPumpByOrdinal(Bomba, @IdBomba) ) then
      System.Exit;

    // Le Id do Bico
    if not GoodResult( EZInterface.GetPumpHoseByNumber(IdBomba, Bico, @IdBico) ) then
      System.Exit;

    // Le dados do Bico
    if GoodResult( EZInterface.GetHosePropertiesEx2(IdBico, @Number, @PumpID, @TankID,
                                                    @PhysicalNumber, @MtrTheoValue,
                                                    @MtrTheoVolume, @MtrElecValue,
                                                    @MtrElecVolume, @UVEAntenna,
                                                    @Price1, @Price2, @Enabled ) ) then
    begin
      WriteMessage(' --- Encerrantes: ' +
                             ' Bomba= ' + IntToStr(Bomba) +
                             ', Bico= ' + IntToStr(Bico) +
                       ', Enc Volume= ' + FloatToStr(MtrElecVolume) +
                        ', Enc Value= ' + FloatToStr(MtrElecValue) +
                                  ' [ ' +
                            ' Number= ' + IntToStr(Number) +
                           ', PumpId= ' + IntToStr(PumpID) +
                           ', TankID= ' + IntToStr(TankID) +
                   ', PhisicalNumber= ' + IntToStr(PhysicalNumber) +
                     ', MtrTheoValue= ' + FloatToStr(MtrTheoValue) +
                    ', MtrTheoVolume= ' + FloatToStr(MtrTheoVolume) +
                        ', UVAntenna= ' + IntToStr(UVEAntenna) +
                           ', Price1= ' + FloatToStr(Price1) +
                           ', Price2= ' + FloatToStr(Price2) +
                          ', Enabled= ' + IntToStr(Enabled) +
                                    ' ] ' );
    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btCheckConnectionClick(Sender: TObject);
  begin

    if not GoodResult( EZInterface.TestConnection ) then
    begin
      edServerAddress.Enabled := true;
      self.btLogonClick(self);
    end
    else
      WriteMessage('Conexao com EZServer OK!');

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.chProcEventsClick(Sender: TObject);
  begin
    if chProcEvents.Checked = false then
    begin
      WriteMessage('Processando por Polling!');
    end
    else
      WriteMessage('Processando por Evento!');

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.edServerAddressChange(Sender: TObject);
  begin

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.btGetAllDeliveriesClick(Sender: TObject);
  var
    Idx: Integer;
    Ct: Integer;
    Id: Integer;

    HoseID: Integer;
    State: Smallint;
    DType: Smallint;
    Volume: Double;
    PriceLevel: Smallint;
    Price: Double;
    Value: Double;
    Volume2 : Double;
    CompletedDT: TDateTime;
    LockedBy: Integer;
    ReservedBy: Integer;
    AttendantID: Integer;
    Age: Integer;
    ClearedDT: TDateTime;
    OldVolumeETot: Double;
    OldVolume2ETot: Double;
    OldValueETot: Double;
    NewVolumeETot: Double;
    NewVolume2ETot: Double;
    NewValueETot: Double;
    Tag: Int64;
    Duration: Integer;
    ClientID: Integer;
    PeakFlowRate: Double;

  begin

    WriteMessage( '[Abastecimentos]---------------------------------------------------');

    //--------------------------------------------------------------------
    // Le o numero de produtos configurados
    if not GoodResult( EZInterface.GetDeliveriesCount( @Ct ) ) then
      System.Exit;

    WriteMessage( '      Existem ' + IntToStr(Ct) + ' na lista.');

    //for Idx := 1 to Ct do
    for Idx := Ct downto 1 do
    begin

       if not GoodResult( EZInterface.GetDeliveryByOrdinal( Idx, @Id ) ) then
          System.Exit;

       if GoodResult( EZInterface.GetDeliveryPropertiesEx4(Id, @HoseID, @State, @DType,
                                                           @Volume, @PriceLevel, @Price,
                                                           @Value, @Volume2, @CompletedDT,
                                                           @LockedBy, @ReservedBy, @AttendantID,
                                                           @Age, @ClearedDT, @OldVolumeETot,
                                                           @OldVolume2ETot, @OldValueETot,
                                                           @NewVolumeETot, @NewVolume2ETot,
                                                           @NewValueETot, @Tag, @Duration, @ClientID,
                                                           @PeakFlowRate ) ) then
        begin
          WriteMessage( '      Abastecimento: ' + IntToStr(Id) +
                                   ', HoseID: ' + IntToStr(HoseID) +
                                    ', State: ' + IntToStr(State) +
                                     ', Type: ' + IntToStr(DType) +
                                   ', Volume: ' + FloatToStr(Volume) +
                               ', PriceLevel: ' + IntToStr(PriceLevel) +
                                    ', Price: ' + FloatToStr(Price) +
                                    ', Value: ' + FloatToStr(Value) +
                                  ', Volume2: ' + FloatToStr(Volume2) +
                               ', CompleteDT: ' + DateTimeToStr(CompletedDT) +
                                 ', LockedBy: ' + IntToStr(LockedBy) +
                               ', ReservedBy: ' + IntToStr(ReservedBy) +
                              ', AttendantID: ' + IntToStr(AttendantID) +
                                      ', Age: ' + IntToStr(Age) +
                                ', ClearedDT: ' + DateTimeToStr(ClearedDT) +
                            ', OldVolumeETot: ' + FloatToStr(OldVolumeETot) +
                           ', OldVolume2ETot: ' + FloatToStr(OldVolume2ETot) +
                             ', OldvalueETot: ' + FloatToStr(OldValueETot) +
                            ', NewVolumeETot: ' + FloatToStr(NewVolumeETot) +
                           ', NewVolume2ETot: ' + FloatToStr(NewVolume2ETot) +
                             ', NewValueETot: ' + FloatToStr(NewValueETot) +
                                      ', Tag: ' + IntToStr(Tag) +
                                ', Duraction: ' + IntToStr(Duration) +
                                 ', ClientID: ' + IntToStr(ClientID) +
                             ', PeakFlowRate: ' + FloatToStr(PeakFlowRate) );

          if LockedBy <> -1  then
            Continue;

          if GoodResult( EZInterface.LockDelivery( Id ) ) then
          begin
              LockedBy := 1 ;
          end
          else
              Continue;

          if ( LockedBy = 1 ) and ( TDeliveryState( State ) <> CLEARED ) then
            GoodResult( EZInterface.ClearDelivery( ID , DType ) ) ;

        end;
    end;

  end;


  //----------------------------------------------------------------------------
  procedure TForm1.btClearMessagesClick(Sender: TObject);
  begin
    MsgList.Items.Clear;
  end;

  //----------------------------------------------------------------------------
  // Ajusta Scrollbar horizontal da lista de mensgens
  procedure TForm1.SetMsgListScrollBar();
  var
    MaxTextWidth: Integer;
    Temp: Integer;
    I: Integer;
  begin

    if MsgList.Items.Count > 1 then
    begin

      // Obtém o comprimento, em pixels, da linha mais longa
      MaxTextWidth := 0;
      for I := 0 to MsgList.Items.Count - 1 do
      begin
        Temp := MsgList.Canvas.TextWidth(MsgList.Items[I]);
        if Temp > MaxTextWidth then
          MaxTextWidth := Temp;
      end;

      // Acrescenta a largura de um "W"
      MaxTextWidth := MaxTextWidth + MsgList.Canvas.TextWidth('W');

      // Envia uma mensagem ao ListBox
      SendMessage(MsgList.Handle, LB_SETHORIZONTALEXTENT, MaxTextWidth, 0);

    end;

  end;

  //----------------------------------------------------------------------------
  // Grava mensagens na lista de depuração
  procedure TForm1.WriteMessage(msg : String );
  begin

    if MsgList.Items.Count > 10000 then
      MsgList.Items.Clear;

    MsgList.Items.Append(msg);

    SetMsgListScrollBar;

    MsgList.ItemIndex := MsgList.Items.Count - 1;
    //MsgList.ItemIndex := -1;
  end;

  //----------------------------------------------------------------------------
  // Avalia retorno das APIS EZForecourt e gera mensagem de erro
  function TForm1.GoodResult( res : Integer ) : bool  ;
  Var
    MSG: WideString;

  begin
    GoodResult := true;

    if res = 0 then
      System.Exit;

    GoodResult := false;

    MSG := EZInterface.ResultString( res);

    WriteMessage( '        *** Error: (' + IntToStr(res) + ') ' + MSG );

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.PriceChangeClick(Sender: TObject);
  var
    Bomba        : Integer;
    Bico         : Integer;
    IdBico       : Integer;
    Duracao      : SmallInt;
    Tipo         : SmallInt;
    Valor1       : Double;
    Valor2       : Double;
    Index        : Integer;
    Bicos        : Integer;

    HNumber : Integer;
    PhysicalNumber : Integer;
    PumpID : Integer;
    PumpNumber : Integer;
    PumpName : WideString;
    TankID : Integer;
    TankNumber : Integer;
    TankName : WideString;
    GradeID : Integer;
    GradeNumber : Integer;
    GradeName : WideString;
    GradeShortName : WideString;
    GradeCode : WideString;
    MtrTheoValue : Double;
    MtrTheoVolume : Double;
    trElecValue : Double;
    MtrElecVolume : Double;
    Price1 : Double;
    Price2 : Double;
    HEnabled : Smallint;

  begin

    Duracao      := Integer(MULTIPLE_DURATION_TYPE); // Duracao do preco (Multipos abastecimentos)
    Tipo         := Integer(FIXED_PRICE_TYPE);  // Tipo de preco (Fixo)

    Bomba        := cbPump.ItemIndex+1;   // Le o numero da bomba no combo
    Bico         := cbHose.ItemIndex+1;   // Le o numero da bico no combo

    Valor1       := strtofloat(edtPrice1.Text);  // Le valor do nivel de preco 1
    Valor2       := strtofloat(edtPrice2.Text);  // Le valor do nivel de preco 2

    // Le o numero de bicos cadastrados
    if not GoodResult( EZInterface.GetHosesCount(@Bicos) ) then
      System.Exit;

    for Index := 1 to Bicos do
    begin

      // Pega o ID do bico
      if not GoodResult( EZInterface.GetHoseByOrdinal(Index, @IdBico) ) then
        System.Exit;

      // Pega os dados do bico
      if GoodResult( EZInterface.GetHoseSummaryEx(IdBico, @HNumber, @PhysicalNumber,
                                                          @PumpID, @PumpNumber, @PumpName,
                                                          @TankID, @TankNumber, @TankName,
                                                          @GradeID, @GradeNumber, @GradeName,
                                                          @GradeShortName, @GradeCode,
                                                          @MtrTheoValue, @MtrTheoVolume,
                                                          @trElecValue, @MtrElecVolume, @Price1,
                                                          @Price2, @HEnabled) ) then
      begin

        // Verifica se o ID co bico pertence o escolhido
        if (Bomba=PumpNumber) and (Bico=HNumber) then
            System.Break;

      end;

    end;

    WriteMessage('Novo preco: Bomba ' + IntToStr(Bomba) +  ', Bico ' + IntToStr(Bico) +
                                           ', Duration ' + IntToStr(Duracao) +
                                               ', Tipo ' + IntToStr(Tipo) +
                                            ', Preo 1: ' + FloatToStr(Valor1) +
                                            ', Preo 2: ' + FloatToStr(Valor2) );

    // Faz ajuste do preço na bomba
    GoodResult( EZInterface.SetHosePrices( IdBico, Duracao, Tipo, Valor1, Valor2) );


  end;

//----------------------------------------------------------------------------
  // Le o esta das bombas usando GetAllPumpStatuses
  procedure TForm1.ReadPumpsStatus();
  var
    PumpsCount : Integer;
    PumpStates : WideString;
    CurrentHose : WideString;
    DeliveriesCount : WideString;
    Idx : Integer;
    CurStatus : TPumpState;
    CurHose : Integer;
    CurDelv : Integer;
    StrStatus : String;

  begin

      // Verifica se esta conectado ao servidor
      if not GoodResult( EZInterface.GetPumpsCount( @PumpsCount ) ) then
          System.Exit;

      // Le o estado de todas as bombas configuradas
      if not GoodResult( EZInterface.GetAllPumpStatuses(@PumpStates, @CurrentHose, @DeliveriesCount) ) then
          exit;

      for Idx := 1 to PumpsCount do
      begin

        CurStatus := EZClient.TPumpState(Ord(PumpStates[Idx])-Ord('0'));
        CurHose   := Ord(CurrentHose[Idx])-Ord('0');
        CurDelv   := Ord(CurrentHose[Idx])-Ord('0');

        case CurStatus of																									// PAM1000
        	INVALID_PUMP_STATE           : StrStatus := 'estado invalido.';													// 0 - OFFLINE
        	NOT_INSTALLED_PUMP_STATE     : StrStatus := 'nao instalada.';													// 6 - CLOSE
        	NOT_RESPONDING_1_PUMP_STATE  : StrStatus := 'Bomba nao responde.';												// 0 - OFFLINE
        	IDLE_PUMP_STATE              : StrStatus := 'em espera (desocupada).';											// 1 - IDLE
        	PRICE_CHANGE_STATE           : StrStatus := 'troca de preco.';													// 1 - IDLE
        	AUTHED_PUMP_STATE            : StrStatus := 'Bomba Autorizada';													// 9 - AUTHORIZED
        	CALLING_PUMP_STATE           : StrStatus := 'esperando autorizacao.';											// 5 - CALL
        	DELIVERY_STARTING_PUMP_STATE : StrStatus := 'abastecimeneto iniciando.';										// 2 - BUSY
        	DELIVERING_PUMP_STATE        : StrStatus := 'abastecendo.';														// 2 - BUSY
        	TEMP_STOPPED_PUMP_STATE      : StrStatus := 'parada temporaria (no meio de uma abastecimento) (STOP).';			// 8 - STOP
        	DELIVERY_FINISHING_PUMP_STATE: StrStatus := 'abastecimento finalizando (fluxo de produto diminuindo).';			// 2 - BUSY
        	DELIVERY_FINISHED_PUMP_STATE : StrStatus := 'abastecimento finalizado (parou de sair combustivel).';			// 2 - BUSY
        	DELIVERY_TIMEOUT_PUMP_STATE  : StrStatus := 'abastecimento excedeu tempo maximo.';								// 1 - IDLE
        	HOSE_OUT_PUMP_STATE          : StrStatus := 'bico fora do guarda-bico (CALL).';									// 5 - CALL
        	PREPAY_REFUND_TIMEOUT_STATE  : StrStatus := 'prazo de pre-determinacao esgotado.';								// 1 - IDLE
        	DELIVERY_TERMINATED_STATE    : StrStatus := 'abastecimento terminado (EOT)';									// 3 - EOT
        	ERROR_PUMP_STATE             : StrStatus := 'Erro (resposta de erro da bomba).';								// 0 - OFFLINE
        	NOT_RESPONDING_2_PUMP_STATE  : StrStatus := 'EZID nao responde.';
        	LAST_PUMP_STATE              : StrStatus := 'Ultimo estado da bomba?';
          else
            StrStatus := 'estado desconhecido = ' + IntToStr(Integer(CurStatus));
        end;

        if lastStatus[IDx] <> PumpStates[Idx] then
        begin
          WriteMessage('Bomba ' +  IntToStr(Idx) + ', Bico ' + IntToStr(CurHose) +
                                                   ', Pendentes ' + IntToStr(CurDelv) +
                                                   ', Status: ' + StrStatus );
          lastStatus[Idx] := PumpStates[Idx];
        end;

      end;
    end;

  //----------------------------------------------------------------------------
  procedure TForm1.InternalProccessEvents();
  var
    EvtCt: Integer;
    EvtType: Integer;

    PumpID: Integer;
    PumpNumber: Smallint;
    State: Smallint;
    ReservedFor: Smallint;
    ReservedBy: Integer;
    HoseID: Integer;
    HoseNumber: Smallint;
    HosePhisicalNumber: Smallint;
    GradeID: Integer;
    GradeNumber: Integer;
    GradeName: WideString;
    ShortGradeName: WideString;
    PriceLevel: Smallint;
    Price: Double;
    Volume: Double;
    Value: Double;
    StackSize: Smallint;
    PumpName: WideString;
    PhysicalNumber: Integer;
    Side: Smallint;
    Address: Smallint;
    PriceLevel1: Smallint;
    PriceLevel2: Smallint;
    PumpType: Smallint;
    PortID: Integer ;
    AuthMode: Smallint ;
    StackMode: Smallint;
    PrepayAllowed: Smallint;
    PreauthAllowed: Smallint;
    PriceFormat: Smallint;
    ValueFormat: Smallint;
    VolumeFormat: Smallint;
    Tag: Int64;
    AttendantID: Integer;
    AttendantNumber: Integer;
    AttendantName: WideString;
    AttendantTag: Int64;
    CardClientID: Integer;
    CardClientNumber: Integer;
    CardClientName: WideString;
    CardClientTag: Int64;
    CurFlowRate: Double;
    PeakFlowRate: Double;

    DeliveryID: Integer;
    HosePhysicalNumber: Integer;
    TankID: Integer;
    TankNumber: Integer;
    TankName: WideString;
    GradeShortName: WideString;
    GradeCode: WideString;
    DeliveryState: Smallint;
    DeliveryType: Smallint;
    Volume2: Double;
    CompletedDT: TDateTime;
    LockedBy: Integer;
    Age: Integer;
    ClearedDT: TDateTime;
    OldVolumeETot: Double;
    OldVolume2ETot: Double;
    OldValueETot: Double;
    NewVolumeETot: Double;
    NewVolume2ETot: Double;
    NewValueETot: Double;
    Duration: Integer;

    CardReadID: Integer;
    Number: Integer;
    Name: WideString;
    CardType: Smallint;
    ParentID: Integer;
    TimeStamp: TDateTime;

    VolumeETot: Double;
    ValueETot: Double;

    EventID: Integer;
    ClientID: Integer;
    EventText: WideString;

    ZBAddress: Int64;
    LQI: SmallInt;
    RSSI: SmallInt;
    ParZBAddress: Int64;
    ZBChannel: SmallInt;
    MemBlocks: SmallInt;
    MemFree: SmallInt;

    LogEventID: Integer;
    DeviceType: SmallInt;
    DeviceID: Integer;
    DeviceNumber: Integer;
    DeviceName: WideString;
    EventLevel: SmallInt;
    EventType: SmallInt;
    EventDesc: WideString;
    GeneratedDT: TDateTime;
    ClearedBy: Integer;
    AckedBy: Integer;
    ProductVolume: Double;
    ProductLevel: Double;
    WaterLevel: Double;
    Temperature: Double;

    GaugeVolume: Double;
    GaugeTCVolume: Double;
    GaugeUllage: Double;
    GaugeTemperature: Double;
    GaugeLevel: Double;
    GaugeWaterVolume: Double;
    GaugeWaterLevel: Double;
    Tipo: SmallInt;
    Capacity: Double;
    Diameter: Double;
    GaugeID: Integer;
    ProbeNo: SmallInt;
    AlarmsMask: Integer;

  begin

    // Verifica se esta conectado ao servidor
    if EZInterface.TestConnection <> 0 then
      System.Exit;

    // Inicia processamento de eventos
    if not GoodResult( EZInterface.ProcessEvents() ) then
      System.Exit;

    // Le numero de eventos disponiveis
    if not Goodresult( EZInterface.GetEventsCount( @EvtCt ) ) then
      System.Exit;

    while True do

    begin

      // Le o proximo evento
      if not GoodResult( EZInterface.GetNextEventType( @EvtType ) ) then
        System.Exit;

      case TClientEvent( EvtType )  of
          //---------------------------------------------------------------------
          NO_CLIENT_EVENT :  // Trata Eventos do Cliente
          begin
                exit;
          end;

          //---------------------------------------------------------------------
          PUMP_EVENT :   // Trata Eventos das Bombas
          begin

            if GoodResult( EZInterface.GetNextPumpEventEx3(@PumpID, @PumpNumber, @State,
                                                           @ReservedFor, @ReservedBy, @HoseID,
                                                           @HoseNumber, @HosePhisicalNumber,
                                                           @GradeID, @GradeNumber, @GradeName,
                                                           @ShortGradeName, @PriceLevel, @Price,
                                                           @Volume, @Value, @StackSize,
                                                           @PumpName, @PhysicalNumber, @Side,
                                                           @Address, @PriceLevel1, @PriceLevel2,
                                                           @PumpType, @PortID, @AuthMode, @StackMode,
                                                           @PrepayAllowed, @PreauthAllowed, @PriceFormat,
                                                           @ValueFormat, @VolumeFormat, @Tag, @AttendantID,
                                                           @AttendantNumber, @AttendantName, @AttendantTag,
                                                           @CardClientID, @CardClientNumber, @CardClientName,
                                                           @CardClientTag, @CurFlowRate, @PeakFlowRate) ) then

              WriteMessage('        PumpEvent: ' +
                                     ' PumpID= ' + IntToStr(PumpID) +
                                ', PumpNumber= ' + IntToStr(PumpNumber) +
                                     ', State= ' + IntToStr(State) +
                               ', ReservedFor= ' + IntToStr(ReservedFor) +
                                ', ReservedBy= ' + IntToStr(ReservedBy) +
                                    ', HoseID= ' + IntToStr(HoseID) +
                                ', HoseNumber= ' + IntToStr(HoseNumber) +
                        ', HosePhisicalNumber= ' + IntToStr(HosePhisicalNumber) +
                                   ', GradeID= ' + IntToStr(GradeID) +
                                 ', GradeName= ' + GradeName +
                               ', GradeNumber= ' + IntToStr(GradeNumber) +
                            ', ShortGradeName= ' + ShortGradeName +
                                ', PriceLevel= ' + IntToStr(PriceLevel) +
                                     ', Price= ' + FloatToStr(Price) +
                                    ', Volume= ' + FloatToStr(Volume) +
                                     ', Value= ' + FloatToStr(Value) +
                                 ', StackSize= ' + IntToStr(StackSize) +
                                  ', PumpName= ' + PumpName +
                            ', PhysicalNumber= ' + IntToStr(PhysicalNumber) +
                                      ', Side= ' + IntToStr(Side) +
                                   ', Address= ' + IntToStr(Address) +
                               ', PriceLevel1= ' + IntToStr(PriceLevel1) +
                               ', PriceLevel2= ' + IntToStr(PriceLevel2) +
                                  ', PumpType= ' + IntToStr(PumpType) +
                                    ', PortID= ' + IntToStr(PortID) +
                                  ', AuthMode= ' + IntToStr(AuthMode) +
                                 ', StackMode= ' + IntToStr(StackMode) +
                             ', PrepayAllowed= ' + IntToStr(PrepayAllowed) +
                            ', PreauthAllowed= ' + IntToStr(PreauthAllowed) +
                               ', PriceFormat= ' + IntToStr(PriceFormat) +
                               ', ValueFormat= ' + IntToStr(ValueFormat) +
                              ', VolumeFormat= ' + IntToStr(VolumeFormat) +
                                       ', Tag= ' + IntToStr(Tag) +
                               ', AttendantID= ' + IntToStr(AttendantID) +
                           ', AttendantNumber= ' + IntToStr(AttendantNumber) +
                             ', AttendantName= ' + AttendantName +
                              ', AttendantTag= ' + IntToStr(AttendantTag) +
                              ', CardClientID= ' + IntToStr(CardClientID) +
                          ', CardClientNumber= ' + IntToStr(CardClientNumber) +
                            ', CardClientName= ' + CardClientName +
                             ', CardClientTag= ' + IntToStr(CardClientTag) +
                                ',CurFlowRate= ' + FloatToStr(CurFlowRate) +
                               ',PeakFlowRate= ' + FloatToStr(PeakFlowRate) );

               WriteMessage('             Bico Equivalente CBC: ' + CompanyID(HoseNumber, PumpNumber));


          end;

          //---------------------------------------------------------------------
          DELIVERY_EVENT : // Eventos de abastecimento
          begin

            if GoodResult( EZInterface.GetNextDeliveryEventEx4(@DeliveryID, @HoseID, @HoseNumber,
                                                               @HosePhysicalNumber, @PumpID, @PumpNumber,
                                                               @PumpName, @TankID, @TankNumber, @TankName,
                                                               @GradeID, @GradeNumber, @GradeName, @GradeShortName,
                                                               @GradeCode, @DeliveryState, @DeliveryType, @Volume,
                                                               @PriceLevel, @Price, @Value, @Volume2, @CompletedDT,
                                                               @LockedBy, @ReservedBy, @AttendantID, @Age, @ClearedDT,
                                                               @OldVolumeETot, @OldVolume2ETot, @OldValueETot,
                                                               @NewVolumeETot, @NewVolume2ETot, @NewValueETot, @Tag,
                                                               @Duration, @AttendantNumber, @AttendantName, @AttendantTag,
                                                               @CardClientID, @CardClientNumber, @CardClientName,
                                                               @CardClientTag, @PeakFlowRate) ) then
            begin

              if DeliveryID>0 then
              begin
                WriteMessage('       DeliveryEvent: ' +
                                      ' DeliveryID= ' + IntToStr(DeliveryID) +
                                         ', HoseID= ' + IntToStr(HoseID) +
                                     ', HoseNumber= ' + IntToStr(HoseNumber) +
                             ', HosePhysicalNumber= ' + IntToStr(HosePhysicalNumber) +
                                         ', PumpID= ' + IntToStr(PumpID) +
                                     ', PumpNumber= ' + IntToStr(PumpNumber) +
                                       ', PumpName= ' + PumpName +
                                         ', TankID= ' + IntToStr(TankID) +
                                     ', TankNumber= ' + IntToStr(TankNumber) +
                                       ', TankName= ' + TankName +
                                        ', GradeID= ' + IntToStr(GradeID) +
                                    ', GradeNumber= ' + IntToStr(GradeNumber) +
                                      ', GradeName= ' + GradeName +
                                 ', GradeShortName= ' + GradeShortName +
                                      ', GradeCode= ' + GradeCode +
                                  ', DeliveryState= ' + IntToStr(DeliveryState) +
                                   ', DeliveryType= ' + IntToStr(DeliveryType) +
                                         ', Volume= ' + FloatToStr(Volume) +
                                     ', PriceLevel= ' + IntToStr(PriceLevel) +
                                          ', Price= ' + FloatToStr(Price) +
                                          ', Value= ' + FloatToStr(Value) +
                                        ', Volume2= ' + FloatToStr(Volume2) +
                                    ', CompletedDT= ' + DateTimeToStr(CompletedDT) +
                                       ', LockedBy= ' + IntToStr(LockedBy) +
                                     ', ReservedBy= ' + IntToStr(ReservedBy) +
                                    ', AttendantID= ' + IntToStr(AttendantID) +
                                            ', Age= ' + IntToStr(Age) +
                                      ', ClearedDT= ' + DateTimeToStr(ClearedDT) +
                                  ', OldVolumeETot= ' + FloatToStr(OldVolumeETot) +
                                 ', OldVolume2ETot= ' + FloatToStr(OldVolume2ETot) +
                                   ', OldValueETot= ' + FloatToStr(OldValueETot) +
                                  ', NewVolumeETot= ' + FloatToStr(NewVolumeETot) +
                                 ', NewVolume2ETot= ' + FloatToStr(NewVolume2ETot) +
                                   ', NewValueETot= ' + FloatToStr(NewValueETot) +
                                            ', Tag= ' + IntToStr(Tag) +
                                       ', Duration= ' + IntToStr(Duration) +
                                ', AttendantNumber= ' + IntToStr(AttendantNumber) +
                                  ', AttendantName= ' + AttendantName +
                                   ', AttendantTag= ' + IntToStr(AttendantTag) +
                                   ', CardClientID= ' + IntToStr(CardClientID) +
                               ', CardClientNumber= ' + IntToStr(CardClientNumber) +
                                 ', CardClientName= ' + CardClientName +
                                  ', CardClientTag= ' + IntToStr(CardClientTag) +
                                   ', PeakFlowRate= ' + FloatToStr(PeakFlowRate));

                 WriteMessage('            Bico Equivalente CBC: ' + CompanyID(HoseNumber, PumpNumber));

                if LockedBy = -1  then
                begin
                  if GoodResult( EZInterface.LockDelivery( DeliveryID ) ) then
                    LockedBy := 1 ;

                  if ( LockedBy = 1 ) and ( TDeliveryState( DeliveryState ) <> CLEARED ) then
                  begin
                    { process the delivery here }
                    GoodResult( EZInterface.ClearDelivery( DeliveryID , DeliveryType ) ) ;
                  end;
                end;

              end;

            end;
          end;

          //---------------------------------------------------------------------
          CARD_READ_EVENT:  // Eventos de leitores de cartoes
          begin

            if GoodResult( EZInterface.GetNextCardReadEvent(@CardReadID, @Number, @Name,
                                                            @PumpID, @CardType, @ParentID,
                                                            @Tag, @TimeStamp) ) then
            begin

              WriteMessage('       CardReadEvent: ' +
                                    ' CardReadID= ' + IntToStr(CardReadID) +
                                       ', Number= ' + IntToStr(Number) +
                                        ',  Name= ' + Name +
                                      ',  PumpID= ' + IntToStr(PumpID) +
                                    ',  CardType= ' + IntToStr(CardType) +
                                    ',  ParentID= ' + IntToStr(ParentID) +
                                         ',  Tag= ' + IntToStr(Tag) +
                                   ',  TimeStamp= ' + DateTimeToStr(TimeStamp) );

              case TTagType(CardType )  of
                ATTENDANT_TAG_TYPE:
                begin
                  WriteMessage('               Attendant: ' + Name + ', tag' +  IntToStr(Tag) );
                end;

                BLOCKED_ATTENDANT_TAG_TYPE:
                begin
                  WriteMessage('       Blocked attendant: ' + Name + ', tag' +  IntToStr(Tag) );
                end;

                WRONG_SHIFT_ATTENDANT_TAG_TYPE:
                begin
                  WriteMessage('   Wrong shift attendant: ' + Name + ', tag' +  IntToStr(Tag) );
                end;

                CLIENT_TAG_TYPE:
                begin
                  WriteMessage('                  Client: ' + Name + ', tag' +  IntToStr(Tag) );
                end;

                BLOCKED_CLIENT_TAG_TYPE:
                begin
                  WriteMessage('          Blocked Client: ' + Name + ', tag' +  IntToStr(Tag) );
                end;

                UNKNOWN_TAG_TYPE:
                begin
                  WriteMessage('         Unknown tag read: ' +  IntToStr(Tag) );
                end;
              else
                  WriteMessage('         Unknown tag type: ' + IntToStr(CardType) + ', tag' + IntToStr(Tag) );
              end;

              GoodResult( EZInterface.DeleteCardRead( CardReadID )) ;

            end;

          end;

          //---------------------------------------------------------------------
          DB_LOG_ETOTALS:   // Evento de mudanca de encerrantes
          begin

            if GoodResult( EZInterface.GetNextDBHoseETotalsEventEx(@HoseID, @Volume, @Value,
                                                                   @VolumeETot, @ValueETot,
                                                                   @HoseNumber, @HosePhysicalNumber,
                                                                   @PumpID, @PumpNumber, @PumpName,
                                                                   @TankID, @TankNumber, @TankName,
                                                                   @GradeID, @GradeName) ) then
              WriteMessage('       HoseETotalEvent: ' +
                                         ', HoseID= ' + IntToStr(HoseID) +
                                         ', Volume= ' + FloatToStr(Volume) +
                                          ', Value= ' + FloatToStr(Value) +
                                     ', VolumeETot= ' + FloatToStr(VolumeETot) +
                                      ', ValueETot= ' + FloatToStr(ValueETot) +
                                     ', HoseNumber= ' + IntToStr(HoseNumber) +
                             ', HosePhysicalNumber= ' + IntToStr(HosePhysicalNumber) +
                                         ', PumpID= ' + IntToStr(PumpID) +
                                     ', PumpNumber= ' + IntToStr(PumpNumber) +
                                       ', PumpName= ' + PumpName +
                                         ', TankID= ' + IntToStr(TankID) +
                                     ', TankNumber= ' + IntToStr(TankNumber) +
                                       ', TankName= ' + TankName +
                                        ', GradeID= ' + IntToStr(GradeID) +
                                      ', GradeName= ' + GradeName);
          end;

          //---------------------------------------------------------------------
          SERVER_EVENT:  // Eventos do servidor
          begin

            if GoodResult( EZInterface.GetNextServerEvent(@EventID, @EventText) ) then
              WriteMessage('       ServerEvent: ' +
                                    '  EventID= ' + IntToStr(EventID) +
                                  ', EventText= ' + EventText);


          end;

          //---------------------------------------------------------------------
          CLIENT_EVENT:  // Eventos de POS (client)
          begin

            if GoodResult( EZInterface.GetNextClientEvent(@ClientID, @EventID, @EventText) ) then
              WriteMessage('       ClientEvent: ' +
                                   ', ClientID= ' + IntToStr(ClientID) +
                                    ', EventID= ' + IntToStr(EventID) +
                                  ', EventText= ' + EventText);

          end;

          //---------------------------------------------------------------------
          ZB2G_STATUS_EVENT:  // Eventos de ZigBee
          begin

          if GoodResult( EZInterface.GetNextZB2GStatusEvent(@PortID, @ZBAddress,
                              @LQI, @RSSI, @ParZBAddress, @ZBChannel,
                              @MemBlocks, @MemFree) ) then

            WriteMessage('         ZigBeeEvent: ' +
                                ', PortaID: ' + IntToStr(PortID) +
                                ', Endereço ZigBee: ' + IntToStr(ZBAddress) +
                                ', LQI: ' + IntToStr(LQI) +
                                ', RSSI: ' + IntToStr(RSSI) +
                                ', ParZBAddress: ' + IntToStr(ParZBAddress) +
                                ', Canal ZigBee: ' + IntToStr(ZBChannel) +
                                ', Memoria Bloqueada: ' + IntToStr(MemBlocks) +
                                ', Memória Livre: ' + IntToStr(MemFree) );

          end;
          //---------------------------------------------------------------------
          LOG_EVENT_EVENT: //LogEvent
          begin

          if (GoodResult(EZInterface.GetNextLogEventEvent(@LogEventID,
                  @DeviceType, @DeviceID, @DeviceNumber,
                  @DeviceName, @EventLevel, @EventType,
                  @EventDesc, @GeneratedDT, @ClearedDT,
                  @ClearedBy, @AckedBy, @Volume,
                  @Value, @ProductVolume, @ProductLevel,
                  @WaterLevel, @Temperature))) then

            WriteMessage('         LogEvent: ' +
                                ', LogEventID: ' + IntToStr(LogEventID) +
                                ', DeviceType: ' + IntToStr(DeviceType) +
                                ', DeviceID: ' + IntToStr(DeviceID) +
                                ', DeviceNumber: ' + IntToStr(DeviceNumber) +
                                ', DeviceName: ' + DeviceName +
                                ', EventLevel: ' + IntToStr(EventLevel) +
                                ', EventType: ' + IntToStr(EventType) +
                                ', EventDesc: ' + EventDesc +
                                ', GeneratedDT: ' + DateTimeToStr(GeneratedDT)  +
                                ', ClearedDT: ' + DateTimeToStr(ClearedDT) +
                                ', ClearedBy: ' + IntToStr(ClearedBy) +
                                ', AckedBy: ' + IntToStr(AckedBy) +
                                ', Volume: ' + FloatToStr(Volume) +
                                ', Value: ' + FloatToStr(Value) +
                                ', ProductVolume: ' + FloatToStr(ProductVolume) +
                                ', ProductLevel: ' + FloatToStr(ProductLevel) +
                                ', WaterLevel: ' + FloatToStr(WaterLevel) +
                                ', Temperature: ' + FloatToStr(Temperature) );

          end;
          //---------------------------------------------------------------------
          DB_TANK_STATUS: //Eventos de Tank
          begin

          if (GoodResult(EZInterface.GetNextDBTankStatusEventEx2(@TankID,
                  @GaugeVolume, @GaugeTCVolume, @GaugeUllage,
                  @GaugeTemperature, @GaugeLevel, @GaugeWaterVolume,
                  @GaugeWaterLevel, @TankNumber, @TankName,
                  @GradeID, @GradeName, @Tipo,
                  @Capacity, @Diameter, @GaugeID,
                  @ProbeNo, @State, @AlarmsMask))) then

            WriteMessage('         TankEvent: ' +
                                ', TankID: ' + IntToStr(TankID) +
                                ', GaugeVolume: ' + FloatToStr(GaugeVolume) +
                                ', GaugeTCVolume: ' + FloatToStr(GaugeTCVolume) +
                                ', GaugeUllage: ' + FloatToStr(GaugeUllage) +
                                ', GaugeTemperature: ' + FloatToStr(GaugeTemperature) +
                                ', GaugeLevel: ' + FloatToStr(GaugeLevel) +
                                ', GaugeWaterVolume: ' + FloatToStr(GaugeWaterVolume) +
                                ', GaugeWaterLevel: ' + FloatToStr(GaugeWaterLevel) +
                                ', TankNumber: ' + IntToStr(TankNumber)  +
                                ', TankName: ' + TankName +
                                ', GradeID: ' + IntToStr(GradeID) +
                                ', GradeName: ' + GradeName +
                                ', Tipo: ' + IntToStr(Tipo) +
                                ', Capacity: ' + FloatToStr(Capacity) +
                                ', Diameter: ' + FloatToStr(Diameter) +
                                ', GaugeID: ' + IntToStr(GaugeID) +
                                ', ProbeNo: ' + IntToStr(ProbeNo) +
                                ', State: ' + IntToStr(State) +
                                ', AlarmsMask: ' + IntToStr(AlarmsMask) );

          end
          //---------------------------------------------------------------------
      else
        GoodResult( EZInterface.DiscardNextEvent() ) ;
        end;

    end;

  end;

  //----------------------------------------------------------------------------
  procedure TForm1.TimerAppLoopTimer(Sender: TObject);
  begin
    //WriteMessage('Agora');

    if chProcEvents.Checked = true then
    begin
      self.InternalProccessEvents();
    end
    else  // Procssamento por Pooling
      self.ReadPumpsStatus;

  end;

  //------------------------------------------------------------------------------
  // Calcula o codigo referente ao ID do bico nos concentradores CBC da Companytec.
  //    HoseNumber: numero fisico do bico na bomba
  //    PumpNumber: numero da bomba
  //
  function TForm1.CompanyID(HoseNumber: SmallInt; PumpNumber: SmallInt ) : String;
  var
    Offset : Integer;
  begin

    case HoseNumber of
       2: Offset := $44;
       3: Offset := $84;
       4: Offset := $C4;
    else // Outros valores são tratados como Bico 1
       Offset := $04;
    end;

    CompanyID := IntToHex( ((PumpNumber-1)+Offset), 2);
  end;

//------------------------------------------------------------------------------
end.
