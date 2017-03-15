object RestODataAppView: TRestODataAppView
  Left = 0
  Top = 0
  Caption = 'RestODataAppView'
  ClientHeight = 377
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 24
    Top = 24
    Width = 625
    Height = 345
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'grupo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Visible = True
      end>
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = ClientDataSet1
    FieldDefs = <>
    ResponseJSON = RESTResponse1
    Left = 328
    Top = 32
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json; odata.metadata=minimal'
    RootElement = 'value'
    Left = 328
    Top = 120
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'OData/OData.svc/grupos'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 208
    Top = 128
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://localhost:8886'
    Params = <>
    HandleRedirects = True
    Left = 120
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 352
    Top = 216
  end
  object ClientDataSet1: TClientDataSet
    PersistDataPacket.Data = {
      0E1B00009619E0BD010000001800000002006400000003000000100505677275
      706F02004A000000010005574944544802000200FE01046E6F6D6502004A0000
      00010005574944544802000200FE0101000A4348414E47455F4C4F4704008200
      2C01000001000000000000000400000002000000000000000400000003000000
      0000000004000000040000000000000004000000050000000000000004000000
      0600000000000000040000000700000000000000040000000800000000000000
      040000000900000000000000040000000A00000000000000040000000B000000
      00000000040000000C00000000000000040000000D0000000000000004000000
      0E00000000000000040000000F00000000000000040000001000000000000000
      0400000011000000000000000400000012000000000000000400000013000000
      0000000004000000140000000000000004000000150000000000000004000000
      1600000000000000040000001700000000000000040000001800000000000000
      040000001900000000000000040000001A00000000000000040000001B000000
      00000000040000001C00000000000000040000001D0000000000000004000000
      1E00000000000000040000001F00000000000000040000002000000000000000
      0400000021000000000000000400000022000000000000000400000023000000
      0000000004000000240000000000000004000000250000000000000004000000
      2600000000000000040000002700000000000000040000002800000000000000
      040000002900000000000000040000002A00000000000000040000002B000000
      00000000040000002C00000000000000040000002D0000000000000004000000
      2E00000000000000040000002F00000000000000040000003000000000000000
      0400000031000000000000000400000032000000000000000400000033000000
      0000000004000000340000000000000004000000350000000000000004000000
      3600000000000000040000003700000000000000040000003800000000000000
      040000003900000000000000040000003A00000000000000040000003B000000
      00000000040000003C00000000000000040000003D0000000000000004000000
      3E00000000000000040000003F00000000000000040000004000000000000000
      0400000041000000000000000400000042000000000000000400000043000000
      0000000004000000440000000000000004000000450000000000000004000000
      4600000000000000040000004700000000000000040000004800000000000000
      040000004900000000000000040000004A00000000000000040000004B000000
      00000000040000004C00000000000000040000004D0000000000000004000000
      4E00000000000000040000004F00000000000000040000005000000000000000
      0400000051000000000000000400000052000000000000000400000053000000
      0000000004000000540000000000000004000000550000000000000004000000
      5600000000000000040000005700000000000000040000005800000000000000
      040000005900000000000000040000005A00000000000000040000005B000000
      00000000040000005C00000000000000040000005D0000000000000004000000
      5E00000000000000040000005F00000000000000040000006000000000000000
      0400000061000000000000000400000062000000000000000400000063000000
      000000000400000064000000000000000400000004000400300037002A004200
      6900730063006F00690074006100720069006100200065006D00620061006C00
      6100640061003200040006003000370031001C004C0045004900540045002000
      50004F00200054004F0044004F00530004000400300031000E0044004F004300
      4500530058005800040006003000320031001400430041004600450020005400
      4F0044004F00530004000400300033002000530061006C006700610064006F00
      730020004700720061006E006400650073000400040030003400220053006100
      6C006700610064006F0073002000500065007100750065006E006F0073000400
      040030003800280042006900730063006F006900740061007200690061002000
      610020004700720061006E0065006C0004000400300039001C005000E3006500
      7300200045006D00620061006C00610064006F00730004000400310030001A00
      5000E300650073002000610020004700720061006E0065006C00040004003100
      310022004C006500690074006500200065002000730069006D0069006C006100
      72006500730004000400310032001C004600720069006F007300200046006100
      74006900610064006F007300040004003100330026004C006100740069006300
      ED006E0069006F007300200065006D00200067006500720061006C0004000600
      3100330032001E005200450051005500450049004A0041004F00200054004F00
      44004F005300040004003100340024004D00610069006F006E00650073006500
      730020006E006F0020004E006100740061006C00040004003100350020004100
      73007300610064006F00730020006E006F0020004E006100740061006C000400
      04003100360026005000720065007000610072006100E700E3006F0020006E00
      6F0020004E006100740061006C000400040031003700140052006F0074006900
      730073006500720069006500040006003100370037000A004C00490056005200
      450004000600300032003300240045004D00200043004F004E00530045005200
      5600410020004F005500540052004F005300040006003100370042002E005200
      6F007400690073007300650072006900650020004E006100740061006C002000
      620061006C006300E3006F00040004003100380020004C0061006E0063006800
      6500730020006400650020004D006500740072006F0004000600310038003100
      220041004D0041004300490041004E0054004500530020004F00550054005200
      4F0053000400040032003000100053006F007200760065007400650073000400
      040032003100260050006500740069007400200066006F007500720020006500
      6D00200067006500720061006C000400040032003200220044006F0063006900
      6E0068006F007300200065006D00200067006500720061006C00040004003200
      3300280042006F006D0062006F006E007300200065002000630068006F006300
      6F006C006100740065007300040006003200330050001C004F0076006F007300
      20006400650020005000E100730063006F00610004000400320035001C004200
      6500620069006400610073002000620061006C006300E3006F00040006003200
      350031000A004C0049005600520045000400040032003600160043006F007000
      6100200065002000630061006600E90004000400320037001000430069006700
      6100720072006F0073000400040032003800220043006800690063006C006500
      740065007300200065002000420061006C006100730004000400320039001E00
      43006F006D00650072006300690061006C0069007A00610064006F0073000400
      040033003000140045006D00620061006C006100670065006E00730004000400
      33003200220043006F006E00670065006C00610064006F007300200062006100
      6C006300E3006F000400040037003500280049006E00730075006D006F007300
      2000700061007200610020006C0061006E006300680065007300040004003500
      30002400520065007600690073007400610073002000650020006A006F007200
      6E00610069007300040004003500320016004600650069007200610020004C00
      69006D0070006100040006005A00390039002C00500072006F00640075007400
      6F007300200066006F007200610020006400650020006C0069006E0068006100
      04000400370037003A0043006F006D0065006E007400E100720069006F007300
      2000700072006F0064007500E700E3006F00200069006D006500640069006100
      74006100040006003100300032003A0048004F00520054004600520055005400
      2000420044004A0020004C004500470055004D00450053002000560045005200
      4400550052004100530004000600310030003300340048004F00520054004600
      520055005400200043005800200046005200550054004100530020004C004500
      470055004D004500530004000600310030003400240048004F00520054004600
      520055005400200046005200550054004100530020004B004700040006003100
      30003100260048004F005200540046005200550054002000420044004A002000
      46005200550054004100530004000600550050003100120055004E0049004600
      4F0052004D004500530004000400350031003600520065007600690073007400
      61007300200066006F0072006100200064006500200063006900720063007500
      6C006100E700E3006F00040006003100380032001C0041004E00540049004D00
      4F0046004F00200054004F0044004F0053000400060032003000310020005200
      45004D004F005600450044004F00520020004F005500540052004F0053000400
      06003100370038002A0041004700550041002000530041004E00490054004100
      52004900410020004F0055005400520041005300040006005A00390038002C00
      500052004F004400550054004F005300200053004F004200200045004E004300
      4F004D0045004E0044004100040006005000520031004000500052004F004300
      4500530053004F0053002000440041002000500052004F0044005500C700C300
      4F0020002D002000520045004300450049005400410053000400060031003000
      3600260048004F0052005400460052005500540020004C004500470055004D00
      4500530020004B00470004000600310030003500300048004F00520054004600
      5200550054002000460052005500540041005300200053004500430041005300
      20004B004700040008003100370037005900220052004500460045004900C700
      C3004F002000590041004B00490053004F004200410004000C00300031003100
      3600300035003C005000410044002000420041004E0043004F00530020004500
      200043004100200041004C004D004F0046004100440041005300200045002000
      4300410004000C003000310031003600310030002C0050004100440020004200
      41004E0043004F005300200045002000430041002000420041004E0043004F00
      530004000C003000310031003600320030003A00500041004400200042004100
      4E0043004F005300200045002000430041002000430041004400450049005200
      41005300200048004F004D00450004000C003000310031003600310038003C00
      5000410044002000420041004E0043004F005300200045002000430041002000
      43004100440045004900520041005300200044004F0042005200C10004000C00
      3000310031003800300035003C0050004100440020004D004500530041005300
      2C002000450053004300520020004D004500530041005300200044004F004200
      5200C10056004500490004000C003000310031003800320035003A0050004100
      440020004D0045005300410053002C0020004500530043005200200045005300
      430052004900560041004E0049004E0048004100530004000C00300031003200
      3000310035003600500041004400200045005300540041004E00540045005300
      200045005300540041004E00540045005300200043004F004D0050004F000400
      0C003000310032003100320030002E005000410044002000410052004D00C100
      520049004F0053002C002000430020004D00D300440055004C004F0053000400
      0C00300031003200320032003000320050004100440020004700410052004400
      45004E00200046004900420052004100530020004E0041005400550052004100
      490004000C003000310032003200320035003200500041004400200047004100
      5200440045004E0020004C0049004E0048004100530020004400450020004D00
      41004400450004000C0030003100320032003000350030005000410044002000
      470041005200440045004E0020004700550041005200440041002D005300D300
      490053002000450004000C003000310032003200300031003200500041004400
      2000470041005200440045004E00200041004C004D004F004600410044004100
      530020003400350043004D0004000C0030003100320032003300300032005000
      410044002000470041005200440045004E0020004C0049004E00480041005300
      200044004500200041004C0055004D0004000C00300031003200330030003000
      22005000410044002000430041004D00410053002C002000420045005200C700
      20002E0004000C003000310032003300310035003C0050004100440020004300
      41004D00410053002C002000420045005200C7002000420045004C0049004300
      48004500530020004500200053005100490004000C0030003100320033003000
      31003C005000410044002000430041004D00410053002C002000420045005200
      C7002000430041004D0041005300200044004500200043004100530041004C00
      04000C00300031003200350030003000220050004100440020004D00D3005600
      450049005300200043004F004D00500020002E0004000C003000310032003500
      300034003C0050004100440020004D00D3005600450049005300200043004F00
      4D00500020004D0045005300410053002000440045002000430045004E005400
      520004000C003000310032003500300035003C0050004100440020004D00D300
      5600450049005300200043004F004D00500020005200410043004B0053002C00
      20005000410049004E00C9004900530004000C00300031003200350030003800
      2E0050004100440020004D00D3005600450049005300200043004F004D005000
      2000420049004F004D0042004F00530004000C00300031003200350030003900
      320050004100440020004D00D3005600450049005300200043004F004D005000
      2000430041005200520049004E0048004F00530004000C003000310032003500
      31003000320050004100440020004D00D3005600450049005300200043004F00
      4D0050002000500055005800410044004F0052004500530004000C0030003100
      3200370030003000220050004100440020004300410046004500200044004500
      5300490047004E0020002E0004000C003000310032003700340030003C005000
      41004400200043004100460045002000440045005300490047004E0020004100
      4300450053005300D300520049004F005300200045004C00C90004000C003000
      310032003700340035003C005000410044002000430041004600450020004400
      45005300490047004E0020004C0055004D0049004E00C1005200490041005300
      200045002000560004000C003000310032003700300033003A00500041004400
      200043004100460045002000440045005300490047004E0020004C0055004D00
      49004E00C100520049004100530020004400450004000C003000310032003700
      310033003A005000410044002000430041004600450020004400450053004900
      47004E0020004C0055004D0049004E00C1005200490041005300200044004500
      04000C0030003100320037003400320030005000410044002000430041004600
      45002000440045005300490047004E0020004C00C2004D005000410044004100
      530004000C003000310032003800300038003C00500041004400200043004F00
      5200540049004E004100530020004500200020005300550050004F0052005400
      4500530020004500200056004100520004000C00300031003200380030003900
      3C00500041004400200043004F005200540049004E0041005300200045002000
      2000540041005000450054004500530020004700520041004E00440045000400
      0C003000310032003800300037003C00500041004400200043004F0052005400
      49004E0041005300200045002000200043004F005200540049004E0041005300
      200045004D0020005400450004000C0030003100320039003000300022005000
      410044002000500052004100540045004C004500490052004100530020002E00
      04000C003000310032003900310030003C005000410044002000500052004100
      540045004C00450049005200410053002000500052004100540045004C004500
      4900520041005300200043004F0004000C003000310032003900310035003C00
      5000410044002000500052004100540045004C00450049005200410053002000
      4D0049004E0049004D00D30056004500490053002C0020004E00490004000C00
      3000310032003900320030003A00500041004400200050005200410054004500
      4C00450049005200410053002000460045005200520041004D0045004E005400
      410053002000450004000C003000310032003900310032003A00500041004400
      2000500052004100540045004C00450049005200410053002000500052004100
      540045004C00450049005200410053002000450004000C003000310032003900
      3000360022005000410044002000500052004100540045004C00450049005200
      4100530020002E0004000C003000310032003900300037003C00500041004400
      2000500052004100540045004C004500490052004100530020004D0045005300
      410053002000450020005300550050004F005200540004000C00300031003200
      3900320032003A005000410044002000500052004100540045004C0045004900
      520041005300200041004300450053005300D300520049004F00530020004400
      450004000C003000310032003900320034003C00500041004400200050005200
      4100540045004C00450049005200410053002000530045004700550052004100
      4E00C70041002000500041005200410004000C00300031003300300030003200
      3C0050004100440020004D0041005400C9005200490041002D00500052004900
      2000450054004900510055004500540041005300200050004500520053000400
      0C00300031003300300032003000280050004100440020004D0041005400C900
      5200490041002D0050005200490020004500580050004F0004000C0030003100
      390039003000300020005000410044002000500052004F005400D30054004900
      50004F00530020002E0004000C00300031003100390030003000220050004100
      4400200045005300540041004E005400450053002C002000410020002E000400
      0C00300031003100390033003000340050004100440020004500530054004100
      4E005400450053002C002000410020004C004100560041004E00440045005200
      4900410004000C003000310032003300300037003C0050004100440020004300
      41004D00410053002C002000420045005200C7002000430041004D0041005300
      20004A00DA004E0049004F00520020004500}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'grupo'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'nome'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 464
    Top = 88
  end
end
