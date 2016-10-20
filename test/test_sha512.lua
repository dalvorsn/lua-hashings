local hmod = require("hashings").sha512
local runner = require("runner")

local hash_test_output = {
    v1 =  { "CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E" },
    v2 =  { "DDAF35A193617ABACC417349AE20413112E6FA4E89A97EA20A9EEEE64B55D39A2192992A274FC1A836BA3C23A3FEEBBD454D4423643CE80E2A9AC94FA54CA49F" },
    v3 =  { "44D8B0F5909F5AF22DD52CA317C7B177B8670D01F0F0A2B589571BA95F9FC8FB7ACA28F7467664252D52B2E126B711F88E396524EE1FDC72B7463A7484A21C6F" },
    v4 =  { "07E547D9586F6A73F73FBAC0435ED76951218FB7D0C8D788A309D785436BBB642E93A252A954F23912547D1E8A3B5ED6E1BFD7097821233FA0538F3DB854FEE6" },
    v5 =  { "9814D48AE1BFD731B32F0A829F20507EC9BD6B77609053718F7E2053B53C7A264BBAB6A96D3D54A7F9A736570D11B1F99AFB1735149F43CFEE9B6F87886D3FF6" },
    v6 =  { "EEF039626EA05D418B6025E75501FEF85025D2AAB8DF0FF44E47E72041835B6844407E60CD20E67958EC5495127E94317A8D47965EE3F3E2414A23B801690C25" },
    v7 =  { "CE733117F9963859337176B7DDF93F889190B36AE0D76B61B8760EB350C48FD48A79437C812701A53DBCE608B613E52835618AA5895BDE9B75C0D72F7B368BFA" },
    v8 =  { "9D247923385736CB7A6B9C4DD872A301963795B5EB8244F28EA10B4A84E607429FBB00BA3BA2EADBDBF854048C7EB9A014A18952B72347B1D3A363CFD2C349B5" },
    v9 =  { "3210512D6E6BD85CC22A6E15EF4687FDA60F96EB4851129E64664EF7EE61E44CBDF4847D8D5B4B262F86087A0386D68C5B720F793883736AE81368EC277FD2D6" },
    v10 = { "8C18585BBB7BA8E13B35010243D2E9F143AE19B630F2646CECB65C4FF2FE7F95F09D96497532BE99ABB425573DA946B326F6AF9D51448F3EEFDA1B23285B98F5" },
    v11 = { "8760A6780B9011ABC3D040224DB3B93F6251045813D97A1B639E91CC34022C5A4DDA4F357B34A98FCBBCAAF15C369DAD159DEC8492FF81B3F49B668A838B6D72" },
    v12 = { "3E42219A5116CA224EF73944526538367A037F3A6E8271E8BDD5546AC2612BCB6DD4CED52F33A197B6F8B08444D109A6D41DFDBAFC7CF380A4C0B12CB03E8228" },
    v13 = { "34A15944D86A67FD7B4083502FB5F08B6AE35EDD4B4A56D6AE46B45C950A515F79824A933958988DACB42ED71DC30E0D1398D0D9FCF1799D35A3C39AECCBD19F" },
    v14 = { "736E3496A3989859EDDC30CBF5CBBD047328F844C7E6CE804DE724C66D0348B78D163F2E420E4282279151DF5551B19C264940B48F51E5E4F2CD4323318F02C7" },
    v15 = { "2EBA73AFA4F649C4875859DEC5F6D7DFD17F4C50B01307AEE2C38438BB77A3C1664826613E4E94B55F1AB1AAF676ECE310717E767129CE7DD4940C2D974349BA" },
    v16 = { "40DA5FAF1EE61A477688BC0BA6B9F5D58B73D4A891D33B5F4B6FE58A8AC4EB8FCB25915286729E55EE85EB17CD6B74659432A0F8E304FCFCC1B01C646AE23480" },
    v17 = { "8902DAA5ABEB0084BE3DCAFA651371888C86521A9006B004502A2DA7507E7CEEF78A0E3C643E19833117473E5F8B6EDC22E3CDB7F52833C6263CA4210D47E540" },
    v18 = { "5B79CAD852C8608B2544A047BB2DEFDD6180FCBA2B82EA59E3BE889A70733DD6F28C09223A08138155C03BAB2A24224E726948F31321372C65B525EBDCCDE4C0" },
    v19 = { "8354B850ACF996044987399396BF209AFD308EF8ED4DB3881E11EA93F94DEBBDA9F703A07165C05E634C47BA36900C3125B7A0942AF72B5886102F8D3562F09C" },
    v20 = { "80EB23CE9BEB7FBD9479603818B48F8A7430FB2BF6975A34E1DC26B06A5A512393F8A7CE2C0977B9DB67DF29EDC34360C1118CE4D80FFCBA06CD4A7CEEDE7E34" },
    v21 = { "23782B4254A3CD1B54E871F9D5B950D9A21E9AE4CE6974D968CC9FC1D2B46D270542982659B59BC1A7C8A1B8A75331F9C02F715AFA181D998AB8454A52A9CE28" },
    v22 = { "0DAA8FB6012BC44718FA305DEBD2A751C305B3DBB7EB6D1F1E01228F0988987053E70FD77C5012D04B0B4DBDA41F138A02FBB4C36D838C3D9DC67A42E849B169", "D5BB064665BAAF0C9486D0474DFC8F61CD73561440ABCC7E215DC002817EA184CEED713974179B09E0600030D53940E3D45148D3D4B9CBAFDECED9EFA518C444" },
    v23 = { "14F49D6EA74F4C59254D8FA5CBB22F88C7D3E2B93CFAA60F94AE281D5F2E5ADF941BD43D4779C0161C9765DCE9A4FC97D3692DD9418AA2BEC90182951D32C3A0", "E599F8CF14C869C2414D0FFDC341FD1AA5E65CA9B1E981B600057741A094B350AD96C198FEEE2FCCDFEC8256854401A30931FEAFB3178732117F02EB579E97A2", "43B07DEFCD0B661A45073C53C07E891303AB3ADD105A4A07E5D591730897279A853F4441684E6BB4118E34ADB303055D207F1B6E5FEB884DA6A98788F4BEFDE4" }
}

local hmac_test_output = {
    v1 = { "D98942D69A75C61A08D2BC62B63AEDA9C8FE6E34493BA10515102340A32474B0618013C12E79B69A65908E27B45592C39BB4A03B5A84E35B010EFC9030ED8DF8" },
    v2 = { "60DB8FE1EB688257941ED4332E571D7CAD3DEA156E70ABBFA37897DDD7E782B25236E863E1B1B9AD06BC681FD6F3238F2A13F0972E9EC91E736F0DE2B9F8D508" },
    v3 = { "16FCEB85A8F4CC6A988254A267FAE93939F82863290AD4BC291DF322E50654D7894853E601766265D4C27ABAA8F754664DC14F411DE4400A3F7BD5A682E672DC", "3F22B0F30C69234B27AB8D5BB0D8F40C1F38D874901B3901973C1018416104337586AA149552630A782D310D71103E44AFCBA06E1CAF135D355479EB9CFA3DB2" },
    v4 = { "7368E2485D0D8A6D836ABEDFC29F1C5B5E690C412BC9D00BBFEFBB34818A26C6D9D10965D2F9031F5C35910DB9F73A03E911967B2BD5D9319E103DFB00E62CB7", "995C53FB039E7113D8C33A8258575D3D87D95040F2446538BC4B3C069D892D382AACF1291A5893961EF566A8A9B584B578DC70CED03330CFE43C97348273E8F5", "FFBED8C850B359951527AFCAD3916EC745D25C52885CE822FC7B92AD387737B537960AB824DEF5A7254CBCF7A504424586B9379EE8E0FF906877223682C52579" }
}

runner.hash_runner("sha512", hmod, hash_test_output)
runner.hmac_runner("sha512", hmod, hmac_test_output)
