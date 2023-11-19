      window.onload = function () {
        //當頁面載完之後，用AddressSeleclList.Initialize()，
        //傳入要綁定的縣市下拉選單ID及鄉鎮市區下拉選單ID
        AddressSeleclList.Initialize("縣市1", "鄉鎮市區1");
        //後面四個參數分別是兩個下拉選單的預設文字跟值
        AddressSeleclList.Initialize(
          "縣市2",
          "鄉鎮市區2",
          "Please Select City",
          "0",
          "Please Select Area",
          "0"
        );
      };
      function show() {
        //取出指定縣市及鄉鎮市區的下拉選單的值
        alert(AddressSeleclList.ReturnSelectAddress("縣市1", "鄉鎮市區1"));
      }

      var app = (window.AddressSeleclList = {
        AdrressArray: [
          [
            "台北市",
            "100中正區",
            "103大同區",
            "104中山區",
            "105松山區",
            "106大安區",
            "108萬華區",
            "110信義區",
            "111士林區",
            "112北投區",
            "114內湖區",
            "115南港區",
            "116文山區",
          ],
          [
            "新北市",
            "207萬里區",
            "208金山區",
            "220板橋區",
            "221汐止區",
            "222深坑區",
            "223石碇區",
            "224瑞芳區",
            "226平溪區",
            "227雙溪區",
            "228貢寮區",
            "231新店區",
            "232坪林區",
            "233烏來區",
            "234永和區",
            "235中和區",
            "236土城區",
            "237三峽區",
            "238樹林區",
            "239鶯歌區",
            "241三重區",
            "242新莊區",
            "243泰山區",
            "244林口區",
            "247蘆洲區",
            "248五股區",
            "249八里區",
            "251淡水區",
            "252三芝區",
            "253石門區",
          ],
          [
            "宜蘭縣",
            "260宜蘭市",
            "261頭城鎮",
            "262礁溪鄉",
            "263壯圍鄉",
            "264員山鄉",
            "265羅東鎮",
            "266三星鄉",
            "267大同鄉",
            "268五結鄉",
            "269冬山鄉",
            "270蘇澳鎮",
            "272南澳鄉",
          ],
          ["連江縣", "209南竿鄉", "210北竿鄉", "211莒光鄉", "212東引鄉"],
          ["新竹市", "300東區", "300北區", "300香山區"],
          [
            "新竹縣",
            "302竹北市",
            "303湖口鄉",
            "304新豐鄉",
            "305新埔鎮",
            "306關西鎮",
            "307芎林鄉",
            "308寶山鄉",
            "310竹東鎮",
            "311五峰鄉",
            "312橫山鄉",
            "313尖石鄉",
            "314北埔鄉",
            "315峨眉鄉",
          ],
          [
            "桃園市",
            "320中壢區",
            "324平鎮區",
            "325龍潭區",
            "326楊梅區",
            "327新屋區",
            "328觀音區",
            "330桃園區",
            "333龜山區",
            "334八德區",
            "335大溪區",
            "336復興區",
            "337大園區",
            "338蘆竹區",
          ],
          [
            "苗栗縣",
            "350竹南鎮",
            "351頭份市",
            "352三灣鄉",
            "353南庄鄉",
            "354獅潭鄉",
            "356後龍鎮",
            "357通霄鎮",
            "358苑裡鎮",
            "360苗栗市",
            "361造橋鄉",
            "362頭屋鄉",
            "363公館鄉",
            "364大湖鄉",
            "365泰安鄉",
            "366銅鑼鄉",
            "367三義鄉",
            "368西湖鄉",
            "369卓蘭鎮",
          ],
          [
            "台中市",
            "400中區",
            "401東區",
            "402南區",
            "403西區",
            "404北區",
            "406北屯區",
            "407西屯區",
            "408南屯區",
            "411太平區",
            "412大里區",
            "413霧峰區",
            "414烏日區",
            "420豐原區",
            "421后里區",
            "422石岡區",
            "423東勢區",
            "424和平區",
            "426新社區",
            "427潭子區",
            "428大雅區",
            "429神岡區",
            "432大肚區",
            "433沙鹿區",
            "434龍井區",
            "435梧棲區",
            "436清水區",
            "437大甲區",
            "438外埔區",
            "439大安區",
          ],
          [
            "彰化縣",
            "500彰化市",
            "502芬園鄉",
            "503花壇鄉",
            "504秀水鄉",
            "505鹿港鎮",
            "506福興鄉",
            "507線西鄉",
            "508和美鎮",
            "509伸港鄉",
            "510員林鎮",
            "511社頭鄉",
            "512永靖鄉",
            "513埔心鄉",
            "514溪湖鎮",
            "515大村鄉",
            "516埔鹽鄉",
            "520田中鎮",
            "521北斗鎮",
            "522田尾鄉",
            "523埤頭鄉",
            "524溪州鄉",
            "525竹塘鄉",
            "526二林鎮",
            "527大城鄉",
            "528芳苑鄉",
            "530二水鄉",
          ],
          [
            "南投縣",
            "540南投市",
            "541中寮鄉",
            "542草屯鎮",
            "544國姓鄉",
            "545埔里鎮",
            "546仁愛鄉",
            "551名間鄉",
            "552集集鎮",
            "553水里鄉",
            "555魚池鄉",
            "556信義鄉",
            "557竹山鎮",
            "558鹿谷鄉",
          ],
          ["嘉義市", "600東區", "600西區"],
          [
            "嘉義縣",
            "602番路鄉",
            "603梅山鄉",
            "604竹崎鄉",
            "605阿里山",
            "606中埔鄉",
            "607大埔鄉",
            "608水上鄉",
            "611鹿草鄉",
            "612太保市",
            "613朴子市",
            "614東石鄉",
            "615六腳鄉",
            "616新港鄉",
            "621民雄鄉",
            "622大林鎮",
            "623溪口鄉",
            "624義竹鄉",
            "625布袋鎮",
          ],
          [
            "高雄市",
            "800新興區",
            "801前金區",
            "802苓雅區",
            "803鹽埕區",
            "804鼓山區",
            "805旗津區",
            "806前鎮區",
            "807三民區",
            "811楠梓區",
            "812小港區",
            "813左營區",
            "814仁武區",
            "815大社區",
            "820岡山區",
            "821路竹區",
            "822阿蓮區",
            "823田寮區",
            "824燕巢區",
            "825橋頭區",
            "826梓官區",
            "827彌陀區",
            "828永安區",
            "829湖內區",
            "830鳳山區",
            "831大寮區",
            "832林園區",
            "833鳥松區",
            "840大樹區",
            "842旗山區",
            "843美濃區",
            "844六龜區",
            "845內門區",
            "846杉林區",
            "847甲仙區",
            "848桃源區",
            "849那瑪夏區",
            "851茂林區",
            "852茄萣區",
          ],
          [
            "基隆市",
            "200仁愛區",
            "201信義區",
            "202中正區",
            "203中山區",
            "204安樂區",
            "205暖暖區",
            "206七堵區",
          ],
          [
            "屏東縣",
            "900屏東市",
            "901三地門鄉",
            "902霧臺鄉",
            "903瑪家鄉",
            "904九如鄉",
            "905里港鄉",
            "906高樹鄉",
            "907鹽埔鄉",
            "908長治鄉",
            "909麟洛鄉",
            "911竹田鄉",
            "912內埔鄉",
            "913萬丹鄉",
            "920潮州鎮",
            "921泰武鄉",
            "922來義鄉",
            "923萬巒鄉",
            "924崁頂鄉",
            "925新埤鄉",
            "926南州鄉",
            "927林邊鄉",
            "928東港鎮",
            "929琉球鄉",
            "931佳冬鄉",
            "932新園鄉",
            "940枋寮鄉",
            "941枋山鄉",
            "942春日鄉",
            "943獅子鄉",
            "944車城鄉",
            "945牡丹鄉",
            "946恆春鎮",
            "947滿州鄉",
          ],
          [
            "澎湖縣",
            "880馬公市",
            "881西嶼鄉",
            "882望安鄉",
            "883七美鄉",
            "884白沙鄉",
            "885湖西鄉",
          ],
          [
            "金門縣",
            "890金沙鎮",
            "891金湖鎮",
            "892金寧鄉",
            "893金城鎮",
            "894烈嶼鄉",
            "896烏坵鄉",
          ],
          [
            "臺東縣",
            "950臺東市",
            "951綠島鄉",
            "952蘭嶼鄉",
            "953延平鄉",
            "954卑南鄉",
            "955鹿野鄉",
            "956關山鎮",
            "957海端鄉",
            "958池上鄉",
            "959東河鄉",
            "961成功鎮",
            "962長濱鄉",
            "963太麻里",
            "964金峰鄉",
            "965大武鄉",
            "966達仁鄉",
          ],
          [
            "花蓮縣",
            "970花蓮市",
            "971新城鄉",
            "972秀林鄉",
            "973吉安鄉",
            "974壽豐鄉",
            "975鳳林鎮",
            "976光復鄉",
            "977豐濱鄉",
            "978瑞穗鄉",
            "979萬榮鄉",
            "981玉里鎮",
            "982卓溪鄉",
            "983富里鄉",
          ],
          ["南海島", "817東沙群島", "819南沙群島"],
          ["釣魚臺", "290釣魚臺"],
        ],
        defaultOptionCityText: "請選擇縣市",
        defaultOptionCityValue: "",
        defaultOptionAreaText: "請選擇鄉鎮",
        defaultOptionAreaValue: "",

        Initialize: function (
          city,
          area,
          defaultCityText,
          defaultCityValue,
          defaultAreaText,
          defaultAreaValue
        ) {
          var cityText = defaultCityText
            ? defaultCityText
            : this.defaultOptionCityText;
          var cityValue = defaultAreaValue
            ? defaultAreaValue
            : this.defaultOptionCityValue;
          var areaText = defaultAreaText
            ? defaultAreaText
            : this.defaultOptionAreaText;
          var areaValue = defaultAreaValue
            ? defaultAreaValue
            : this.defaultOptionAreaValue;

          var citySelect = document.getElementById(city);
          var areaSelect = document.getElementById(area);

          citySelect.options[0] = new Option(cityText, cityValue);
          areaSelect.options[0] = new Option(areaText, areaValue);
          for (var i = 0; i < this.AdrressArray.length; i++) {
            citySelect.options[i + 1] = new Option(
              this.AdrressArray[i][0],
              this.AdrressArray[i][0]
            );
          }
          citySelect.addEventListener
            ? citySelect.addEventListener(
                "change",
                function (e) {
                  app.AppendArea(e, areaSelect, areaText, areaValue);
                },
                false
              )
            : citySelect.attachEvent("onchange", function (e) {
                app.AppendArea(e, areaSelect, areaText, areaValue);
              });
        },

        AppendArea: function (e, AreaSelect, areaText, areaValue) {
          var target = e.target ? e.target : e.srcElement;
          if (target.selectedIndex == 0) {
            AreaSelect.options.length = 0;
            AreaSelect.options[0] = new Option(areaText, areaValue);
            return;
          }
          AreaSelect.options.length =
            this.AdrressArray[target.selectedIndex - 1].length - 1;
          for (
            var i = 1;
            i < this.AdrressArray[target.selectedIndex - 1].length;
            i++
          ) {
            AreaSelect.options[i - 1] = new Option(
              this.AdrressArray[target.selectedIndex - 1][i],
              this.AdrressArray[target.selectedIndex - 1][i]
            );
          }
        },

        ReturnSelectAddress: function (city, area) {
          var city = document.getElementById(city);
          var area = document.getElementById(area);
          return city.value + area.value;
        },
      });


