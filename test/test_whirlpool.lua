local hmod = require("hashings").whirlpool
local runner = require("runner")

local hash_test_output = {
    v1 =  { "19FA61D75522A4669B44E39C1D2E1726C530232130D407F89AFEE0964997F7A73E83BE698B288FEBCF88E3E03C4F0757EA8964E59B63D93708B138CC42A66EB3" },
    v2 =  { "4E2448A4C6F486BB16B6562C73B4020BF3043E3A731BCE721AE1B303D97E6D4C7181EEBDB6C57E277D0E34957114CBD6C797FC9D95D8B582D225292076D4EEF5" },
    v3 =  { "CC8569F5283CC57AD3C8225A31B39D439CB8CCEC3C2E8AE7E8FE7E8E699BC8BA3ADB41EA561936C38109EF1126706B59AB198297FF8D695627FFFFFC97E33B10" },
    v4 =  { "B97DE512E91E3828B40D2B0FDCE9CEB3C4A71F9BEA8D88E75C4FA854DF36725FD2B52EB6544EDCACD6F8BEDDFEA403CB55AE31F03AD62A5EF54E42EE82C3FB35" },
    v5 =  { "4E50A42D469B6E5334F80A6BB85437823347AFFDD40A3DE2E701E9DFD4AFB3A01A46CD233EC8497FDC8BAA95FE46C2F0F2079D6E976E9B4C56957732BF35F467" },
    v6 =  { "29573367963A1110E79F06863BA82587FBC12E073297C7FEFADA6DE558DA08DD1F95B7BEC9A388550DF9D0A0C94296EE935110F47CEEFE16A081EED29091169D" },
    v7 =  { "2B9B47385F9A9DD90738957225A87D064177590D134941E8F009C388B712DA455D9D4F3D6440B36333D879C3C6D29E6C7EF4098FBFFE841F7DB8E8EE436AB295" },
    v8 =  { "B51B9E0D4F2C13F0DE7AF69A902E57AB04EF859CA6BDDA3F6CF66B69596476130C613F3A1E1E22918424B33BE28190D02330B8A494AC397DED7675799B9B0C7E" },
    v9 =  { "7B8B62E3EFE411F357C5CC2FEF8C36F8C2418F9E97AA2D9C2C7FB15A9CCA61F5E83FC411494F5DF76C2F3D7090021F0BF518D01E1BF651187AAF9FC6CB7DAEB8" },
    v10 = { "C608B0C4BA2F5DFC86AAAC14E3D63D5846EFA3DC5BAA2B0ED8D6137E3EC0C21EBE6E3620E7BA443C1A031B52887B99D1737412ECE63691A35AC87E524C8F50A3" },
    v11 = { "25DFE5DD47ADEE5047297267A08C32540C69D26BF1839C4A8B1ACDBB019A59C1A16ECA6435F31B40475C5D3A02CA320938173ACE51B19D1FADE8A80E7C2C7031" },
    v12 = { "CB8FD5CBFD6841C611590523E21EA4BD67A61B16FE42D8645263B1F324E0AECB58D161613FB12706401B7AB5A5C9FEB38F3EEF8DEAF0E62C653F52620494F6D6" },
    v13 = { "92742BA02F4900F42D5D7F6D63C782BC4C21DF65079840A7DF05774952327D4C01E2E02D23901D3F6A58099245EBEFA571F44C405A949A5E299AA3567F775056" },
    v14 = { "970B4961242A5FE7A2E6502B58A8DEB7D59247CE8CEC3AB02B2D7A1B6397B1EEAD73969F5471FDB0E2A604D955E03C1693077E2D83D2890F74632E2A4B361081" },
    v15 = { "27BE77BE71BE6D6A1C5E9880474C248F9C89B9278E92DF340A65D9146571E1484F15AF6E0ED993F8283192C0F37597297CA7D90A882FC0EBE1931868032670D7" },
    v16 = { "FE3F9F8B18D18EFD5A7176B55DE62375FA7C214F19C01A63826A01216CEC5B947A581C1C9D8D7EDEA12778286DDDA280276299202B2641437965C5ACC008D367" },
    v17 = { "4E65B7A614B56EDCC4253AEC1D865C8F1391F03FB989875172E898E907C9AD3F5AA79DCCC322E6B9DEB358C572C47F0F25579385BA355426541E69310AED6025" },
    v18 = { "2981BE6EA0F44CF0B488EAE44A0A0A9470AE5296D817F04875559EA5B91D8B36E0610A696C8C3E88D37726D7B47C9B20A4A9D8BF35A2D85C2DCFAF82C9050E4B" },
    v19 = { "9CF4E5E5A0A76B1E093E378B0E7E7FF5EEFC7834D89D9DCFD9E3B7ECC99D34E379E5C010953232B85809855D4895A09F12CFBDB4CAB743C41208E6F0EDFB8F11" },
    v20 = { "1712AB54AC763C3522E888C2CD30D0D3BB8260238F495B989C7165EDC2818986F9C77A675C427713D7AC89E7CDD4D1718A6669DD8DF75C08DA16F91707A3B4D8" },
    v21 = { "7B045AA579D384CDCDA5ABBF5ED8C35CB0470CEF6434902D53F869267B3B267955C42D071EED0F75EAC9EE2D59BCCBC07F19D91324A4EE4EBA0AC6BA5B550B0A" },
    v22 = { "FC08D2AB9582D6F4615980949FA2618AAC53CBB95A1190324E72F6C1834999D29B626A687F5D4772B907E961FB7F2878E933C528CCC29D6AE8B89D40CAC0C0A3", "E88CF6B01FCC2D6ABF369094DBBE87B5F1A934FEDCDD13EC397D769AEE9C841DB51C62EF0F000953E1B4A74EACD5E1A15CA6CBBFA2836A14D7EA730526F176BA" },
    v23 = { "D4F271DA93507E1F6024801A307B773858EEF473FC29609BE5C3EDDF12DD15078356E427A407F81CDC64CE19773A6F7D282E0EA95C0D73C16DA1187B5F21C809", "E58A95E70F1B64A5F3190BB63C28D0496D3A1F5AD470E1227EDDFD3322CBF1728CD05F7CE359DF444870A6AFE63F046CB8D8F2A4FE738CC3FA2AFC0CA0492C96", "A64E40BB4E734000F16278BB87DED156AD3C3DFEFDDEE45B301A74C585B049CB93A539289FE9532C559A8BD429788DE25C488F3A1737605CD4E36D224DC3544E" }
}

local hmac_test_output = {
    v1 = { "2704E7F5254DD6595518D0D06A99C474CF8A85EAD6EBAC8A8DE6C3A2DA2EAA59F960EE29779255B18D526DFEA6D6AFAC3A33CBA0274A309D0F6A2AB320230838" },
    v2 = { "B3DE8895326D0A69AADF681310BAA6633184B7039ED897EEDE1D9E49E13A801785A20C4CF72CE562D68545D88D5379CA7AF89BC179B861D2CF3CCFA174045FEA" },
    v3 = { "98AC55B54D475F51227F172F2D51F8D0D71F69C3E91AA6F57B049EE4F520D985C096FAD38BCEA28EC4635554CC9AD6A12F360567C343752058E84C7987EEAFFE", "020BD26B4FFB0C8B88BFF71D38F77BE649A19FCD80CADB9F0013F1002ADC2ED4A211550EF210CB29DEFEDD081FE42D365F2EFE7452CB70D5307F20EB0E2BE54D" },
    v4 = { "A8EB32136CD6AB9A4C2FF6F3429AAF7E6508682653DB56E3E3F5E7CAFAA355C80A77CBCEA6603653DF5BCDCD78871AEE76BA4949B326D5638CDEC6DD80387141", "B6CB9F90A75D88D96A4BB96517CB8639467D4958FC8B7FD31275B048F832C395398E687A20B4769F960ED0781C8072BA9F50465B7BB652F30F0A3AE236FDA507", "2E4F1F92D4E16252328C44C0D8C83882AC44E3B62184C1BE22333086BABC5F97126CC7D7C9E7DB93CE15310B2DF9FCFCC1DE817DB814A2F982F5AE1405D4ABCB" }
}

runner.hash_runner("whirlpool", hmod, hash_test_output)
runner.hmac_runner("whirlpool", hmod, hmac_test_output)
