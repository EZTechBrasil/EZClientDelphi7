{
  Empresa     :  EzTech Tecnologia e Automação Ltda
        				 http://www.eztech.ind.br/

  Autor       : Otavio Venezian Junior - 05/03/2012
                Eric Figueiredo Lima - 06/2016

  Descricao   : Classe para carga e acesso da biblioteca EZClient.dll

  Observacoes :
}

unit EZClient;

//-----------------------------------------------------------------------------
interface

//-----------------------------------------------------------------------------
uses
  Windows, SysUtils, Forms, Dialogs;
  { Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;   }

type
  //-----------------------------------------------------------------------------
  TDllVersion = function(  pName : PWideString  ) : Integer; stdcall;

  TServerVersion = function( pName : PWideString  ) : Integer; stdcall;

  TClientLogon = function( ClientID  : Integer  ; ClientType : Smallint  ; Event : Integer  ; hWnd : Integer ; wMsg : Integer ) : Integer; stdcall;

  TClientLogonEx = function(  ClientID : Integer  ; ClientType : Smallint  ; ServerName : WideString  ;  CallPortNo : Word  ; EventsPortNo : Word  ; CallTimeout : Integer ; Event : int64  ; hWnd : int64 ; wMsg : int64 ) : Integer; stdcall;

  TClientLogoff = function() : Integer; stdcall;

  TClientStatus = function( pPumpsReserved : PSmallint  ; pdeliveriesLocked : PSmallint  ) : Integer; stdcall;

  TGetLicenseType = function(  pLicenseType : PSmallint  ) : Integer; stdcall;

  TFireClientEvent = function( EventID : Integer  ; EventStr : WideString  ) : Integer; stdcall;

  TTestConnection = function( ) : Integer; stdcall;

  TProcessEvents = function( ) : Integer; stdcall;

  TGetEventsCount = function( pCount : PInteger  ) : Integer; stdcall;

  TGetNextEventType = function( pType : PSmallint  ) : Integer; stdcall;

  TDiscardNextEvent = function( ) : Integer; stdcall;

  TGetNextPumpEvent = function( pPumpID : PInteger ; pPumpNumber : PSmallint ; pState : PSmallint ; pReservedFor : PSmallint ; pReservedBy : PInteger ; pHoseID : PInteger  ;
    pHoseNumber : PSmallint ; pGradeID : PInteger ; pGradeName : PWideString  ; pSmallintGradeName : PWideString ; pPriceLevel : PSmallint  ; pPrice : PDouble ; pVolume : PDouble ;
    pValue : PDouble ; pStackSize : PSmallint  ) : Integer; stdcall;

  TGetNextDeliveryEvent = function(  pDeliveryID : PInteger  ; pPumpID : PInteger ; pPumpNumber : PSmallint ; pHoseID : PInteger ; pHoseNumber : PSmallint  ;
    pGradeID : PInteger ; pGradeName : PWideString  ; pSmallintGradeName : PWideString ; pPriceLevel : PSmallint ; pPrice : PDouble ; pVolume : PDouble ; pValue : PDouble ;
    pDeliveryState : PSmallint  ; pDeliveryType : PSmallint ; pLockedBy : PInteger ; pReservedBy : PInteger ; pAge : PInteger  ; pCompletedDT : PDateTime  ; pAttendantID : PInteger  ) : Integer; stdcall;

  TGetNextServerEvent = function(  pEventID : PInteger ; pEventText : PWideString  ) : Integer; stdcall;

  TGetNextClientEvent = function(  pClientID : PInteger ; pEventID : PInteger ; pEventText : PWideString  ) : Integer; stdcall;

  TGetNextDBLogEvent = function(  pEventType : PInteger  ; pDeviceID : PInteger  ; pEventDT : PDateTime  ; pEventText : PWideString  ) : Integer; stdcall;

  TGetNextDBLogDeliveryEvent = function( pDeliveryID : PInteger ; pHoseID : PInteger ; pDeliveryState : PSmallint ; pDeliveryType : PSmallint ; pVolume : PDouble ; pPriceLevel : PSmallint ;
    pPrice : PDouble ; pValue : PDouble ; pVolume2 : PDouble ; pReservedBy : PInteger  ; pAttendantID : PInteger ; pDeliveryDT : PDateTime  ) : Integer; stdcall;

  TGetNextDBClearDeliveryEvent = function(  pDeliveryID : PInteger ; pDeliveryType : PSmallint ; pClearedBY : PInteger ; pClearedDT : PDateTime ; pAttendantID : PInteger  ) : Integer; stdcall;

  TGetNextDBStackDeliveryEvent = function( pDeliveryID  : PInteger  ) : Integer; stdcall;

  TGetNextDBHoseETotalsEvent = function( pHoseID : PInteger  ; pVolume : PDouble  ; pValue : PDouble  ; pVolumeETot : PDouble  ; pValueETot : PDouble  ) : Integer; stdcall;

  TGetNextDBTriggerEvent = function(  pTableID : PInteger  ; pRowID : PInteger  ) : Integer; stdcall;

  TGetNextDBAttendantLogonEvent = function(  pAttendantID : PInteger  ;pPumpID : PInteger  ) : Integer; stdcall;

  TGetNextDBAttendantLogoffEvent = function( pAttendantID : PInteger  ) : Integer; stdcall;

  TGetNextDBTankStatusEvent = function( pTankID : PInteger  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ; pGaugeTemperature : PDouble  ;
    pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble  ) : Integer; stdcall;

  TGetPumpsCount = function( pCount : PInteger  ) : Integer; stdcall;

  TGetPumpByNumber = function( Number : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetPumpByName = function( Name : WideString  ; pID : PInteger  ) : Integer; stdcall;

  TGetPumpByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetPumpProperties = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString ; pPhysicalNumber : PSmallint ; pSide : PSmallint ; pAddress : PSmallint ; pPriceLevel1: PSmallint ;
    pPriceLevel2 : PSmallint ; pPriceDspFormat : PSmallint ; pVolumeDspFormat : PSmallint ; pValueDspFormat : PSmallint ; pPumpType : PSmallint ;
    pPortID : PInteger ; pAttendantID : PInteger ; pAuthMode : PSmallint ; pStackMode : PSmallint ; pPrepayAllowed : PSmallint ; pPreauthAllowed : PSmallint  ) : Integer; stdcall;

  TSetPumpProperties = function( ID : Integer  ; Number : Integer ; Name : WideString ; PhysicalNumber : Smallint ; Side : Smallint ; Address : Smallint ; PriceLevel1 : Smallint ;
    PriceLevel2 : Smallint ; PriceDspFormat : Smallint ; VolumeDspFormat : Smallint ; ValueDspFormat : Smallint ; PumpType : Smallint ;
    PortID : Integer ;  AttendantID : Integer ; AuthMode : Smallint ; StackMode : Smallint ; PrepayAllowed : Smallint ; PreauthAllowed : Smallint  ) : Integer; stdcall;

  TDeletePump = function( ID : Integer  ) : Integer; stdcall;

  TGetPumpHosesCount = function( ID : Integer  ; pCount : PInteger  ) : Integer; stdcall;

  TGetPumpHoseByNumber = function( ID : Integer  ; Number : Integer  ;pHoseID  : PInteger  ) : Integer; stdcall;

  TGetPumpStatus = function( ID : Integer  ; pState : PSmallint ; pReservedFor : PSmallint ; pReservedBy : PInteger ; pHoseID: PInteger ; pHoseNumber : PSmallint  ;
    pGradeID : PInteger ; pGradeName : PWideString  ; pSmallintGradeName : PWideString ; pPriceLevel : PSmallint  ; pPrice : PDouble  ; pVolume : PDouble  ; pValue : PDouble  ;
    pStackSize : PSmallint  ) : Integer; stdcall;

  TGetPumpDeliveryProperties = function( ID : Integer  ; Index : Smallint  ; pDeliveryID : PInteger  ; pType : PSmallint  ; pState : PSmallint ; pHoseID : PInteger ;
    pHoseNum : PSmallint ; pGradeID : PInteger  ; pGradeName : PWideString  ; pSmallintGradeName : PWideString ; pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble  ;
    pValue : PDouble  ; pLockedBy : PInteger  ; pReservedBy : PInteger  ; pAge : PInteger  ; pCompletedDT : PDateTime  ; pAttendantID : PInteger   ) : Integer; stdcall;

  TGetPumpDeliveryPropertiesEx = function(  ID : Integer  ; Index : Smallint  ; pDeliveryID : PInteger  ; pType : PSmallint  ; pState : PSmallint ; pHoseID : PInteger ; pHoseNum : PSmallint ; pGradeID : PInteger ; pGradeName : PWideString ; pSmallintGradeName : PWideString  ;
    pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble  ; pValue : PDouble  ; pLockedBy : PInteger  ;
    pReservedBy : PInteger  ; pAge : PInteger  ; pCompletedDT : PDateTime  ; pAttendantID : PInteger  ; pVolumeETot : PDouble  ; pVolume2ETot : PDouble  ; pValueETot : PDouble  ; pTag : PInt64  ) : Integer; stdcall;

  TGetPumpDeliveryPropertiesEx2 = function( ID : Integer  ; Index : Smallint  ; pDeliveryID : PInteger  ; pType : PSmallint  ; pState : PSmallint ; pHoseID : PInteger ; pHoseNum : PSmallint ; pGradeID : PInteger ; pGradeName : PWideString ; pSmallintGradeName : PWideString  ;
    pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble  ; pValue : PDouble  ; pLockedBy : PInteger  ;
    pReservedBy : PInteger  ; pAge : PInteger  ; pCompletedDT : PDateTime  ; pAttendantID : PInteger  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot : PDouble  ; pNewVolume2ETot : PDouble  ; pNewValueETot : PDouble  ;
    pTag : PInt64  ; pDuration : PInteger  ) : Integer; stdcall;

  TGetPumpDeliveryPropertiesEx3 = function( ID : Integer  ; Index : Smallint  ; pDeliveryID : PInteger  ; pType : PSmallint  ; pState : PSmallint ; pHoseID : PInteger ; pHoseNum : PSmallint ; pGradeID : PInteger ; pGradeName : PWideString ; pSmallintGradeName : PWideString  ;
    pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble  ; pValue : PDouble  ; pLockedBy : PInteger  ;
    pReservedBy : PInteger  ; pAge : PInteger  ; pCompletedDT : PDateTime  ; pAttendantID : PInteger  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot : PDouble  ; pNewVolume2ETot : PDouble  ; pNewValueETot : PDouble  ;
    pTag : PInt64  ; pDuration : PInteger ; pCardClientID : PInteger ) : Integer; stdcall;

  TGetPumpDeliveryPropertiesEx4 = function( ID : Integer  ; Index : Smallint  ; pDeliveryID : PInteger  ; pType : PSmallint  ; pState : PSmallint ; pHoseID : PInteger ; pHoseNum : PSmallint ; pGradeID : PInteger ; pGradeName : PWideString ; pSmallintGradeName : PWideString  ;
    pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble  ; pValue : PDouble  ; pLockedBy : PInteger  ;
    pReservedBy : PInteger  ; pAge : PInteger  ; pCompletedDT : PDateTime  ; pAttendantID : PInteger  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot : PDouble  ; pNewVolume2ETot : PDouble  ; pNewValueETot : PDouble  ;
    pTag : PInt64  ; pDuration : PInteger ; pCardClientID : PInteger ; pPeakFlowRate : PDouble ) : Integer; stdcall;

  TPrepayReserve = function( ID : Integer  ) : Integer; stdcall;

  TPrepayCancel = function( ID : Integer   ) : Integer; stdcall;

  TPrepayAuthorise = function( ID : Integer  ; LimitType : Smallint  ; Value : Double  ; Hose : Smallint  ; PriceLevel : Smallint  ) : Integer; stdcall;

  TPreauthReserve = function( ID : Integer  ) : Integer; stdcall;

  TPreauthCancel = function( ID : Integer  ) : Integer; stdcall;

  TPreauthAuthorise = function( ID : Integer  ; LimitType : Smallint  ; Value : Double  ; Hose : Smallint  ; PriceLevel : Smallint  ) : Integer; stdcall;

  TLoadPreset = function( ID : Integer  ; LimitType : Smallint  ; Value : Double  ; Hose : Smallint  ; PriceLevel : Smallint  ) : Integer; stdcall;

  TLoadPresetWithPrice = function(  ID : Integer  ; LimitType : Smallint  ; Value : Double  ; Hose : Smallint  ; PriceLevel : Smallint  ; Price : Double  ) : Integer; stdcall;

  TTagAuthorise = function(  ID : Integer  ; Tag : Int64  ; LimitType : Smallint  ; Value : Double  ; Hose : Smallint  ; PriceLevel : Smallint  ) : Integer; stdcall;

  TAttendantAuthorise = function( ID : Integer  ; AttendantID : Integer  ) : Integer; stdcall;

  TAuthorise = function(  ID : Integer  ) : Integer; stdcall;

  TCancelAuthorise = function( ID : Integer  ) : Integer; stdcall;

  TTempStop = function( ID : Integer  ) : Integer; stdcall;

  TReAuthorise = function( ID : Integer  ) : Integer; stdcall;

  TTerminateDelivery = function( ID : Integer  ) : Integer; stdcall;

  TStackCurrentDelivery = function(  ID: Integer  ) : Integer; stdcall;

  TGetDensity = function( ID : Integer  ; pDensity : PDouble ) : Integer; stdcall;

  TGetHosesCount = function(  pCount : PInteger  ) : Integer; stdcall;

  TGetHoseByOrdinal = function(  Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetHoseProperties = function( ID : Integer  ; pNumber : PInteger ; pPumpID : PInteger  ; pTankID : PInteger  ; pPhysicalNumber : PInteger ;
    pMtrTheoValue : PDouble  ; pMtrTheoVolume : PDouble  ; pMtrElecValue : PDouble  ;
    pMtrElecVolume : PDouble  ) : Integer; stdcall;

  TSetHoseProperties = function( ID : Integer  ; Number : Integer ; PumpID : Integer ; TankID : Integer  ; PhysicalNumber : Integer ;
    MtrTheoValue : Double  ; MtrTheoVolume : Double  ; MtrElecValue : Double  ;
    MtrElecVolume : Double  ) : Integer; stdcall;

  TGetHoseSummary = function( ID	: Integer  ; pNumber : PInteger ; pPhysicalNumber : PInteger ;
    pPumpID : PInteger ; pPumpNumber : PInteger ; pPumpName : PWideString ;
    pTankID : PInteger ; pTankNumber : PInteger ; pTankName : PWideString ;
    pGradeID : PInteger  ; pGradeNumber : PInteger ; pGradeName : PWideString ; pGradeShortName : PWideString ; pGradeCode : PWideString ;
    pMtrTheoValue : PDouble  ; pMtrTheoVolume : PDouble ; pMtrElecValue : PDouble  ; pMtrElecVolume : PDouble  ) : Integer; stdcall;

  TDeleteHose = function( ID : Integer  ) : Integer; stdcall;

  TGetDeliveriesCount = function( pCount : PInteger  ) : Integer; stdcall;

  TGetDeliveryByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetAllDeliveriesCount = function( pCount : PInteger  )  : Integer; stdcall;

  TGetAllDeliveryByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TAckDeliveryDBLog = function( ID : Integer  ) : Integer; stdcall;

  TGetDeliveryIDByOrdinalNotLogged = function( Ordinal : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetDeliveriesCountNotLogged = function( pCount : PInteger  ) : Integer; stdcall;

  TAckDeliveryVolLog = function( ID : Integer  ) : Integer; stdcall ;

  TGetDeliveryIDByOrdinalNotVolLogged = function( Ordinal : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetDeliveriesCountNotVolLogged = function( pCount : PInteger  ) : Integer; stdcall;

  TGetDeliveryProperties = function( ID : Integer  ; pHoseID : PInteger  ;pState : PSmallint  ;pType : PSmallint  ;pVolume : PDouble  ;
    pPriceLevel : PSmallint  ;pPrice : PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ;
    pCompletedDT : PDateTime  ;pLockedBy : PInteger  ;pReservedBy : PInteger  ; pAttendantID : PInteger  ; pAge : PInteger  ) : Integer; stdcall;

  TGetDeliveryPropertiesEx = function( ID : Integer  ; pHoseID : PInteger  ;pState : PSmallint  ;pType : PSmallint  ;pVolume : PDouble  ;pPriceLevel : PSmallint  ;
    pPrice : PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ; pCompletedDT : PDateTime  ;pLockedBy : PInteger ; pReservedBy : PInteger  ; pAttendantID : PInteger  ; pAge : PInteger  ;
    pClearedDT : PDateTime  ; pVolumeETot : PDouble  ; pVolume2ETot : PDouble  ; pValueETot : PDouble  ; pTag : PInt64  ) : Integer; stdcall;

  TGetDeliveryPropertiesEx2 = function( ID : Integer  ; pHoseID: PInteger  ;pState : PSmallint  ;pType : PSmallint  ;pVolume : PDouble  ;pPriceLevel : PSmallint  ;
    pPrice : PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ; pCompletedDT : PDateTime  ;pLockedBy : PInteger ; pReservedBy : PInteger  ;
    pAttendantID : PInteger  ; pAge : PInteger  ; pClearedDT : PDateTime  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot  : PDouble  ; pNewVolume2ETot : PDouble  ;pNewValueETot  : PDouble  ;
    pTag  : PInt64  ; pDuration : PInteger ) : Integer; stdcall ;

  TSetDeliveryProperties = function( ID : Integer  ; HoseID : Integer  ;State : Smallint  ;DelType: Smallint  ;Volume : Double  ;PriceLevel : Smallint  ;
    Price : Double  ;Value : Double  ;Volume2 : Double ; CompletedDT : TDateTime  ;LockedBy : Integer ; ReservedBy : Integer  ;
    AttendantID : Integer  ; Age : Integer  ) : Integer; stdcall ;

  TSetDeliveryPropertiesEx = function( ID : Integer  ; HoseID : Integer  ;State : Smallint  ; DelType : Smallint  ;Volume : Double  ; PriceLevel : Smallint  ;
    Price : Double  ;Value : Double  ;Volume2 : Double  ; CompletedDT : TDateTime  ;LockedBy : Integer ;
    ReservedBy : Integer  ; AttendantID : Integer  ; Age : Integer  ; ClearedDT : TDateTime  ; VolumeETot : Double  ; Volume2ETot : Double  ; ValueETot : Double  ; Tag : Int64  ) : Integer; stdcall;

  TSetDeliveryPropertiesEx2 = function( ID : Integer  ; HoseID : Integer  ;State : Smallint  ; DelType : Smallint  ;Volume : Double  ;PriceLevel : Smallint  ;
    Price: Double  ;Value : Double  ;Volume2 : Double  ; CompletedDT : TDateTime  ;LockedBy : Integer ;
    ReservedBy : Integer  ; AttendantID: Integer  ; Age : Integer  ; ClearedDT : TDateTime  ;
    OldVolumeETot : Double  ; OldVolume2ETot : Double  ; OldValueETot : Double  ;
    NewVolumeETot : Double  ; NewVolume2ETot : Double  ; NewValueETot : Double  ;
    Tag : Int64  ; Duration : Integer  ) : Integer; stdcall ;

  TGetDeliverySummary = function(  ID : Integer  ; pHoseID : PInteger  ;pHoseNumber : PInteger ; pHosePhysicalNumber : PInteger ;
    pPumpID : PInteger ; pPumpNumber : PInteger ; pPumpName : PWideString  ;
    pTankID : PInteger ; pTankNumber : PInteger ; pTankName : PWideString  ;
    pGradeID : PInteger  ; pGradeNumber : PInteger ; pGradeName : PWideString  ; ShortGradeName : PWideString  ; pGradeCode : PWideString  ;
    pState : PSmallint  ;pType : PSmallint  ;pVolume : PDouble  ;pPriceLevel : PSmallint  ;
    pPrice : PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ; pCompletedDT : PDateTime  ;pLockedBy : PInteger ;
    pReservedBy : PInteger  ; pAttendantID : PInteger  ; pAge : PInteger  ;pClearedDT : PDateTime  ;
    pVolumeETot : PDouble  ; pVolume2ETot: PDouble  ; pValueETot : PDouble  ; pTag : PInt64 ) : Integer; stdcall;

  TGetDeliverySummaryEx = function( ID : Integer  ; pHoseID : PInteger  ;pHoseNumber : PInteger ; pHosePhysicalNumber : PInteger ;
    pPumpID : PInteger ; pPumpNumber : PInteger ; pPumpName : PWideString  ;
    pTankID : PInteger ; pTankNumber : PInteger ; pTankName : PWideString  ;
    pGradeID : PInteger  ; pGradeNumber : PInteger ; pGradeName : PWideString  ; pGradeShortName : PWideString ;  pGradeCode: PWideString ;
    pState : PSmallint  ;pDelType : PSmallint  ;pVolume : PDouble  ; pPriceLevel : PSmallint  ;
    pPrice: PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ; pCompletedDT : PDateTime  ;pLockedBy : PInteger ;
    pReservedBy : PInteger  ; pAttendantID : PInteger  ; pAge : PInteger  ;pClearedDT : PDateTime  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot : PDouble  ; pNewVolume2ETot : PDouble  ; pNewValueETot : PDouble  ;
    pTag : PInt64  ; pDuration : PInteger  ) : Integer; stdcall;

  TLockDelivery = function( ID : Integer  ) : Integer; stdcall;

  TUnlockDelivery = function( ID : Integer  ) : Integer; stdcall;

  TClearDelivery = function( ID : Integer  ; DelType : Smallint  ) : Integer; stdcall;

  TLockAndClearDelivery = function( ID : Integer  ; DelType : Smallint  ) : Integer; stdcall;

  TGetDuration = function( ID : Integer  ; pDuration : PInteger  ) : Integer; stdcall;

  TGetGradesCount = function(  pCount: PInteger  ) : Integer; stdcall;

  TGetGradeByNumber = function( Number : Integer  ; pID  : PInteger  ) : Integer; stdcall;

  TGetGradeByName = function( Name : WideString  ; pID : PInteger  ) : Integer; stdcall;

  TGetGradeByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetGradeProperties = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString ;
    pShortGradeName : PWideString  ; pCode : PWideString ) : Integer ; stdcall ;

  TGetGradePropertiesEx = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString ;
    pShortGradeName : PWideString  ; pCode : PWideString ; pType : PSmallint ) : Integer ; stdcall ;

  TSetGradeProperties = function( ID : Integer  ; Number : Integer ; Name : WideString  ;
    ShortGradeName : WideString ; Code : WideString ) : Integer; stdcall;

  TSetGradePropertiesEx = function( ID : Integer  ; Number : Integer ; Name : WideString  ;
    ShortGradeName : WideString ; Code : WideString ; Tipo : Smallint ) : Integer; stdcall;

  TDeleteGrade = function( ID : Integer  ) : Integer; stdcall;

  TSetGradePrice = function( ID : Integer  ; Level : Smallint  ; Price : Double  ) : Integer; stdcall;

  TGetGradePrice = function( ID : Integer  ; Level : Smallint  ; pPrice : PDouble  ) : Integer; stdcall;

  TGetTanksCount = function(  pCount: PInteger  ) : Integer; stdcall;

  TGetTankByNumber = function( Number : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetTankByName = function(  Name : WideString  ; pID : PInteger  ) : Integer; stdcall;

  TGetTankByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetTankProperties = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ; pGradeID : PInteger  ; pType : PSmallint  ; pCapacity : PDouble  ; pDiameter : PDouble  ;
    pTheoVolume : PDouble  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ; pGaugeTemperature : PDouble  ;
    pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble ; pGaugeID : PInteger ; pProbeNo : PSmallint  ) : Integer; stdcall;

  TGetTankPropertiesEx = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ; pGradeID : PInteger  ; pType : PSmallint  ; pCapacity : PDouble  ; pDiameter : PDouble  ;
    pTheoVolume : PDouble  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ; pGaugeTemperature : PDouble  ;
    pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble ; pGaugeID : PInteger ;
    pProbeNo : PSmallint ; pGaugeAlarmsMask : PInteger ) : Integer; stdcall;

  TSetTankProperties = function( ID: Integer  ; Number : Integer ; Name : WideString  ; GradeID : Integer  ; TankType: Smallint  ; Capacity : Double  ; Diameter : Double  ; TheoVolume: Double  ;
    GaugeVolume: Double  ; GaugeTCVolume : Double  ;GaugeUllage : Double  ;GaugeTemperature : Double  ; GaugeLevel: Double  ;
    GaugeWaterVolume : Double ; GaugeWaterLevel : Double ; GaugeID : Integer  ; ProbeNo : Smallint  ) : Integer; stdcall;

  TSetTankPropertiesEx = function( ID: Integer  ; Number : Integer ; Name : WideString  ; GradeID : Integer  ; TankType: Smallint  ; Capacity : Double  ; Diameter : Double  ; TheoVolume: Double  ;
    GaugeVolume: Double  ; GaugeTCVolume : Double  ;GaugeUllage : Double  ;GaugeTemperature : Double  ; GaugeLevel: Double  ;
    GaugeWaterVolume : Double ; GaugeWaterLevel : Double ; GaugeID : Integer  ;
    ProbeNo : Smallint ; GaugeAlarmsMask : Integer ) : Integer; stdcall;

  TGetTankSummary = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ; pGradeID : PInteger  ;
     pGradeNumber : PInteger ; pGradeName : PWideString ; pGradeShortName : PWideString ; pGradeCode : PWideString ;
     pTankType: PSmallint  ; pCapacity : PDouble  ; pDiameter : PDouble  ;
     pTheoVolume : PDouble  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ; pGaugeTemperature : PDouble  ;
     pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble ; pGaugeID : PInteger ; pProbeNo: PSmallint  ) : Integer; stdcall;

  TGetTankSummaryEx = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ; pGradeID : PInteger  ;
     pGradeNumber : PInteger ; pGradeName : PWideString ; pGradeShortName : PWideString ; pGradeCode : PWideString ;
     pTankType: PSmallint  ; pCapacity : PDouble  ; pDiameter : PDouble  ;
     pTheoVolume : PDouble  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ; pGaugeTemperature : PDouble  ;
     pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble ; pGaugeID : PInteger ;
     pProbeNo: PSmallint ; pState : PSmallint ; pGaugeAlarmsMask : PInteger ) : Integer; stdcall;

  TTankDrop = function( ID : Integer  ; Volume : Double  ; DropDT : TDateTime  ; Terminal : WideString  ; DocumentType : WideString  ; DocumentDT : TDateTime   ; DocumentFolio : WideString  ; PEMEXVolume : Double  ) : Integer; stdcall;

  TDeleteTank = function( ID  : Integer  ) : Integer; stdcall;

  TGetPortsCount = function( pCount : PInteger  ) : Integer; stdcall;

  TGetPortByNumber = function( Number : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetPortByName = function( Name : WideString  ; pID : PInteger  ) : Integer; stdcall;

  TGetPortByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetPortProperties = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ; pProtocolID: PInteger  ; pDeviceType : PSmallint  ; pSerialNo : PWideString  ) : Integer; stdcall;

  TSetPortProperties = function( ID : Integer  ; Number : Integer ; Name : WideString ; ProtocolID : Integer  ; DeviceType : Smallint  ; SerialNo : WideString  ) : Integer; stdcall;

  TDeletePort = function( ID : Integer  ) : Integer; stdcall;

  TGetAttendantsCount = function( pCount : PInteger  ) : Integer; stdcall;

  TGetAttendantByNumber = function(  Number: Integer  ; pID: PInteger  ) : Integer; stdcall;

  TGetAttendantByName = function( Name : WideString  ; pID: PInteger  ) : Integer; stdcall;

  TGetAttendantByOrdinal = function( Index : Integer  ; pID : PInteger  ) : Integer; stdcall;

  TGetAttendantProperties = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ;  pShortName : PWideString  ; pPassword : PWideString  ; pTag : PWideString  ) : Integer; stdcall;

  TSetAttendantProperties = function( ID : Integer  ; Number : Integer ; Name : WideString  ; ShortName : WideString ; Password : WideString  ; Tag : WideString  ) : Integer; stdcall;

  TDeleteAttendant = function( ID : Integer  ) : Integer; stdcall;

  TAttendantLogon = function( ID : Integer  ; PumpID : Integer  ) : Integer; stdcall;

  TAttendantLogoff = function( ID : Integer  ) : Integer; stdcall;

  TAllStop = function( ) : Integer; stdcall;

  TAllAuthorise = function( ) : Integer; stdcall;

  TAllReAuthorise = function( ) : Integer; stdcall;

  TAllStopIfIdle = function( ) : Integer; stdcall;

  TReadAllTanks = function( ) : Integer; stdcall;

  TGetAllPumpStatuses = function( pStates : PWideString  ; pCurrentHoses : PWideString  ; pDeliveriesCount : PWideString  ) : Integer; stdcall;

  TGetIniValue = function( Section : WideString  ; Key : WideString  ; pValue : PWideString  ) : Integer; stdcall ;

  TSetIniValue = function( Section : WideString  ; Key : WideString  ; Value : WideString  ) : Integer; stdcall ;

  TSetNextDeliveryID = function( ID : Integer  ) : Integer; stdcall ;

  TRemovePort = function( ID : Integer  ) : Integer; stdcall ;

  TLicenseStatus = function( ) : Integer; stdcall ;

  TCheckSocketClosed = function(  lParam : Integer  ) : Integer; stdcall ;

  TResultString = function(  Res: Integer  ) : WideString; stdcall ;

  TPumpStateString = function( State : Smallint  ) : WideString; stdcall ;

  TDeliveryStateString = function( State : Smallint  ) : WideString; stdcall ;

  TDeliveryTypeString = function( DelType : Smallint  ) : WideString; stdcall ;

  TReserveTypeString = function( ResType : Smallint  ) : WideString; stdcall ;

  TGetNextPumpEventEx = function( pPumpID : PInteger ; pPumpNumber : PSmallint ; pState : PSmallint ; pReservedFor : PSmallint ; pReservedBy : PInteger ; pHoseID : PInteger  ;
    pHoseNumber : PSmallint ; pGradeID : PInteger ; pGradeName : PWideString  ; pShortGradeName : PWideString ; pPriceLevel: PSmallint  ; pPrice : PDouble ; pVolume : PDouble ;
    pValue : PDouble ; pStackSize : PSmallint  ; pPumpName : PWideString  ; pPhysicalNumber : PSmallint  ; pSide : PSmallint  ; pAddress : PSmallint ;
    pPriceLevel1 : PSmallint  ; pPriceLevel2 : PSmallint  ; pType : PSmallint  ; pPortID : PInteger  ; pAuthMode : PSmallint  ; pStackMode : PSmallint  ; pPrepayAllowed : PSmallint ;
    pPreauthAllowed : PSmallint  ; pPriceFormat : PSmallint  ; pValueFormat : PSmallint  ; pVolumeFormat : PSmallint   ) : Integer; stdcall ;

  TGetNextDeliveryEventEx = function( pDeliveryID : PInteger  ; pPumpID : PInteger ; pPumpNumber : PSmallint ; pHoseID : PInteger ; pHoseNumber : PSmallint  ;
    pGradeID : PInteger ; pGradeName : PWideString  ; pShortGradeName: PWideString ; pPriceLevel: PSmallint ; pPrice : PDouble ;
    pVolume: PDouble ; pValue : PDouble ; pDeliveryState : PSmallint  ;
    pDeliveryType : PSmallint ; pLockedBy : PInteger ; pReservedBy : PInteger ; pAge : PInteger  ; pCompletedDT : PDateTime  ;
    pAttendantID : PInteger ; pVolumeETot : PDouble  ; pVolume2ETot : PDouble  ; pValueETot : PDouble  ; pTag : PInt64 ) : Integer; stdcall ;

  TGetNextDeliveryEventEx2 = function( pDeliveryID : PInteger  ; pPumpID : PInteger ; pPumpNumber : PSmallint ; pHoseID : PInteger ; pHoseNumber : PSmallint  ;
     pGradeID : PInteger ; pGradeName : PWideString  ; pShortGradeName : PWideString ; pPriceLevel : PSmallint ; pPrice : PDouble ;
     pVolume : PDouble ; pValue : PDouble ; pDeliveryState : PSmallint  ;
     pDeliveryType : PSmallint ; pLockedBy : PInteger ; pReservedBy : PInteger ; pAge : PInteger  ; pCompletedDT : PDateTime  ;
     pAttendantID : PInteger ;
     pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
     pNewVolumeETot: PDouble  ; pNewVolume2ETot : PDouble  ; pNewValueETot : PDouble  ;
     pTag: PInt64  ; pDuration : PInteger  ) : Integer; stdcall ;

  TGetNextDBHoseETotalsEventEx = function( pHoseID : PInteger  ; pVolume : PDouble  ; pValue : PDouble  ; pVolumeETot : PDouble  ; pValueETot : PDouble  ;
    pHoseNumber : PInteger  ; pHosePhysicalNumber : PInteger  ; pPumpID : PInteger  ; pPumpNumber : PInteger  ; pPumpName : PWideString  ;
    pTankID : PInteger  ; pTankNumber : PInteger  ; pTankName : PWideString  ; pGradeID : PInteger  ; pGradeName : PWideString  ) : Integer; stdcall ;

  TGetNextDBTankStatusEventEx = function( pTankID : PInteger  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ;
    pGaugeTemperature : PDouble  ; pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble  ;
    pTankNumber : PInteger  ; pTankName : PWideString  ; pGradeID : PInteger  ; pGradeName : PWideString  ; pShortGradeName : PWideString ;
    pCapacity : PDouble  ; pDiameter : PDouble  ; pGaugeID : PInteger  ; pProbeNo : PSmallint ) : Integer; stdcall ;

  TGetNextDBTankStatusEventEx2 = function( pTankID : PInteger  ; pGaugeVolume : PDouble  ; pGaugeTCVolume : PDouble ; pGaugeUllage : PDouble ;
    pGaugeTemperature : PDouble  ; pGaugeLevel : PDouble  ; pGaugeWaterVolume : PDouble ; pGaugeWaterLevel : PDouble  ;
    pTankNumber : PInteger  ; pTankName : PWideString  ; pGradeID : PInteger  ; pGradeName : PWideString  ; pShortGradeName : PWideString ;
    pCapacity : PDouble  ; pDiameter : PDouble  ; pGaugeID : PInteger  ; pProbeNo : PSmallint ; pState : PSmallInt ; pAlarmsMask : PInteger ) : Integer; stdcall ;

  TGetNextLogEventEvent = function( pLogEventID : PInteger ; pDeviceType : PSmallint ; pDeviceID : PInteger ; pDeviceNumber : PInteger ; pDeviceName : PWideString ; pEventLevel : PSmallInt ;
    pEventType : PSmallint ; pEventDesc : PWideString ; pGeneratedDT : PDateTime ; pClearedDT : PDateTime ; pClearedBy : PInteger ; pAckedBy : PInteger ; pVolume : PDouble ;
    pValue : PDouble ; pProductVolume : PDouble ; pProductLevel : PDouble ; pWaterLevel : PDouble ; pTemperature : PDouble ) : Integer; stdcall ;

  TGetZB2GConfig = function( ID : Integer ; pPanID : PInt64 ; pChannels : PInteger ;
    pKeyA : PInt64 ; pKeyB : PInt64 ) : Integer; stdcall ;

  TGetZigBeeCount = function( pCount : PInteger  ) : Integer; stdcall ;

  TGetZigBeeByNumber = function( Number : Integer  ; pID : PInteger  ) : Integer; stdcall ;

  TGetZigBeeByName = function( Name : WideString  ; pID: PInteger  ) : Integer; stdcall ;

  TGetZigBeeByOrdinal = function( Index : Integer  ; pID: PInteger  ) : Integer; stdcall ;

  TGetZigBeeProperties = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString  ; pDeviceType : PSmallint  ; pSerialNumber : PWideString  ; pNodeIdentifier : PWideString  ; pPortID : PInteger  ) : Integer; stdcall ;

  TSetZigBeeProperties = function( ID : Integer  ; Number : Integer ; Name : WideString  ; DeviceType : Smallint  ; SerialNumber : WideString  ; NodeIdentifier : WideString  ; PortID : Integer  ) : Integer; stdcall ;

  TDeleteZigBee = function( ID : Integer  ) : Integer; stdcall ;

  TGetHosePropertiesEx = function( ID  : Integer  ; pNumber : PInteger ; pPumpID : PInteger  ;pTankID : PInteger  ; pPhysicalNumber : PInteger ;
    pMtrTheoValue : PDouble  ; pMtrTheoVolume : PDouble  ;pMtrElecValue : PDouble  ;
    pMtrElecVolume : PDouble  ; pUVEAntenna : PSmallint  ) : Integer; stdcall ;

  TSetHosePropertiesEx = function( ID : Integer  ; Number : Integer ;PumpID : Integer ; TankID : Integer  ; PhysicalNumber : Integer ;
    MtrTheoValue : Double  ; MtrTheoVolume : Double  ;MtrElecValue : Double  ;
    MtrElecVolume: Double  ; UVEAntenna: Smallint  ): Integer; stdcall ;

  TSetPumpPropertiesEx = function( ID : Integer  ; Number : Integer ; Name : WideString ; PhysicalNumber : Smallint ; Side : Smallint ; Address : Smallint ; PriceLevel1 : Smallint ;
    PriceLevel2 : Smallint ; PriceDspFormat : Smallint ; VolumeDspFormat : Smallint ; ValueDspFormat: Smallint ; PumpType : Smallint ;
    PortID : Integer ; AttendantID : Integer ; AuthMode : Smallint ; StackMode : Smallint ; PrepayAllowed : Smallint ; PreauthAllowed : Smallint  ;
    SlotZigBeeID : Integer  ; MuxSlotZigBeeID : Integer  ; PriceControl : Smallint  ; HasPreset : Smallint  ) : Integer; stdcall ;

  TGetPumpPropertiesEx = function( ID : Integer  ; pNumber : PInteger ; pName : PWideString ; pPhysicalNumber : PSmallint ; pSide : PSmallint ; pAddress : PSmallint ; pPriceLevel1 : PSmallint ;
    pPriceLevel2 : PSmallint ; pPriceDspFormat : PSmallint ; pVolumeDspFormat : PSmallint ; pValueDspFormat : PSmallint ; pType : PSmallint ;
    pPortID : PInteger ; pAttendantID : PInteger ; pAuthMode : PSmallint ; pStackMode : PSmallint ; pPrepayAllowed : PSmallint ; pPreauthAllowed : PSmallint  ;
    pSlotZigBeeID : PInteger  ; pMuxSlotZigBeeID : PInteger  ; pPriceControl : PSmallint  ; pHasPreset : PSmallint ) : Integer; stdcall ;

  TGetSerialNo = function(  ID : Integer  ; pSerialNo : PWideString  ) : Integer; stdcall ;

  TResetDevice = function( ID : Integer ; ZBID : Integer ) : Integer ; stdcall ;

  TRequestVersion = function( ID : Integer ; ZBID : Integer ) : Integer ; stdcall ;

  TGetAttendantState = function( ID : Integer ; pType : PSmallInt ; pLoggedOn : PSmallInt ) : Integer ; stdcall ;

  TGetDeviceDetails = function( ID : Integer  ; ZBID : Integer  ; pSerialNo : PWideString  ; pBootVersion : PWideString  ; pFirmwareVersion : PWideString  ) : Integer; stdcall ;

  TSetHoseETotals = function( ID : Integer  ; Volume : Double  ; Value : Double  ) : Integer; stdcall ;

  TGetNextZeroDeliveryEvent = function( pPumpID  : PInteger  ; pPumpNumber : PInteger  ; pHoseID : PInteger  ; pHoseNumber : PInteger  ) : Integer; stdcall ;

  TSetHosePrices = function( ID : Integer  ; DurationType : Smallint  ; PriceType : Smallint  ; Price1 : Double  ; Price2 : Double  ) : Integer; stdcall ;

  TGetHosePrices = function( ID : Integer  ; pDurationType : PSmallint  ; pPriceType : PSmallint  ; pPrice1 : PDouble  ; pPrice2 : PDouble  ) : Integer; stdcall ;

  TScheduleBeep = function( ID : Integer ; Pitch1 : Smallint ; Duration1 : Smallint ;
    Pitch2 : Smallint ; Duration2 : Smallint ; Pitch3 : Smallint ; Duration3 : Smallint ;
    Pitch4 : Smallint ; Duration4 : Smallint ; Pitch5 : Smallint ; Duration5 : Smallint) : Integer; stdcall ;

  TPaymentCancel = function( ID : Integer ; TermID : Integer ; TermHash : WideString ) : Integer; stdcall ;

  TPaymentReserve = function( ID : Integer ; TermID : Integer ; TermHash : WideString ) : Integer; stdcall ;

  TPaymentAuthorise = function( ID : Integer ; TermID : Integer ; TermHash : WideString ;
     AttendantID : Integer ; AttendantTag : Int64 ; CardClientID : Integer ;
     CardClientTag : Int64 ; AuthType : Smallint ; ExtTag : Int64 ;
     GradeType : Smallint ; PriceType : Smallint ; PriceLevel : Smallint ;
     Price : Double ; PresetType : Smallint ; Value : Double ; Hose : Smallint ;
     Odometer : Double ; Odometer2 : Double ; Plate : WideString ; ExtTransactionID : WideString ;
     DriverID : WideString ; AuthorisationID : WideString ) : Integer; stdcall ;

  TFlashLEDS = function( ID : Integer ; Side : Smallint ; PeriodMs : Smallint ; Cycles : Smallint ) : Integer; stdcall ;

  TSetPumpDefaultPriceLevel = function( ID : Integer  ; Level : Smallint  ) : Integer; stdcall ;

  TSetDateTime = function(  DateTime : TDateTime  ) : Integer; stdcall ;

  TGetClientsCount = function ( pCount : PInteger ) : Integer; stdcall ;

  TGetDateTime = function ( pDateTime : PDateTime ) : Integer; stdcall ;

  TGetNextDeliveryEventEx3 = function( pDeliveryID : PInteger ;  pHoseID : PInteger ;  pHoseNumber : PInteger ;  pHosePhysicalNumber : PInteger ;
    pPumpID : PInteger ;  pPumpNumber : PInteger ;  pPumpName : PWideString ;
    pTankID : PInteger ; pTankNumber : PInteger ;   pTankName : PWideString ;
    pGradeID : PInteger ;  pGradeNumber : PInteger ;   pGradeName : PWideString ;   pGradeShortName : PWideString ;  pGradeCode : PWideString ;
    pDeliveryState : PSmallint ;   pDeliveryType : PSmallint ; pVolume : PDouble ;   pPriceLevel : PSmallint ;
    pPrice : PDouble ;  pValue : PDouble ;   pVolume2 : PDouble ; pCompletedDT : PDateTime ; pLockedBy : PInteger ;
    pReservedBy : PInteger ; pAttendantID : PInteger ; pAge : PInteger ;  pClearedDT : PDateTime ;
    pOldVolumeETot : PDouble ;  pOldVolume2ETot : PDouble ;   pOldValueETot : PDouble ;
    pNewVolumeETot : PDouble ;  pNewVolume2ETot : PDouble ;   pNewValueETot : PDouble ;
    pTag : PInt64 ; pDuration : PInteger ;   pAttendantNumber : PInteger ;  pAttendantName : PWideString ;   pAttendantTag : PInt64 ;
    pCardClientID : PInteger ; pCardClientNumber : PInteger ;  pCardClientName : PWideString ;  pCardClientTag : PInt64 ) : Integer; stdcall ;

  TGetNextDeliveryEventEx4 = function( pDeliveryID : PInteger ;  pHoseID : PInteger ;  pHoseNumber : PInteger ;  pHosePhysicalNumber : PInteger ;
    pPumpID : PInteger ;  pPumpNumber : PInteger ;  pPumpName : PWideString ;
    pTankID : PInteger ; pTankNumber : PInteger ;   pTankName : PWideString ;
    pGradeID : PInteger ;  pGradeNumber : PInteger ;   pGradeName : PWideString ;   pGradeShortName : PWideString ;  pGradeCode : PWideString ;
    pDeliveryState : PSmallint ;   pDeliveryType : PSmallint ; pVolume : PDouble ;   pPriceLevel : PSmallint ;
    pPrice : PDouble ;  pValue : PDouble ;   pVolume2 : PDouble ; pCompletedDT : PDateTime ; pLockedBy : PInteger ;
    pReservedBy : PInteger ; pAttendantID : PInteger ; pAge : PInteger ;  pClearedDT : PDateTime ;
    pOldVolumeETot : PDouble ;  pOldVolume2ETot : PDouble ;   pOldValueETot : PDouble ;
    pNewVolumeETot : PDouble ;  pNewVolume2ETot : PDouble ;   pNewValueETot : PDouble ;
    pTag : PInt64 ; pDuration : PInteger ;   pAttendantNumber : PInteger ;  pAttendantName : PWideString ;   pAttendantTag : PInt64 ;
    pCardClientID : PInteger ; pCardClientNumber : PInteger ;  pCardClientName : PWideString ;  pCardClientTag : PInt64 ; pPeakFlowRate : PDouble ) : Integer; stdcall ;

  TGetNextCardReadEvent = function(  pCardReadID : PInteger ;  pNumber : PInteger ; pName : PWideString ; PumpID : PInteger ;  pCardType : PSmallint ; pParentID : PInteger ; pTag : PInt64 ; pTimeStamp : PDateTime ) : Integer; stdcall ;

  TGetCardReadsCount = function(  Count : PInteger ) : Integer; stdcall ;

  TGetCardReadByNumber = function(  Number : Integer ; pID : PInteger ) : Integer; stdcall ;

  TGetCardReadByName = function(  Name : WideString ; pID : PInteger ) : Integer; stdcall ;

  TGetCardReadByOrdinal = function(  Index : Integer ; pID : PInteger ) : Integer; stdcall ;

  TGetCardReadProperties = function( ID : Integer ; pNumber : PInteger ; pName : PWideString ; PumpID : PInteger ; pCardType : PSmallint ; ParentID : PInteger ; pTag : PInt64 ; pTimeStamp : PDateTime )  : Integer; stdcall ;

  TSetCardReadProperties = function( ID : Integer ; Number : Integer ; Name : WideString ; PumpID : Integer ;  CardType : Smallint ;  ParentID : Integer ;  Tag : Int64 ;  TimeStamp : TDateTime ) : Integer; stdcall ;

  TDeleteCardRead = function( ID : Integer ) : Integer; stdcall ;

  TGetCardClientsCount = function( Count : PInteger ) : Integer; stdcall ;

  TGetCardClientByNumber = function(  Number : Integer ; ID : PInteger ) : Integer; stdcall ;

  TGetCardClientByName = function(  Name : WideString ;  ID : PInteger ) : Integer; stdcall ;

  TGetCardClientByOrdinal = function( Index : Integer  ;  ID : PInteger ) : Integer; stdcall ;

  TGetCardClientProperties = function( ID : Integer ; pNumber : PInteger ;
    pName : PWideString ; pTag : PWideString ; pEnabled : PSmallint )  : Integer; stdcall ;

  TGetCardClientPropertiesEx = function( ID : Integer ; pNumber : PInteger ;
    pName : PWideString ; pTag : PWideString ; pEnabled : PSmallint ;
    pPriceLevel : PSmallint ; pPlate : PWideString )  : Integer; stdcall ;

  TGetCardClientPropertiesEx2 = function( ID : Integer ; pNumber : PInteger ;
    pName : PWideString ; pTag : PWideString ; pEnabled : PSmallint ;
    pPriceLevel : PSmallint ; pPlate : PWideString ; pGradeType : PSmallint ) : Integer; stdcall ;

  TSetCardClientProperties = function( ID : Integer ; Number : Integer ; Name : WideString ; Tag : WideString ;  Enabled : Smallint )  : Integer; stdcall ;

  TSetCardClientPropertiesEx = function( ID : Integer ; Number : Integer ;
    Name : WideString ; Tag : WideString ; Enabled : Smallint ;
    PriceLevel : Smallint ; Plate : WideString )  : Integer; stdcall ;

  TSetCardClientPropertiesEx2 = function( ID : Integer ; Number : Integer ;
    Name : WideString ; Tag : WideString ; Enabled : Smallint ;
    PriceLevel : Smallint ; Plate : WideString ; GradeType : Smallint ) : Integer; stdcall ;

  TDeleteCardClient = function( ID : Integer ) : Integer; stdcall ;

  TGetCardType = function( Tag : WideString ; pTagType : PInteger ; pID : PInteger ;
    pName : PWideString ; pNumber : PInteger ) : Integer; stdcall ;

  TGetDeliveryExt = function( ID : Integer ; pPlate : PWideString ; pOdometer : PDouble ;
    pOdometer2 : PDouble ; pExtTransactionID : PWideString ; pDriverID : PWideString ;
    pAuthID : PWideString ; pAuthType : PSmallint ) : Integer; stdcall ;

  TSetDeliveryExt = function( ID : Integer ; Plate : WideString ; Odometer : Double ;
    Odometer2 : Double ; ExtTransactionID : WideString ; DriverID : WideString ;
    AuthID : WideString ; AuthType : Smallint ) : Integer; stdcall ;

  TGetDeliverySummaryEx2 = function(  DeliveryID : Integer ;  pHoseID : PInteger ;  pHoseNumber : PInteger ;  pHosePhysicalNumber : PInteger ;
    pPumpID : PInteger ;  pPumpNumber : PInteger ;  pPumpName : PWideString ;
    pTankID : PInteger ; pTankNumber : PInteger ;   pTankName : PWideString ;
    pGradeID : PInteger ;  pGradeNumber : PInteger ;   pGradeName : PWideString ;   pGradeShortName : PWideString ;  pGradeCode : PWideString ;
    pDeliveryState : PSmallint ;   pDeliveryType : PSmallint ; pVolume : PDouble ;   pPriceLevel : PSmallint ;
    pPrice : PDouble ;  pValue : PDouble ;   pVolume2 : PDouble ; pCompletedDT : PDateTime ; pLockedBy : PInteger ;
    pReservedBy : PInteger ; pAttendantID : PInteger ; pAge : PInteger ;  pClearedDT : PDateTime ;
    pOldVolumeETot : PDouble ;  pOldVolume2ETot : PDouble ;   pOldValueETot : PDouble ;
    pNewVolumeETot : PDouble ;  pNewVolume2ETot : PDouble ;   pNewValueETot : PDouble ;
    pTag : PInt64 ; pDuration : PInteger ;   pAttendantNumber : PInteger ;  pAttendantName : PWideString ;   pAttendantTag : PInt64 ;
    pCardClientID : PInteger ; pCardClientNumber : PInteger ;  pCardClientName : PWideString ;  pCardClientTag : PInt64 ) : Integer; stdcall ;

  TGetDeliverySummaryEx3 = function(  DeliveryID : Integer ;  pHoseID : PInteger ;  pHoseNumber : PInteger ;  pHosePhysicalNumber : PInteger ;
    pPumpID : PInteger ;  pPumpNumber : PInteger ;  pPumpName : PWideString ;
    pTankID : PInteger ; pTankNumber : PInteger ;   pTankName : PWideString ;
    pGradeID : PInteger ;  pGradeNumber : PInteger ;   pGradeName : PWideString ;   pGradeShortName : PWideString ;  pGradeCode : PWideString ;
    pDeliveryState : PSmallint ;   pDeliveryType : PSmallint ; pVolume : PDouble ;   pPriceLevel : PSmallint ;
    pPrice : PDouble ;  pValue : PDouble ;   pVolume2 : PDouble ; pCompletedDT : PDateTime ; pLockedBy : PInteger ;
    pReservedBy : PInteger ; pAttendantID : PInteger ; pAge : PInteger ;  pClearedDT : PDateTime ;
    pOldVolumeETot : PDouble ;  pOldVolume2ETot : PDouble ;   pOldValueETot : PDouble ;
    pNewVolumeETot : PDouble ;  pNewVolume2ETot : PDouble ;   pNewValueETot : PDouble ;
    pTag : PInt64 ; pDuration : PInteger ;   pAttendantNumber : PInteger ;  pAttendantName : PWideString ;   pAttendantTag : PInt64 ;
    pCardClientID : PInteger ; pCardClientNumber : PInteger ;  pCardClientName : PWideString ;
    pCardClientTag : PInt64 ; pPeakFlowRate : PDouble ) : Integer; stdcall ;

  TSetDeliveryPropertiesEx3 = function( ID : Integer  ; HoseID : Integer  ;State : Smallint  ; DelType : Smallint  ;Volume : Double  ;PriceLevel : Smallint  ;
     Price: Double  ;Value : Double  ;Volume2 : Double  ; CompletedDT : TDateTime  ;LockedBy : Integer ;
     ReservedBy : Integer  ; AttendantID: Integer  ; Age : Integer  ; ClearedDT : TDateTime  ;
     OldVolumeETot : Double  ; OldVolume2ETot : Double  ; OldValueETot : Double  ;
     NewVolumeETot : Double  ; NewVolume2ETot : Double  ; NewValueETot : Double  ;
     Tag : Int64  ; Duration : Integer ;   CardClientID : Integer  ) : Integer; stdcall ;

  TSetDeliveryPropertiesEx4 = function( ID : Integer  ; HoseID : Integer  ;State : Smallint  ; DelType : Smallint  ;Volume : Double  ;PriceLevel : Smallint  ;
     Price: Double  ;Value : Double  ;Volume2 : Double  ; CompletedDT : TDateTime  ;LockedBy : Integer ;
     ReservedBy : Integer  ; AttendantID: Integer  ; Age : Integer  ; ClearedDT : TDateTime  ;
     OldVolumeETot : Double  ; OldVolume2ETot : Double  ; OldValueETot : Double  ;
     NewVolumeETot : Double  ; NewVolume2ETot : Double  ; NewValueETot : Double  ;
     Tag : Int64  ; Duration : Integer ;   CardClientID : Integer ; PeakFlowRate : Double ) : Integer; stdcall ;

  TGetDeliveryPropertiesEx3 = function( ID : Integer  ; pHoseID: PInteger  ;pState : PSmallint  ;pType : PSmallint  ;pVolume : PDouble  ;pPriceLevel : PSmallint  ;
    pPrice : PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ; pCompletedDT : PDateTime  ;pLockedBy : PInteger ; pReservedBy : PInteger  ;
    pAttendantID : PInteger  ; pAge : PInteger  ; pClearedDT : PDateTime  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot  : PDouble  ; pNewVolume2ETot : PDouble  ;pNewValueETot  : PDouble  ;
    pTag  : PInt64  ; pDuration : PInteger ; CardClientID : PInteger ) : Integer; stdcall ;

  TGetDeliveryPropertiesEx4 = function( ID : Integer  ; pHoseID: PInteger  ;pState : PSmallint  ;pType : PSmallint  ;pVolume : PDouble  ;pPriceLevel : PSmallint  ;
    pPrice : PDouble  ;pValue : PDouble  ;pVolume2 : PDouble  ; pCompletedDT : PDateTime  ;pLockedBy : PInteger ; pReservedBy : PInteger  ;
    pAttendantID : PInteger  ; pAge : PInteger  ; pClearedDT : PDateTime  ;
    pOldVolumeETot : PDouble  ; pOldVolume2ETot : PDouble  ; pOldValueETot : PDouble  ;
    pNewVolumeETot  : PDouble  ; pNewVolume2ETot : PDouble  ;pNewValueETot  : PDouble  ;
    pTag  : PInt64  ; pDuration : PInteger ; CardClientID : PInteger ; pPeakFlowRate : PDouble ) : Integer; stdcall ;

  TGetAttendantPropertiesEx = function(ID : Integer  ; pNumber : PInteger ; pName : PWideString  ;  pShortName : PWideString  ; pPassword : PWideString  ; pTag : PWideString ;
    pShiftAStart : PSmallint ;  pShiftAEnd : PSmallint ;  pShiftBStart : PSmallint ; pShiftBEnd : PSmallint ; pEnabled : PSmallint  )  : Integer; stdcall ;

  TSetAttendantPropertiesEx = function(ID : Integer  ; Number : Integer ; Name : WideString  ; ShortName : WideString ; Password : WideString  ; Tag : WideString ;
    ShiftAStart : Smallint ; ShiftAEnd : Smallint ; ShiftBStart : Smallint ; ShiftBEnd : Smallint ; Enabled : Smallint )  : Integer; stdcall ;

  TGetHosePropertiesEx2 = function(ID  : Integer  ; pNumber : PInteger ; pPumpID : PInteger  ;pTankID : PInteger  ; pPhysicalNumber : PInteger ;
    pMtrTheoValue : PDouble  ; pMtrTheoVolume : PDouble  ;pMtrElecValue : PDouble  ;
    pMtrElecVolume : PDouble  ; pUVEAntenna : PSmallint ; pPrice1 : PDouble  ; pPrice2 : PDouble ; pEnabled : PSmallint ) : Integer; stdcall ;

  TSetHosePropertiesEx2 = function(ID : Integer  ; Number : Integer ;PumpID : Integer ; TankID : Integer  ; PhysicalNumber : Integer ;
    MtrTheoValue : Double  ; MtrTheoVolume : Double  ; MtrElecValue : Double  ;
    MtrElecVolume: Double  ; UVEAntenna: Smallint ; Price1 : Double ; Price2 :  Double ; Enabled :  Smallint ) : Integer; stdcall ;

  TGetHoseSummaryEx = function(	ID	: Integer  ; pNumber : PInteger ; pPhysicalNumber : PInteger ;
    pPumpID : PInteger ; pPumpNumber : PInteger ; pPumpName : PWideString ;
    pTankID : PInteger ; pTankNumber : PInteger ; pTankName : PWideString ;
    pGradeID : PInteger  ; pGradeNumber : PInteger ; pGradeName : PWideString ; pGradeShortName : PWideString ; pGradeCode : PWideString ;
    pMtrTheoValue : PDouble  ; pMtrTheoVolume : PDouble ; pMtrElecValue : PDouble  ; pMtrElecVolume : PDouble ;
    pPrice1 : PDouble ; pPrice2 : PDouble ; pEnabled : PSmallint ) : Integer; stdcall ;

  TGetNextPumpEventEx2 = function( PumpID : PInteger ; PumpNumber : PInteger ; State : PSmallint ; ReservedFor : PSmallint ; ReservedBy : PInteger ; HoseID : PInteger ;
    pHoseNumber : PInteger ;  pHosePhysicalNumber : PInteger ;  pGradeID :  PInteger ; pGradeNumber :  PInteger  ; pGradeName : PWideString ; pShortGradeName : PWideString ; pPriceLevel : PSmallint ;  Price : PDouble ;  Volume : PDouble ;
    pValue : PDouble ; pStackSize : PSmallint ; pPumpName : PWideString ; pPhysicalNumber : PInteger ; pSide : PSmallint ; pAddress : PSmallint ;
    pPriceLevel1 : PSmallint ; pPriceLevel2 : PSmallint ; pPumpType : PSmallint ; pPortID : PInteger  ; pAuthMode : PSmallint  ;  pStackMode : PSmallint ; pPrepayAllowed : PSmallint ;
    pPreauthAllowed : PSmallint ; pPriceFormat : PSmallint ; pValueFormat : PSmallint ; pVolumeFormat : PSmallint ; pTag : PInt64 ;
    pAttendantID : PInteger ; pAttendantNumber : PInteger ; pAttendantName : PWideString ; pAttendantTag : PInt64 ;
    pCardClientID : PInteger  ; pCardClientNumber : PInteger ; pCardClientName : PWideString ; pCardClientTag : PInt64  ) : Integer; stdcall ;

  TGetNextPumpEventEx3 = function( PumpID : PInteger ; PumpNumber : PInteger ; State : PSmallint ; ReservedFor : PSmallint ; ReservedBy : PInteger ; HoseID : PInteger ;
    pHoseNumber : PInteger ;  pHosePhysicalNumber : PInteger ;  pGradeID :  PInteger ; pGradeNumber :  PInteger  ; pGradeName : PWideString ; pShortGradeName : PWideString ; pPriceLevel : PSmallint ;  Price : PDouble ;  Volume : PDouble ;
    pValue : PDouble ; pStackSize : PSmallint ; pPumpName : PWideString ; pPhysicalNumber : PInteger ; pSide : PSmallint ; pAddress : PSmallint ;
    pPriceLevel1 : PSmallint ; pPriceLevel2 : PSmallint ; pPumpType : PSmallint ; pPortID : PInteger  ; pAuthMode : PSmallint  ;  pStackMode : PSmallint ; pPrepayAllowed : PSmallint ;
    pPreauthAllowed : PSmallint ; pPriceFormat : PSmallint ; pValueFormat : PSmallint ; pVolumeFormat : PSmallint ; pTag : PInt64 ;
    pAttendantID : PInteger ; pAttendantNumber : PInteger ; pAttendantName : PWideString ; pAttendantTag : PInt64 ;
    pCardClientID : PInteger  ; pCardClientNumber : PInteger ; pCardClientName : PWideString ; pCardClientTag : PInt64 ; pCurFlowRate : PDouble ; pPeakFlowRate : PDouble  ) : Integer; stdcall ;

  TGetPumpStatusEx = function( ID : Integer ; pPumpNumber : PInteger ; pPumpName : PWideString ; pPhysicalNumber : PInteger ; pState : PSmallint ; pReservedFor : PSmallint ; pReservedBy : PInteger ; pHoseID : PInteger ; pHoseNumber : PInteger ; pHosePhysicalNumber : PInteger ; pGradeID : PInteger ;
     pGradeNumber : PInteger  ; pGradeName : PWideString ; pShortGradeName : PWideString ; pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble ;  Value : PDouble ;
     pStackSize : PSmallint  ; pTag : PInt64  ;
     pAttendantID : PInteger ; pAttendantNumber : PInteger ; pAttendantName : PWideString  ; pAttendantTag : PInt64 ;
     pCardClientID : PInteger  ; pCardClientNumber : PInteger ; pCardClientName : PWideString ; pCardClientTag : PInt64  ) : Integer; stdcall ;

  TGetPumpStatusEx2 = function( ID : Integer ; pPumpNumber : PInteger ; pPumpName : PWideString ; pPhysicalNumber : PInteger ; pState : PSmallint ; pReservedFor : PSmallint ; pReservedBy : PInteger ; pHoseID : PInteger ; pHoseNumber : PInteger ; pHosePhysicalNumber : PInteger ; pGradeID : PInteger ;
     pGradeNumber : PInteger  ; pGradeName : PWideString ; pShortGradeName : PWideString ; pPriceLevel : PSmallint ; pPrice : PDouble  ; pVolume : PDouble ;  Value : PDouble ;
     pStackSize : PSmallint  ; pTag : PInt64  ;
     pAttendantID : PInteger ; pAttendantNumber : PInteger ; pAttendantName : PWideString  ; pAttendantTag : PInt64 ;
     pCardClientID : PInteger  ; pCardClientNumber : PInteger ; pCardClientName : PWideString ; pCardClientTag : PInt64 ;
     pCurFlowRate : PDouble ; pPeakFlowRate : PDouble  ) : Integer; stdcall ;

  TGetNextZB2GStatusEvent = function( pPortID : PInteger ; pZBAddress : PInt64 ; pLQI : PSmallint ; pRSSI : PSmallint ; pParZBAddress : PInt64 ; ZBChannel : PSmallint ; pMemBlocks : PSmallint ; pMemFree : PSmallint ) : Integer ; stdcall ;

  TEnablePump = function( ID : Integer ) : Integer; stdcall ;

  TDisablePump = function( ID : Integer ) : Integer; stdcall ;

  TGetSensorsCount = function( pCount : PInteger ) : Integer; stdcall ;

  TGetSensorByNumber = function( Number : Integer ; pID : PInteger )
    : Integer; stdcall ;

  TGetSensorByName = function( Name : WideString ; pID : PInteger )
    : Integer; stdcall ;

  TGetSensorByOrdinal = function( Index : Integer ; pID : PInteger )
    : Integer; stdcall ;

  TGetSensorProperties = function( ID : Integer ; pNumber : PInteger ;
    pName : PWideString ; pPortID : PInteger ; pType : PSmallInt ;
    pAddress : PSmallInt ; pSensorNo : PSmallInt ) : Integer; stdcall ;

  TSetSensorProperties = function( ID : Integer ; Number : Integer ;
    Name : WideString ; PortID : Integer ; Tipo : SmallInt ;
    Address : SmallInt ; SensorNo : SmallInt ) : Integer; stdcall ;

  TGetSensorStatus = function( ID : Integer ; pState : PSmallint ; pIsResponding : PSmallint )
    : Integer; stdcall ;

  TSetSensorStatus = function( ID : Integer ; State : Smallint ; IsResponding : Smallint )
    : Integer; stdcall ;

  TDeleteSensor = function( ID : Integer )
    : Integer; stdcall ;

  TGetLogEventCount = function( pCount : PInteger ; DeviceType : Smallint ;
    DeviceID : Integer ; EventLevel : SmallInt ; EventType : SmallInt ;
    ClearedBy : Integer ; AckedBy : Integer ) : Integer; stdcall ;

  TGetLogEventByOrdinal = function( Index : Integer ; pID : PInteger ; DeviceType : Smallint ;
    DeviceID : Integer ; EventLevel : SmallInt ; EventType : SmallInt ;
    ClearedBy : Integer ; AckedBy : Integer ) : Integer; stdcall ;

  TGetLogEventProperties = function( ID : Integer ; pDeviceType : PSmallInt ;
    pDeviceID : PInteger ; pDeviceNumber : PInteger ; pDeviceName : PWideString ;
    pEventLevel : PSmallInt ; pEventType : PSmallInt ; pEventDesc : PWideString ;
    pGeneratedDT : PDateTime ; pClearedDT : PDateTime ; pClearedBy : PInteger ;
    pAckedBy : PInteger ; pVolume : PDouble ; pValue : PDouble ; pProductVolume : PDouble ;
    pProductLevel : PDouble ; pWaterLevel : PDouble ; pTemperature : PDouble )
    : Integer; stdcall ;

  TSetLogEventProperties = function( ID : Integer ; DeviceType : SmallInt ;
    DeviceID : Integer ; DeviceNumber : Integer ; DeviceName : WideString ;
    EventLevel : SmallInt ; EventType : SmallInt ; EventDesc : WideString ;
    GeneratedDT : TDateTime ; ClearedDT : TDateTime ; ClearedBy : Integer ;
    AckedBy : Integer ; Volume : Double ; Value : Double ; ProductVolume : Double ;
    ProductLevel : Double ; WaterLevel : Double ; Temperature : Double )
    : Integer; stdcall ;

  TDeleteLogEvent = function( ID : Integer ) : Integer; stdcall ;

  TClearLogEvent = function( ID : Integer ; ClientID : Integer ) : Integer; stdcall ;

  TAckLogEvent = function( ID : Integer ; ClientID : Integer ) : Integer; stdcall ;

//------------------------------------------------------------------------------
type
  TEZClient = class

  //----------------------------------------------------------------------------
  private
    DllLoaded: Boolean;

  //----------------------------------------------------------------------------
  public
    DllVersion : TDllVersion ;
    ServerVersion : TServerVersion ;
    ClientLogon : TClientLogon ;
    ClientLogonEx : TClientLogonEx ;
    ClientLogoff : TClientLogoff ;
    ClientStatus : TClientStatus ;
    GetLicenseType : TGetLicenseType ;
    FireClientEvent : TFireClientEvent ;
    TestConnection : TTestConnection ;
    ProcessEvents : TProcessEvents ;
    GetEventsCount : TGetEventsCount ;
    GetNextEventType : TGetNextEventType ;
    DiscardNextEvent : TDiscardNextEvent ;
    GetNextPumpEvent : TGetNextPumpEvent ;
    GetNextDeliveryEvent : TGetNextDeliveryEvent ;
    GetNextServerEvent : TGetNextServerEvent ;
    GetNextClientEvent : TGetNextClientEvent ;
    GetNextDBLogEvent : TGetNextDBLogEvent ;
    GetNextDBClearDeliveryEvent : TGetNextDBClearDeliveryEvent ;
    GetNextDBStackDeliveryEvent : TGetNextDBStackDeliveryEvent ;
    GetNextDBHoseETotalsEvent : TGetNextDBHoseETotalsEvent ;
    GetNextDBTriggerEvent : TGetNextDBTriggerEvent ;
    GetNextDBAttendantLogonEvent : TGetNextDBAttendantLogonEvent ;
    GetNextDBAttendantLogoffEvent : TGetNextDBAttendantLogoffEvent ;
    GetNextDBTankStatusEvent : TGetNextDBTankStatusEvent ;
    GetPumpsCount : TGetPumpsCount ;
    GetPumpByNumber : TGetPumpByNumber ;
    GetPumpByName : TGetPumpByName ;
    GetPumpByOrdinal : TGetPumpByOrdinal ;
    GetPumpProperties : TGetPumpProperties;
    SetPumpProperties : TSetPumpProperties ;
    DeletePump : TDeletePump ;
    GetPumpHosesCount : TGetPumpHosesCount ;
    GetPumpHoseByNumber : TGetPumpHoseByNumber ;
    GetPumpStatus : TGetPumpStatus ;
    GetPumpDeliveryProperties : TGetPumpDeliveryProperties ;
    GetPumpDeliveryPropertiesEx : TGetPumpDeliveryPropertiesEx ;
    GetPumpDeliveryPropertiesEx2 : TGetPumpDeliveryPropertiesEx2 ;
    PrepayReserve : TPrepayReserve ;
    PrepayCancel : TPrepayCancel ;
    PrepayAuthorise : TPrepayAuthorise ;
    PreauthReserve : TPreauthReserve ;
    PreauthCancel : TPreauthCancel ;
    PreauthAuthorise : TPreauthAuthorise ;
    LoadPreset : TLoadPreset ;
    LoadPresetWithPrice : TLoadPresetWithPrice ;
    TagAuthorise : TTagAuthorise ;
    AttendantAuthorise : TAttendantAuthorise ;
    Authorise : TAuthorise;
    CancelAuthorise : TCancelAuthorise ;
    TempStop : TTempStop ;
    ReAuthorise : TReAuthorise ;
    TerminateDelivery  : TTerminateDelivery ;
    StackCurrentDelivery : TStackCurrentDelivery ;
    GetDensity : TGetDensity ;
    GetHosesCount : TGetHosesCount ;
    GetHoseByOrdinal : TGetHoseByOrdinal ;
    GetHoseProperties : TGetHoseProperties ;
    SetHoseProperties  : TSetHoseProperties ;
    GetHoseSummary  : TGetHoseSummary ;
    DeleteHose : TDeleteHose ;
    GetDeliveriesCount : TGetDeliveriesCount ;
    GetDeliveryByOrdinal : TGetDeliveryByOrdinal ;
    GetAllDeliveriesCount : TGetAllDeliveriesCount ;
    GetAllDeliveryByOrdinal : TGetAllDeliveryByOrdinal ;
    AckDeliveryDBLog : TAckDeliveryDBLog ;
    GetDeliveryIDByOrdinalNotLogged : TGetDeliveryIDByOrdinalNotLogged ;
    GetDeliveriesCountNotLogged : TGetDeliveriesCountNotLogged ;
    AckDeliveryVolLog : TAckDeliveryVolLog ;
    GetDeliveryIDByOrdinalNotVolLogged : TGetDeliveryIDByOrdinalNotVolLogged ;
    GetDeliveriesCountNotVolLogged : TGetDeliveriesCountNotVolLogged ;
    GetDeliveryProperties : TGetDeliveryProperties ;
    GetDeliveryPropertiesEx : TGetDeliveryPropertiesEx ;
    GetDeliveryPropertiesEx2 : TGetDeliveryPropertiesEx2 ;
    SetDeliveryProperties : TSetDeliveryProperties ;
    SetDeliveryPropertiesEx : TSetDeliveryPropertiesEx ;
    SetDeliveryPropertiesEx2 : TSetDeliveryPropertiesEx2 ;
    GetDeliverySummary : TGetDeliverySummary ;
    GetDeliverySummaryEx : TGetDeliverySummaryEx ;
    LockDelivery : TLockDelivery ;
    UnlockDelivery : TUnlockDelivery ;
    ClearDelivery : TClearDelivery ;
    LockAndClearDelivery : TLockAndClearDelivery ;
    GetDuration : TGetDuration ;
    GetGradesCount : TGetGradesCount ;
    GetGradeByNumber : TGetGradeByNumber ;
    GetGradeByName : TGetGradeByName ;
    GetGradeByOrdinal : TGetGradeByOrdinal ;
    GetGradeProperties : TGetGradeProperties ;
    SetGradeProperties : TSetGradeProperties ;
    DeleteGrade : TDeleteGrade ;
    SetGradePrice : TSetGradePrice ;
    GetGradePrice : TGetGradePrice ;
    GetTanksCount : TGetTanksCount ;
    GetTankByNumber : TGetTankByNumber ;
    GetTankByName : TGetTankByName ;
    GetTankByOrdinal : TGetTankByOrdinal ;
    GetTankProperties : TGetTankProperties ;
    SetTankProperties : TSetTankProperties ;
    GetTankSummary : TGetTankSummary ;
    TankDrop : TTankDrop ;
    DeleteTank : TDeleteTank ;
    GetPortsCount : TGetPortsCount ;
    GetPortByNumber : TGetPortByNumber ;
    GetPortByName : TGetPortByName ;
    GetPortByOrdinal : TGetPortByOrdinal ;
    GetPortProperties : TGetPortProperties ;
    SetPortProperties : TSetPortProperties ;
    DeletePort : TDeletePort ;
    GetAttendantsCount : TGetAttendantsCount ;
    GetAttendantByNumber : TGetAttendantByNumber ;
    GetAttendantByName : TGetAttendantByName ;
    GetAttendantByOrdinal : TGetAttendantByOrdinal ;
    GetAttendantProperties : TGetAttendantProperties ;
    SetAttendantProperties : TSetAttendantProperties ;
    DeleteAttendant : TDeleteAttendant ;
    AttendantLogon : TAttendantLogon ;
    AttendantLogoff : TAttendantLogoff ;
    AllStop: TAllStop ;
    AllAuthorise : TAllAuthorise ;
    AllReAuthorise : TAllReAuthorise ;
    AllStopIfIdle : TAllStopIfIdle ;
    ReadAllTanks : TReadAllTanks ;
    GetAllPumpStatuses : TGetAllPumpStatuses ;
    GetIniValue : TGetIniValue;
    SetIniValue : TSetIniValue ;
    GetClientsCount : TGetClientsCount ;
    SetNextDeliveryID : TSetNextDeliveryID ;
    RemovePort : TRemovePort ;
    LicenseStatus : TLicenseStatus ;
    CheckSocketClosed : TCheckSocketClosed ;
    ResultString : TResultString ;
    PumpStateString : TPumpStateString ;
    DeliveryStateString : TDeliveryStateString ;
    DeliveryTypeString : TDeliveryTypeString ;
    ReserveTypeString : TReserveTypeString ;
    GetNextPumpEventEx : TGetNextPumpEventEx  ;
    GetNextDeliveryEventEx : TGetNextDeliveryEventEx ;
    GetNextDeliveryEventEx2 : TGetNextDeliveryEventEx2 ;
    GetNextDBHoseETotalsEventEx : TGetNextDBHoseETotalsEventEx ;
    GetNextDBTankStatusEventEx : TGetNextDBTankStatusEventEx ;
    GetZigBeeCount : TGetZigBeeCount ;
    GetZigBeeByNumber : TGetZigBeeByNumber ;
    GetZigBeeByName : TGetZigBeeByName ;
    GetZigBeeByOrdinal : TGetZigBeeByOrdinal ;
    GetZigBeeProperties : TGetZigBeeProperties ;
    SetZigBeeProperties : TSetZigBeeProperties ;
    DeleteZigBee : TDeleteZigBee ;
    GetHosePropertiesEx : TGetHosePropertiesEx ;
    SetHosePropertiesEx : TSetHosePropertiesEx ;
    SetPumpPropertiesEx : TSetPumpPropertiesEx ;
    GetPumpPropertiesEx : TGetPumpPropertiesEx ;
    GetDeviceDetails : TGetDeviceDetails ;
    SetHoseETotals : TSetHoseETotals ;
    GetNextZeroDeliveryEvent : TGetNextZeroDeliveryEvent ;
    SetHosePrices : TSetHosePrices ;
    GetHosePrices : TGetHosePrices ;
    SetDateTime : TSetDateTime ;
    GetNextDeliveryEventEx3 : TGetNextDeliveryEventEx3 ;
    GetNextCardReadEvent : TGetNextCardReadEvent ;
    GetCardReadsCount : TGetCardReadsCount ;
    GetCardReadByNumber : TGetCardReadByNumber ;
    GetCardReadByName : TGetCardReadByName ;
    GetCardReadByOrdinal : TGetCardReadByOrdinal ;
    GetCardReadProperties : TGetCardReadProperties ;
    SetCardReadProperties : TSetCardReadProperties ;
    DeleteCardRead : TDeleteCardRead ;
    GetCardClientsCount : TGetCardClientsCount ;
    GetCardClientByNumber : TGetCardClientByNumber ;
    GetCardClientByName : TGetCardClientByName ;
    GetCardClientByOrdinal : TGetCardClientByOrdinal ;
    GetCardClientProperties : TGetCardClientProperties ;
    SetCardClientProperties : TSetCardClientProperties ;
    DeleteCardClient : TDeleteCardClient ;
    GetDeliverySummaryEx2 : TGetDeliverySummaryEx2 ;
    SetDeliveryPropertiesEx3 : TSetDeliveryPropertiesEx3 ;
    GetDeliveryPropertiesEx3 : TGetDeliveryPropertiesEx3 ;
    GetAttendantPropertiesEx : TGetAttendantPropertiesEx ;
    SetAttendantPropertiesEx : TSetAttendantPropertiesEx ;
    GetHosePropertiesEx2 : TGetHosePropertiesEx2 ;
    SetHosePropertiesEx2 : TSetHosePropertiesEx2 ;
    GetHoseSummaryEx : TGetHoseSummaryEx ;
    GetNextPumpEventEx2 : TGetNextPumpEventEx2 ;
    GetPumpStatusEx : TGetPumpStatusEx ;
    GetDateTime : TGetDateTime ;
    GetNextPumpEventEx3 : TGetNextPumpEventEx3 ;
    GetNextDeliveryEventEx4 : TGetNextDeliveryEventEx4 ;
    GetNextDBLogDeliveryEvent : TGetNextDBLogDeliveryEvent ;
    GetNextZB2GStatusEvent : TGetNextZB2GStatusEvent ;
    GetNextDBTankStatusEventEx2 : TGetNextDBTankStatusEventEx2 ;
    GetNextLogEventEvent : TGetNextLogEventEvent ;
    GetPumpStatusEx2 : TGetPumpStatusEx2 ;
    EnablePump : TEnablePump ;
    DisablePump : TDisablePump ;
    SetPumpDefaultPriceLevel : TSetPumpDefaultPriceLevel ;
    ScheduleBeep : TScheduleBeep ;
    FlashLEDS : TFlashLEDS ;
    PaymentReserve : TPaymentReserve ;
    PaymentCancel : TPaymentCancel ;
    PaymentAuthorise : TPaymentAuthorise ;
    GetDeliveryPropertiesEx4 : TGetDeliveryPropertiesEx4 ;
    SetDeliveryPropertiesEx4 : TSetDeliveryPropertiesEx4 ;
    GetDeliverySummaryEx3 : TGetDeliverySummaryEx3 ;
    SetDeliveryExt : TSetDeliveryExt ;
    GetDeliveryExt : TGetDeliveryExt ;
    GetPumpDeliveryPropertiesEx3 : TGetPumpDeliveryPropertiesEx3 ;
    GetPumpDeliveryPropertiesEx4 : TGetPumpDeliveryPropertiesEx4 ;
    GetGradePropertiesEx : TGetGradePropertiesEx ;
    SetGradePropertiesEx : TSetGradePropertiesEx ;
    GetTankPropertiesEx : TGetTankPropertiesEx ;
    SetTankPropertiesEx : TSetTankPropertiesEx ;
    GetTankSummaryEx : TGetTankSummaryEx ;
    GetZB2GConfig : TGetZB2GConfig ;
    GetSerialNo : TGetSerialNo ;
    ResetDevice : TResetDevice ;
    RequestVersion : TRequestVersion ;
    GetAttendantState : TGetAttendantState ;
    GetCardClientPropertiesEx : TGetCardClientPropertiesEx ;
    GetCardClientPropertiesEx2 : TGetCardClientPropertiesEx2 ;
    SetCardClientPropertiesEx : TSetCardClientPropertiesEx ;
    SetCardClientPropertiesEx2 : TSetCardClientPropertiesEx2 ;
    GetCardType : TGetCardType ;
    GetSensorsCount : TGetSensorsCount ;
    GetSensorByNumber : TGetSensorByNumber ;
    GetSensorByName : TGetSensorByName ;
    GetSensorByOrdinal : TGetSensorByOrdinal ;
    GetSensorProperties : TGetSensorProperties ;
    SetSensorProperties : TSetSensorProperties ;
    SetSensorStatus : TSetSensorStatus ;
    GetSensorStatus : TGetSensorStatus ;
    DeleteSensor : TDeleteSensor ;
    GetLogEventCount : TGetLogEventCount ;
    GetLogEventByOrdinal : TGetLogEventByOrdinal ;
    GetLogEventProperties : TGetLogEventProperties ;
    SetLogEventProperties : TSetLogEventProperties ;
    DeleteLogEvent : TDeleteLogEvent ;
    ClearLogEvent : TClearLogEvent ;
    AckLogEvent : TAckLogEvent ;

    published

    //--------------------------------------------------------------------------
    property IsLoaded: Boolean
      read DllLoaded;

    //--------------------------------------------------------------------------
    constructor Create;

    function LoadDll() : Boolean;

  end;

TClientEvent =
(
	NO_CLIENT_EVENT = 0 ,
	PUMP_EVENT ,
	DELIVERY_EVENT ,
	SERVER_EVENT ,
	CLIENT_EVENT ,
	DB_LOG_EVENT ,
	DB_LOG_DELIVERY ,
	DB_CLEAR_DELIVERY ,
	DB_STACK_DELIVERY ,
	DB_LOG_ETOTALS ,
	DB_TRIGGER ,
	DB_ATTENDANT_LOGON_EVENT ,
	DB_ATTENDANT_LOGOFF_EVENT ,
	DB_TANK_STATUS ,
	SERIAL_PORT_EVENT ,
	ZIGBEE_EVENT ,
	UVE_EVENT ,
  ZERO_DELIVERY_EVENT ,
	ZB_STATUS_EVENT ,
	ZB_PAN_EVENT ,
	ZIGBEE_CMD_EVENT ,
	ZIGBEE_RAW_EVENT,
  CARD_READ_EVENT,
  ZB2G_STATUS_EVENT ,
  LOG_EVENT_EVENT
);

TDisplayFormat =
(
	PUMP_DISPLAY_4_3 = 1 ,		// 9.999
	PUMP_DISPLAY_4_2 ,		// 99.99
	PUMP_DISPLAY_4_1 ,		// 999.9
	PUMP_DISPLAY_4_0 ,		// 9999
	PUMP_DISPLAY_5_3 ,		// 99.999
	PUMP_DISPLAY_5_2 ,		// 999.99
	PUMP_DISPLAY_5_1 ,		// 9999.9
	PUMP_DISPLAY_5_0 ,		// 99999
	PUMP_DISPLAY_6_3 ,		// 999.999
	PUMP_DISPLAY_6_2 ,		// 9999.99
	PUMP_DISPLAY_6_1 ,		// 99999.9
	PUMP_DISPLAY_6_0 ,		// 999999
	PUMP_DISPLAY_4_N1 ,		// 99990
	PUMP_DISPLAY_4_N2 ,		// 999900
	PUMP_DISPLAY_4_N3 ,		// 9999000
	PUMP_DISPLAY_5_N1 ,		// 999990
	PUMP_DISPLAY_5_N2 ,		// 9999900
	PUMP_DISPLAY_5_N3 ,		// 99999000
	PUMP_DISPLAY_6_N1 ,		// 9999990
	PUMP_DISPLAY_6_N2 ,		// 99999900
	PUMP_DISPLAY_6_N3 		// 999999000
) ;

TAuthMode =
(
	NOT_AUTHABLE = 1 ,
	COMP_AUTH ,
	AUTO_AUTH ,
	MONITOR_AUTH ,
	ATTENDANT_AUTH ,
	ATTENDANT_MONITOR_AUTH ,
	CTF_AUTH ,
	TAG_AUTH ,
	OFFLINE_AUTH ,
	ATTENDANT_TAG_AUTH
) ;

TStackMode =
(
	STACK_DISABLED = 1 ,
  STACK_MANUAL ,
	STACK_AUTO
) ;

TDeliveryState =
(
	CURRENT = 1 ,
	STACKED ,
	CLEARED
) ;

TDeliveryType =
(
	POSTPAY = 1 ,
	PREPAY ,
	PREPAY_REFUND ,
	PREAUTH ,
	MONITOR ,
	TEST ,
	DRIVEOFF ,
	OFFLINE ,
	CTF
) ;

TPresetType =
(
	NO_PRESET_TYPE = 1 ,
	DOLLAR_PRESET_TYPE ,
	VOLUME_PRESET_TYPE ,
	DOLLAR_PREPAY_TYPE ,
	VOLUME_PREPAY_TYPE ,
	DOLLAR_PREAUTH_TYPE ,
	VOLUME_PREAUTH_TYPE
) ;

TPumpState =
(
	INVALID_PUMP_STATE = 0 ,
	NOT_INSTALLED_PUMP_STATE ,
	NOT_RESPONDING_1_PUMP_STATE ,
	IDLE_PUMP_STATE ,
	PRICE_CHANGE_STATE ,
	AUTHED_PUMP_STATE ,
	CALLING_PUMP_STATE ,
	DELIVERY_STARTING_PUMP_STATE ,
	DELIVERING_PUMP_STATE ,
	TEMP_STOPPED_PUMP_STATE ,
	DELIVERY_FINISHING_PUMP_STATE ,
	DELIVERY_FINISHED_PUMP_STATE ,
	DELIVERY_TIMEOUT_PUMP_STATE ,
	HOSE_OUT_PUMP_STATE ,
	PREPAY_REFUND_TIMEOUT_STATE ,
	DELIVERY_TERMINATED_STATE ,
	ERROR_PUMP_STATE ,
	NOT_RESPONDING_2_PUMP_STATE ,
	LAST_PUMP_STATE
) ;

TPriceType =
(
	UNKNOW_PRICE_TYPE ,
	FIXED_PRICE_TYPE ,
	DISCOUNT_PRICE_TYPE ,
	SURCHARGE_PRICE_TYPE
);

TDurationType =
(
	UNKNOWN_DURATION_TYPE ,
	SINGLE_DURATION_TYPE ,
	MULTIPLE_DURATION_TYPE
);

TTagType =
(
  INVALID_TAG_TYPE ,
  ATTENDANT_TAG_TYPE ,
  BLOCKED_ATTENDANT_TAG_TYPE ,
  WRONG_SHIFT_ATTENDANT_TAG_TYPE ,
  CLIENT_TAG_TYPE ,
  BLOCKED_CLIENT_TAG_TYPE ,
  UNKNOWN_TAG_TYPE
);

TAllocLimitType =
(
	INVALID_LIMIT_TYPE = 0 ,
	NO_LIMIT_TYPE ,
	DOLLAR_LIMIT_TYPE ,
	VOLUME_LIMIT_TYPE
);


//-----------------------------------------------------------------------------
implementation

  constructor TEZClient.Create;
  begin

    self.DllLoaded := false;

    if self.LoadDll = false then
    begin
      ShowMessage('Erro carregando EZClient.dll');
    end
    else
      self.DllLoaded := true;

  end;

  //----------------------------------------------------------------------------
  function TEZClient.LoadDll: Boolean;
  var
      handle : THandle;
  begin
    LoadDll := false ;

    handle := LoadLibrary('\EZForecourt\EZClient.dll');
    if handle = 0 then  exit ;

//--------------------------------- Connection -----------------------------------------//

    @ClientLogon := GetProcAddress(handle, 'ClientLogon');
    if @ClientLogon = nil  then  exit ;

    @ClientLogonEx := GetProcAddress(handle, 'ClientLogonEx');
    if @ClientLogonEx = nil  then  exit ;

    @DllVersion :=  GetProcAddress(handle, 'DllVersion');
    if @DllVersion = nil  then exit ;

    @ServerVersion := GetProcAddress(handle, 'ServerVersion');
    if @ServerVersion = nil  then  exit ;

    @ClientLogoff := GetProcAddress(handle, 'ClientLogoff');
    if @ClientLogoff = nil  then  exit ;

    @ClientStatus := GetProcAddress(handle, 'ClientStatus');
    if @ClientStatus = nil  then  exit ;

    @TestConnection := GetProcAddress(handle, 'TestConnection');
    if @TestConnection = nil  then  exit ;

    @LicenseStatus := GetProcAddress(handle, 'LicenseStatus');
    if @LicenseStatus = nil  then  exit ;

    @GetLicenseType := GetProcAddress(handle, 'GetLicenseType');
    if @GetLicenseType = nil  then  exit ;

    @GetIniValue := GetProcAddress(handle, 'GetIniValue');
    if @GetIniValue = nil  then  exit ;

    @SetIniValue := GetProcAddress(handle, 'SetIniValue');
    if @SetIniValue = nil  then  exit ;

    @GetClientsCount := GetProcAddress(handle, 'GetClientsCount');
    if @GetClientsCount = nil  then  exit ;

    @SetDateTime := GetProcAddress(handle, 'SetDateTime');
    if @SetDateTime = nil  then  exit ;

    @GetDateTime := GetProcAddress(handle, 'GetDateTime');
    if @GetDateTime = nil  then  exit ;

    @ResultString := GetProcAddress(handle, 'ResultString');
    if @ResultString = nil  then  exit ;

    @CheckSocketClosed := GetProcAddress(handle, 'CheckSocketClosed');
    if @CheckSocketClosed = nil  then  exit ;

//--------------------------------- Events --------------------------------------------//

    @ProcessEvents := GetProcAddress(handle, 'ProcessEvents');
    if @ProcessEvents = nil  then  exit ;

    @GetEventsCount := GetProcAddress(handle, 'GetEventsCount');
    if @GetEventsCount = nil  then  exit ;

    @GetNextEventType := GetProcAddress(handle, 'GetNextEventType');
    if @GetNextEventType = nil  then  exit ;

    @DiscardNextEvent := GetProcAddress(handle, 'DiscardNextEvent');
    if @DiscardNextEvent = nil  then  exit ;

    @GetNextPumpEvent := GetProcAddress(handle, 'GetNextPumpEvent');
    if @GetNextPumpEvent = nil  then  exit ;

    @GetNextPumpEventEx := GetProcAddress(handle, 'GetNextPumpEventEx');
    if @GetNextPumpEventEx = nil  then  exit ;

    GetNextPumpEventEx2 := GetProcAddress(handle, 'GetNextPumpEventEx2');
    if @GetNextPumpEventEx2 = nil  then  exit ;

    GetNextPumpEventEx3 := GetProcAddress(handle, 'GetNextPumpEventEx3');
    if @GetNextPumpEventEx3 = nil  then  exit ;

    @GetNextDeliveryEvent := GetProcAddress(handle, 'GetNextDeliveryEvent');
    if @GetNextDeliveryEvent = nil  then  exit ;

    @GetNextDeliveryEventEx := GetProcAddress(handle, 'GetNextDeliveryEventEx');
    if @GetNextDeliveryEventEx = nil  then  exit ;

    @GetNextDeliveryEventEx2 := GetProcAddress(handle, 'GetNextDeliveryEventEx2');
    if @GetNextDeliveryEventEx2 = nil  then  exit ;

    GetNextDeliveryEventEx3 := GetProcAddress(handle, 'GetNextDeliveryEventEx3');
    if @GetNextDeliveryEventEx3 = nil  then  exit ;

    GetNextDeliveryEventEx4 := GetProcAddress(handle, 'GetNextDeliveryEventEx4');
    if @GetNextDeliveryEventEx4 = nil  then  exit ;

    @GetNextServerEvent := GetProcAddress(handle, 'GetNextServerEvent');
    if @GetNextServerEvent = nil  then  exit ;

    @GetNextClientEvent := GetProcAddress(handle, 'GetNextClientEvent');
    if @GetNextClientEvent = nil  then  exit ;

    @FireClientEvent := GetProcAddress(handle, 'FireClientEvent');
    if @FireClientEvent = nil  then  exit ;

    @GetNextDBLogEvent := GetProcAddress(handle, 'GetNextDBLogEvent');
    if @GetNextDBLogEvent = nil  then  exit ;

    @GetNextDBLogDeliveryEvent := GetProcAddress(handle, 'GetNextDBLogDeliveryEvent');
    if @GetNextDBLogDeliveryEvent = nil  then  exit ;

    @GetNextZB2GStatusEvent := GetProcAddress(handle, 'GetNextZB2GStatusEvent');
    if @GetNextZB2GStatusEvent = nil  then  exit ;

    @GetNextDBClearDeliveryEvent := GetProcAddress(handle, 'GetNextDBClearDeliveryEvent');
    if @GetNextDBClearDeliveryEvent = nil  then  exit ;

    @GetNextDBStackDeliveryEvent := GetProcAddress(handle, 'GetNextDBStackDeliveryEvent');
    if @GetNextDBStackDeliveryEvent = nil  then  exit ;

     @GetNextDBHoseETotalsEvent := GetProcAddress(handle, 'GetNextDBHoseETotalsEvent');
    if @GetNextDBHoseETotalsEvent = nil  then  exit ;

    @GetNextDBHoseETotalsEventEx := GetProcAddress(handle, 'GetNextDBHoseETotalsEventEx');
    if @GetNextDBHoseETotalsEventEx = nil  then  exit ;

    @GetNextDBTriggerEvent := GetProcAddress(handle, 'GetNextDBTriggerEvent');
    if @GetNextDBTriggerEvent = nil  then  exit ;

    @GetNextDBAttendantLogonEvent := GetProcAddress(handle, 'GetNextDBAttendantLogonEvent');
    if @GetNextDBAttendantLogonEvent = nil  then  exit ;

    @GetNextDBAttendantLogoffEvent := GetProcAddress(handle, 'GetNextDBAttendantLogoffEvent');
    if @GetNextDBAttendantLogoffEvent = nil  then  exit ;

    @GetNextDBTankStatusEvent := GetProcAddress(handle, 'GetNextDBTankStatusEvent');
    if @GetNextDBTankStatusEvent = nil  then  exit ;

    @GetNextDBTankStatusEventEx := GetProcAddress(handle, 'GetNextDBTankStatusEventEx');
    if @GetNextDBTankStatusEventEx = nil  then  exit ;

    @GetNextDBTankStatusEventEx2 := GetProcAddress(handle, 'GetNextDBTankStatusEventEx2');
    if @GetNextDBTankStatusEventEx2 = nil  then  exit ;

    GetNextCardReadEvent := GetProcAddress(handle, 'GetNextCardReadEvent');
    if @GetNextCardReadEvent = nil  then  exit ;

    GetNextLogEventEvent := GetProcAddress(handle, 'GetNextLogEventEvent');
    if @GetNextLogEventEvent = nil  then  exit ;

    @GetNextZeroDeliveryEvent := GetProcAddress(handle, 'GetNextZeroDeliveryEvent');
    if @GetNextZeroDeliveryEvent = nil  then  exit ;

//--------------------------------- Pumps ---------------------------------------------//

    @GetPumpsCount := GetProcAddress(handle, 'GetPumpsCount');
    if @GetPumpsCount = nil  then  exit ;

    @GetPumpByNumber := GetProcAddress(handle, 'GetPumpByNumber');
    if @GetPumpByNumber = nil  then  exit ;

    @GetPumpByName := GetProcAddress(handle, 'GetPumpByName');
    if @GetPumpByName = nil  then  exit ;

    @GetPumpByOrdinal := GetProcAddress(handle, 'GetPumpByOrdinal');
    if @GetPumpByOrdinal = nil  then  exit ;

    @GetPumpProperties := GetProcAddress(handle, 'GetPumpProperties');
    if @GetPumpProperties = nil  then  exit ;

    @GetPumpPropertiesEx := GetProcAddress(handle, 'GetPumpPropertiesEx');
    if @GetPumpPropertiesEx = nil  then  exit ;

    @SetPumpProperties := GetProcAddress(handle, 'SetPumpProperties');
    if @SetPumpProperties = nil  then  exit ;

    @SetPumpPropertiesEx := GetProcAddress(handle, 'SetPumpPropertiesEx');
    if @SetPumpPropertiesEx = nil  then  exit ;

    @DeletePump := GetProcAddress(handle, 'DeletePump');
    if @DeletePump = nil  then  exit ;

    @GetPumpHosesCount := GetProcAddress(handle, 'GetPumpHosesCount');
    if @GetPumpHosesCount = nil  then  exit ;

    @GetPumpHoseByNumber := GetProcAddress(handle, 'GetPumpHoseByNumber');
    if @GetPumpHoseByNumber = nil  then  exit ;

    @GetPumpStatus := GetProcAddress(handle, 'GetPumpStatus');
    if @GetPumpStatus = nil  then  exit ;

    GetPumpStatusEx := GetProcAddress(handle, 'GetPumpStatusEx');
    if @GetPumpStatusEx = nil  then  exit ;

    GetPumpStatusEx2 := GetProcAddress(handle, 'GetPumpStatusEx2');
    if @GetPumpStatusEx2 = nil  then  exit ;

    @PumpStateString := GetProcAddress(handle, 'PumpStateString');
    if @PumpStateString = nil  then  exit ;

    @EnablePump := GetProcAddress(handle, 'EnablePump');
    if @EnablePump = nil  then  exit ;

    @DisablePump := GetProcAddress(handle, 'DisablePump');
    if @DisablePump = nil  then  exit ;

    @SetPumpDefaultPriceLevel := GetProcAddress(handle, 'SetPumpDefaultPriceLevel');
    if @SetPumpDefaultPriceLevel = nil  then  exit ;

    @GetDensity := GetProcAddress(handle, 'GetDensity');
    if @GetDensity = nil  then  exit ;

    @ScheduleBeep := GetProcAddress(handle, 'ScheduleBeep');
    if @ScheduleBeep = nil  then  exit ;

    @FlashLEDS := GetProcAddress(handle, 'FlashLEDS');
    if @FlashLEDS = nil  then  exit ;

//--------------------------- Pump prepay deliveries ----------------------------------//

    @PrepayReserve := GetProcAddress(handle, 'PrepayReserve');
    if @PrepayReserve = nil  then  exit ;

    @PrepayCancel := GetProcAddress(handle, 'PrepayCancel');
    if @PrepayCancel = nil  then  exit ;

    @PrepayAuthorise := GetProcAddress(handle, 'PrepayAuthorise');
    if @PrepayAuthorise = nil  then  exit ;

//--------------------------- Pump preauth deliveries ---------------------------------//

    @PreauthReserve := GetProcAddress(handle, 'PreauthReserve');
    if @PreauthReserve = nil  then  exit ;

    @PreauthCancel := GetProcAddress(handle, 'PreauthCancel');
    if @PreauthCancel = nil  then  exit ;

    @PreauthAuthorise := GetProcAddress(handle, 'PreauthAuthorise');
    if @PreauthAuthorise = nil  then  exit ;

//--------------------------- Pump payment deliveries ---------------------------------//

    @PaymentReserve := GetProcAddress(handle, 'PaymentReserve');
    if @PaymentReserve = nil  then  exit ;

    @PaymentCancel := GetProcAddress(handle, 'PaymentCancel');
    if @PaymentCancel = nil  then  exit ;

    @PaymentAuthorise := GetProcAddress(handle, 'PaymentAuthorise');
    if @PaymentAuthorise = nil  then  exit ;

//------------------------------ Pump authorization ------------------------------------//

    @AttendantAuthorise := GetProcAddress(handle, 'AttendantAuthorise');
    if @AttendantAuthorise = nil  then  exit ;

    @Authorise := GetProcAddress(handle, 'Authorise');
    if @Authorise = nil  then  exit ;

    @CancelAuthorise := GetProcAddress(handle, 'CancelAuthorise');
    if @CancelAuthorise = nil  then  exit ;

    @TempStop := GetProcAddress(handle, 'TempStop');
    if @TempStop = nil  then  exit ;

    @ReAuthorise := GetProcAddress(handle, 'ReAuthorise');
    if @ReAuthorise = nil  then  exit ;

    @TerminateDelivery := GetProcAddress(handle, 'TerminateDelivery');
    if @TerminateDelivery = nil  then  exit ;

    @LoadPreset := GetProcAddress(handle, 'LoadPreset');
    if @LoadPreset = nil  then  exit ;

    @LoadPresetWithPrice := GetProcAddress(handle, 'LoadPresetWithPrice');
    if @LoadPresetWithPrice = nil  then  exit ;

    @TagAuthorise := GetProcAddress(handle, 'TagAuthorise');
    if @TagAuthorise = nil  then  exit ;

//-------------------------------- Global functions ------------------------------------//

    @AllStop := GetProcAddress(handle, 'AllStop');
    if @AllStop = nil  then  exit ;

    @AllAuthorise := GetProcAddress(handle, 'AllAuthorise');
    if @AllAuthorise = nil  then  exit ;

    @AllReAuthorise := GetProcAddress(handle, 'AllReAuthorise');
    if @AllReAuthorise = nil  then  exit ;

    @AllStopIfIdle := GetProcAddress(handle, 'AllStopIfIdle');
    if @AllStopIfIdle = nil  then  exit ;

    @ReadAllTanks := GetProcAddress(handle, 'ReadAllTanks');
    if @ReadAllTanks = nil  then  exit ;

    @GetAllPumpStatuses := GetProcAddress(handle, 'GetAllPumpStatuses');
    if @GetAllPumpStatuses = nil  then  exit ;

//------------------------------------ Deliveries --------------------------------------//

    @GetDeliveriesCount := GetProcAddress(handle, 'GetDeliveriesCount');
    if @GetDeliveriesCount = nil  then  exit ;

    @GetDeliveryByOrdinal := GetProcAddress(handle, 'GetDeliveryByOrdinal');
    if @GetDeliveryByOrdinal = nil  then  exit ;

    @GetDeliveryProperties := GetProcAddress(handle, 'GetDeliveryProperties');
    if @GetDeliveryProperties = nil  then  exit ;

    @GetDeliveryPropertiesEx := GetProcAddress(handle, 'GetDeliveryPropertiesEx');
    if @GetDeliveryPropertiesEx = nil  then  exit ;

    @GetDeliveryPropertiesEx2 := GetProcAddress(handle, 'GetDeliveryPropertiesEx2');
    if @GetDeliveryPropertiesEx2 = nil  then  exit ;

    GetDeliveryPropertiesEx3 := GetProcAddress(handle, 'GetDeliveryPropertiesEx3');
    if @GetDeliveryPropertiesEx3 = nil  then  exit ;

    GetDeliveryPropertiesEx4 := GetProcAddress(handle, 'GetDeliveryPropertiesEx4');
    if @GetDeliveryPropertiesEx4 = nil  then  exit ;

    @SetDeliveryProperties := GetProcAddress(handle, 'SetDeliveryProperties');
    if @SetDeliveryProperties = nil  then  exit ;

    @SetDeliveryPropertiesEx := GetProcAddress(handle, 'SetDeliveryPropertiesEx');
    if @SetDeliveryPropertiesEx = nil  then  exit ;

    @SetDeliveryPropertiesEx2 := GetProcAddress(handle, 'SetDeliveryPropertiesEx2');
    if @SetDeliveryPropertiesEx2 = nil  then  exit ;

    SetDeliveryPropertiesEx3 := GetProcAddress(handle, 'SetDeliveryPropertiesEx3');
    if @SetDeliveryPropertiesEx3 = nil  then  exit ;

    SetDeliveryPropertiesEx4 := GetProcAddress(handle, 'SetDeliveryPropertiesEx4');
    if @SetDeliveryPropertiesEx4 = nil  then  exit ;

    @LockDelivery := GetProcAddress(handle, 'LockDelivery');
    if @LockDelivery = nil  then  exit ;

    @UnlockDelivery := GetProcAddress(handle, 'UnlockDelivery');
    if @UnlockDelivery = nil  then  exit ;

    @ClearDelivery := GetProcAddress(handle, 'ClearDelivery');
    if @ClearDelivery = nil  then  exit ;

    @LockAndClearDelivery := GetProcAddress(handle, 'LockAndClearDelivery');
    if @LockAndClearDelivery = nil  then  exit ;

    @SetNextDeliveryID := GetProcAddress(handle, 'SetNextDeliveryID');
    if @SetNextDeliveryID = nil  then  exit ;

    @AckDeliveryDBLog := GetProcAddress(handle, 'AckDeliveryDBLog');
    if @AckDeliveryDBLog = nil  then  exit ;

    @GetDeliveryIDByOrdinalNotLogged := GetProcAddress(handle, 'GetDeliveryIDByOrdinalNotLogged');
    if @GetDeliveryIDByOrdinalNotLogged = nil  then  exit ;

    @GetDeliveriesCountNotLogged := GetProcAddress(handle, 'GetDeliveriesCountNotLogged');
    if @GetDeliveriesCountNotLogged = nil  then  exit ;

    @AckDeliveryVolLog := GetProcAddress(handle, 'AckDeliveryVolLog');
    if @AckDeliveryVolLog = nil  then  exit ;

    @GetDeliveryIDByOrdinalNotVolLogged := GetProcAddress(handle, 'GetDeliveryIDByOrdinalNotVolLogged');
    if @GetDeliveryIDByOrdinalNotVolLogged = nil  then  exit ;

    @GetDeliveriesCountNotVolLogged := GetProcAddress(handle, 'GetDeliveriesCountNotVolLogged');
    if @GetDeliveriesCountNotVolLogged = nil  then  exit ;

    @GetAllDeliveriesCount := GetProcAddress(handle, 'GetAllDeliveriesCount');
    if @GetAllDeliveriesCount = nil  then  exit ;

    @GetAllDeliveryByOrdinal := GetProcAddress(handle, 'GetAllDeliveryByOrdinal');
    if @GetAllDeliveryByOrdinal = nil  then  exit ;

    @GetDeliverySummary := GetProcAddress(handle, 'GetDeliverySummary');
    if @GetDeliverySummary = nil  then  exit ;

    @GetDeliverySummaryEx := GetProcAddress(handle, 'GetDeliverySummaryEx');
    if @GetDeliverySummaryEx = nil  then  exit ;

    GetDeliverySummaryEx2 := GetProcAddress(handle, 'GetDeliverySummaryEx2');
    if @GetDeliverySummaryEx2 = nil  then  exit ;

    GetDeliverySummaryEx3 := GetProcAddress(handle, 'GetDeliverySummaryEx3');
    if @GetDeliverySummaryEx3 = nil  then  exit ;

    SetDeliveryExt := GetProcAddress(handle, 'SetDeliveryExt');
    if @SetDeliveryExt = nil  then  exit ;

    GetDeliveryExt := GetProcAddress(handle, 'GetDeliveryExt');
    if @GetDeliveryExt = nil  then  exit ;

    @GetPumpDeliveryProperties := GetProcAddress(handle, 'GetPumpDeliveryProperties');
    if @GetPumpDeliveryProperties = nil  then  exit ;

    @GetPumpDeliveryPropertiesEx := GetProcAddress(handle, 'GetPumpDeliveryPropertiesEx');
    if @GetPumpDeliveryPropertiesEx = nil  then  exit ;

    @GetPumpDeliveryPropertiesEx2 := GetProcAddress(handle, 'GetPumpDeliveryPropertiesEx2');
    if @GetPumpDeliveryPropertiesEx2 = nil  then  exit ;

    @GetPumpDeliveryPropertiesEx3 := GetProcAddress(handle, 'GetPumpDeliveryPropertiesEx3');
    if @GetPumpDeliveryPropertiesEx3 = nil  then  exit ;

    @GetPumpDeliveryPropertiesEx4 := GetProcAddress(handle, 'GetPumpDeliveryPropertiesEx4');
    if @GetPumpDeliveryPropertiesEx4 = nil  then  exit ;

    @ReserveTypeString := GetProcAddress(handle, 'ReserveTypeString');
    if @ReserveTypeString = nil  then  exit ;

    @GetDuration := GetProcAddress(handle, 'GetDuration');
    if @GetDuration = nil  then  exit ;

    @StackCurrentDelivery := GetProcAddress(handle, 'StackCurrentDelivery');
    if @StackCurrentDelivery = nil  then  exit ;

    @DeliveryStateString := GetProcAddress(handle, 'DeliveryStateString');
    if @DeliveryStateString = nil  then  exit ;

    @DeliveryTypeString := GetProcAddress(handle, 'DeliveryTypeString');
    if @DeliveryTypeString = nil  then  exit ;

//-------------------------------------- Hoses -----------------------------------------//

    @GetHosesCount := GetProcAddress(handle, 'GetHosesCount');
    if @GetHosesCount = nil  then  exit ;

    @GetHoseByOrdinal := GetProcAddress(handle, 'GetHoseByOrdinal');
    if @GetHoseByOrdinal = nil  then  exit ;

    @GetHoseProperties := GetProcAddress(handle, 'GetHoseProperties');
    if @GetHoseProperties = nil  then  exit ;

    @GetHosePropertiesEx := GetProcAddress(handle, 'GetHosePropertiesEx');
    if @GetHosePropertiesEx = nil  then  exit ;

    GetHosePropertiesEx2 := GetProcAddress(handle, 'GetHosePropertiesEx2');
    if @GetHosePropertiesEx2 = nil  then  exit ;

    @SetHoseProperties := GetProcAddress(handle, 'SetHoseProperties');
    if @SetHoseProperties = nil  then  exit ;

    @SetHosePropertiesEx := GetProcAddress(handle, 'SetHosePropertiesEx');
    if @SetHosePropertiesEx = nil  then  exit ;

    SetHosePropertiesEx2 := GetProcAddress(handle, 'SetHosePropertiesEx2');
    if @SetHosePropertiesEx2 = nil  then  exit ;

    @DeleteHose := GetProcAddress(handle, 'DeleteHose');
    if @DeleteHose = nil  then  exit ;

    @GetHosePrices := GetProcAddress(handle, 'GetHosePrices');
    if @GetHosePrices = nil  then  exit ;

    @GetHoseSummary := GetProcAddress(handle, 'GetHoseSummary');
    if @GetHoseSummary = nil  then  exit ;

    GetHoseSummaryEx := GetProcAddress(handle, 'GetHoseSummaryEx');
    if @GetHoseSummaryEx = nil  then  exit ;

    @SetHoseETotals := GetProcAddress(handle, 'SetHoseETotals');
    if @SetHoseETotals = nil  then  exit ;

    @SetHosePrices := GetProcAddress(handle, 'SetHosePrices');
    if @SetHosePrices = nil  then  exit ;

//-------------------------------------- Grades ---------------------------------------//

    @GetGradesCount := GetProcAddress(handle, 'GetGradesCount');
    if @GetGradesCount = nil  then  exit ;

    @GetGradeByNumber := GetProcAddress(handle, 'GetGradeByNumber');
    if @GetGradeByNumber = nil  then  exit ;

    @GetGradeByName := GetProcAddress(handle, 'GetGradeByName');
    if @GetGradeByName = nil  then  exit ;

    @GetGradeByOrdinal := GetProcAddress(handle, 'GetGradeByOrdinal');
    if @GetGradeByOrdinal = nil  then  exit ;

    @GetGradeProperties := GetProcAddress(handle, 'GetGradeProperties');
    if @GetGradeProperties = nil  then  exit ;

    @GetGradePropertiesEx := GetProcAddress(handle, 'GetGradePropertiesEx');
    if @GetGradePropertiesEx = nil  then  exit ;

    @SetGradeProperties := GetProcAddress(handle, 'SetGradeProperties');
    if @SetGradeProperties = nil  then  exit ;

    @SetGradePropertiesEx := GetProcAddress(handle, 'SetGradePropertiesEx');
    if @SetGradePropertiesEx = nil  then  exit ;

    @DeleteGrade := GetProcAddress(handle, 'DeleteGrade');
    if @DeleteGrade = nil  then  exit ;

    @SetGradePrice := GetProcAddress(handle, 'SetGradePrice');
    if @SetGradePrice = nil  then  exit ;

    @GetGradePrice := GetProcAddress(handle, 'GetGradePrice');
    if @GetGradePrice = nil  then  exit ;

//-------------------------------------- Tanks ----------------------------------------//

    @GetTanksCount := GetProcAddress(handle, 'GetTanksCount');
    if @GetTanksCount = nil  then  exit ;

    @GetTankByNumber := GetProcAddress(handle, 'GetTankByNumber');
    if @GetTankByNumber = nil  then  exit ;

    @GetTankByName := GetProcAddress(handle, 'GetTankByName');
    if @GetTankByName = nil  then  exit ;

    @GetTankByOrdinal := GetProcAddress(handle, 'GetTankByOrdinal');
    if @GetTankByOrdinal = nil  then  exit ;

    @GetTankProperties := GetProcAddress(handle, 'GetTankProperties');
    if @GetTankProperties = nil  then  exit ;

    @GetTankPropertiesEx := GetProcAddress(handle, 'GetTankPropertiesEx');
    if @GetTankPropertiesEx = nil  then  exit ;

    @SetTankProperties := GetProcAddress(handle, 'SetTankProperties');
    if @SetTankProperties = nil  then  exit ;

    @SetTankPropertiesEx := GetProcAddress(handle, 'SetTankPropertiesEx');
    if @SetTankPropertiesEx = nil  then  exit ;

    @DeleteTank := GetProcAddress(handle, 'DeleteTank');
    if @DeleteTank = nil  then  exit ;

    @GetTankSummary := GetProcAddress(handle, 'GetTankSummary');
    if @GetTankSummary = nil  then  exit ;

    @GetTankSummaryEx := GetProcAddress(handle, 'GetTankSummaryEx');
    if @GetTankSummaryEx = nil  then  exit ;

//-------------------------------------- Ports ----------------------------------------//

    @GetPortsCount := GetProcAddress(handle, 'GetPortsCount');
    if @GetPortsCount = nil  then  exit ;

    @GetPortByNumber := GetProcAddress(handle, 'GetPortByNumber');
    if @DeleteTank = nil  then  exit ;

    @GetPortByName := GetProcAddress(handle, 'GetPortByName');
    if @GetPortByName = nil  then  exit ;

    @GetPortByOrdinal := GetProcAddress(handle, 'GetPortByOrdinal');
    if @GetPortByOrdinal = nil  then  exit ;

    @GetPortProperties := GetProcAddress(handle, 'GetPortProperties');
    if @GetPortProperties = nil  then  exit ;

    @SetPortProperties := GetProcAddress(handle, 'SetPortProperties');
    if @SetPortProperties = nil  then  exit ;

    @RemovePort := GetProcAddress(handle, 'RemovePort');
    if @RemovePort = nil  then  exit ;

    @GetZB2GConfig := GetProcAddress(handle, 'GetZB2GConfig');
    if @GetZB2GConfig = nil  then  exit ;

    @GetSerialNo := GetProcAddress(handle, 'GetSerialNo');
    if @GetSerialNo = nil  then  exit ;

    @GetDeviceDetails := GetProcAddress(handle, 'GetDeviceDetails');
    if @GetDeviceDetails = nil  then  exit ;

    @ResetDevice := GetProcAddress(handle, 'ResetDevice');
    if @ResetDevice = nil  then  exit ;

    @RequestVersion := GetProcAddress(handle, 'RequestVersion');
    if @RequestVersion = nil  then  exit ;

//-------------------------------------- Attendants -----------------------------------//

    @GetAttendantsCount := GetProcAddress(handle, 'GetAttendantsCount');
    if @GetAttendantsCount = nil  then  exit ;

    @GetAttendantByNumber := GetProcAddress(handle, 'GetAttendantByNumber');
    if @GetAttendantByNumber = nil  then  exit ;

    @GetAttendantByName := GetProcAddress(handle, 'GetAttendantByName');
    if @DeleteTank = nil  then  exit ;

    @GetAttendantByOrdinal := GetProcAddress(handle, 'GetAttendantByOrdinal');
    if @GetAttendantByOrdinal = nil  then  exit ;

    @GetAttendantProperties := GetProcAddress(handle, 'GetAttendantProperties');
    if @GetAttendantProperties = nil  then  exit ;

    GetAttendantPropertiesEx := GetProcAddress(handle, 'GetAttendantPropertiesEx');
    if @GetAttendantPropertiesEx = nil  then  exit ;

    @SetAttendantProperties := GetProcAddress(handle, 'SetAttendantProperties');
    if @SetAttendantProperties = nil  then  exit ;

    SetAttendantPropertiesEx := GetProcAddress(handle, 'SetAttendantPropertiesEx');
    if @SetAttendantPropertiesEx = nil  then  exit ;

    GetAttendantState := GetProcAddress(handle, 'GetAttendantState');
    if @GetAttendantState = nil  then  exit ;

    @DeleteAttendant := GetProcAddress(handle, 'DeleteAttendant');
    if @DeleteAttendant = nil  then  exit ;

    @AttendantLogon := GetProcAddress(handle, 'AttendantLogon');
    if @AttendantLogon = nil  then  exit ;

    @AttendantLogoff := GetProcAddress(handle, 'AttendantLogoff');
    if @AttendantLogoff = nil  then  exit ;

//------------------------------ Card Clients -----------------------------------------//

    GetCardClientsCount := GetProcAddress(handle, 'GetCardClientsCount');
    if @GetCardClientsCount = nil  then  exit ;

    GetCardClientByNumber := GetProcAddress(handle, 'GetCardClientByNumber');
    if @GetCardClientByNumber = nil  then  exit ;

    GetCardClientByName := GetProcAddress(handle, 'GetCardClientByName');
    if @GetCardClientByName = nil  then  exit ;

    GetCardClientByOrdinal := GetProcAddress(handle, 'GetCardClientByOrdinal');
    if @GetCardClientByOrdinal = nil  then  exit ;

    GetCardClientProperties := GetProcAddress(handle, 'GetCardClientProperties');
    if @GetCardClientProperties = nil  then  exit ;

    GetCardClientPropertiesEx := GetProcAddress(handle, 'GetCardClientPropertiesEx');
    if @GetCardClientPropertiesEx = nil  then  exit ;

    GetCardClientPropertiesEx2 := GetProcAddress(handle, 'GetCardClientPropertiesEx2');
    if @GetCardClientPropertiesEx2 = nil  then  exit ;

    SetCardClientProperties := GetProcAddress(handle, 'SetCardClientProperties');
    if @SetCardClientProperties = nil  then  exit ;

    SetCardClientPropertiesEx := GetProcAddress(handle, 'SetCardClientPropertiesEx');
    if @SetCardClientPropertiesEx = nil  then  exit ;

    SetCardClientPropertiesEx2 := GetProcAddress(handle, 'SetCardClientPropertiesEx2');
    if @SetCardClientPropertiesEx2 = nil  then  exit ;

    DeleteCardClient := GetProcAddress(handle, 'DeleteCardClient');
    if @DeleteCardClient = nil  then  exit ;

//------------------------------ Card Reads -----------------------------------------//

    GetCardReadsCount := GetProcAddress(handle, 'GetCardReadsCount');
    if @GetCardReadsCount = nil  then  exit ;

    GetCardReadByNumber := GetProcAddress(handle, 'GetCardReadByNumber');
    if @GetCardReadByNumber = nil  then  exit ;

    GetCardReadByName := GetProcAddress(handle, 'GetCardReadByName');
    if @GetCardReadByName = nil  then  exit ;

    GetCardReadByOrdinal := GetProcAddress(handle, 'GetCardReadByOrdinal');
    if @GetCardReadByOrdinal = nil  then  exit ;

    GetCardReadProperties := GetProcAddress(handle, 'GetCardReadProperties');
    if @GetCardReadProperties = nil  then  exit ;

    SetCardReadProperties := GetProcAddress(handle, 'SetCardReadProperties');
    if @SetCardReadProperties = nil  then  exit ;

    DeleteCardRead := GetProcAddress(handle, 'DeleteCardRead');
    if @DeleteCardRead = nil  then  exit ;

    GetCardType := GetProcAddress(handle, 'GetCardType');
    if @GetCardType = nil  then  exit ;

//------------------------------ ZigBee devices ---------------------------------------//

    @GetZigBeeCount := GetProcAddress(handle, 'GetZigBeeCount');
    if @GetZigBeeCount = nil  then  exit ;

    @GetZigBeeByNumber := GetProcAddress(handle, 'GetZigBeeByNumber');
    if @GetZigBeeByNumber = nil  then  exit ;

    @GetZigBeeByName := GetProcAddress(handle, 'GetZigBeeByName');
    if @GetZigBeeByName = nil  then  exit ;

    @GetZigBeeByOrdinal := GetProcAddress(handle, 'GetZigBeeByOrdinal');
    if @GetZigBeeByOrdinal = nil  then  exit ;

    @GetZigBeeProperties := GetProcAddress(handle, 'GetZigBeeProperties');
    if @GetZigBeeProperties = nil  then  exit ;

    @SetZigBeeProperties := GetProcAddress(handle, 'SetZigBeeProperties');
    if @SetZigBeeProperties = nil  then  exit ;

    @DeleteZigBee := GetProcAddress(handle, 'DeleteZigBee');
    if @DeleteZigBee = nil  then  exit ;

//------------------------------ Sensors ----------------------------------------------//

    @GetSensorsCount := GetProcAddress(handle, 'GetSensorsCount');
    if @GetSensorsCount = nil  then  exit ;

    @GetSensorByNumber := GetProcAddress(handle, 'GetSensorByNumber');
    if @GetSensorByNumber = nil  then  exit ;

    @GetSensorByName := GetProcAddress(handle, 'GetSensorByName');
    if @GetSensorByName = nil  then  exit ;

    @GetSensorByOrdinal := GetProcAddress(handle, 'GetSensorByOrdinal');
    if @GetSensorByOrdinal = nil  then  exit ;

    @GetSensorProperties := GetProcAddress(handle, 'GetSensorProperties');
    if @GetSensorProperties = nil  then  exit ;

    @SetSensorProperties := GetProcAddress(handle, 'SetSensorProperties');
    if @SetSensorProperties = nil  then  exit ;

    @SetSensorStatus := GetProcAddress(handle, 'SetSensorStatus');
    if @SetSensorStatus = nil  then  exit ;

    @GetSensorStatus := GetProcAddress(handle, 'GetSensorStatus');
    if @GetSensorStatus = nil  then  exit ;

    @DeleteSensor := GetProcAddress(handle, 'DeleteSensor');
    if @DeleteSensor = nil  then  exit ;

//------------------------------ Logged events -----------------------------------------//

    @GetLogEventCount := GetProcAddress(handle, 'GetLogEventCount');
    if @GetLogEventCount = nil  then  exit ;

    @GetLogEventByOrdinal := GetProcAddress(handle, 'GetLogEventByOrdinal');
    if @GetLogEventByOrdinal = nil  then  exit ;

    @GetLogEventProperties := GetProcAddress(handle, 'GetLogEventProperties');
    if @GetLogEventProperties = nil  then  exit ;

    @SetLogEventProperties := GetProcAddress(handle, 'SetLogEventProperties');
    if @SetLogEventProperties = nil  then  exit ;

    @DeleteLogEvent := GetProcAddress(handle, 'DeleteLogEvent');
    if @DeleteLogEvent = nil  then  exit ;

    @ClearLogEvent := GetProcAddress(handle, 'ClearLogEvent');
    if @ClearLogEvent = nil  then  exit ;

    @AckLogEvent := GetProcAddress(handle, 'AckLogEvent');
    if @AckLogEvent = nil  then  exit ;

//--------------------------------------------------------------------------------------//

    LoadDll := true  ;

  end;


end.
