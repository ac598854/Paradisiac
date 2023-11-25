var prevMonthButton = document.getElementById("prevMonth");
var nextMonthButton = document.getElementById("nextMonth");
var currentMonthYear = document.getElementById("currentMonthYear");
var calendarBody = document.getElementById("calendarBody");
var selectedDateInput = document.getElementById("selectedDate");
var holidays = [];       //存放 Fetch API 獲取 (政府資料開放平台上的中華民國政府行政機關辦公日曆表)JSON 數據
let holidayMapping={};   //存放日期=>key：狀態=>value(平日為1、假日為2、連續假日為3)，的映射資料，讓房價可以依這3種狀態分別計價
//日期不等於"X跟--，才可以選取 
var regex = /X|(--)/;
//點選行事曆日期後顯示在 textbox中
calendarBody.addEventListener("click", function(event) {
  var clickedCell = event.target; 
  console.log(clickedCell)  
  // 移除之前已選取的日期的樣式   
  if (clickedCell.textContent !== "") {
    var selectedCells = document.querySelectorAll(".selected");
    selectedCells.forEach(function(cell) {
      cell.classList.remove("selected");
    });
 // 日期不等於"X跟--，才可以選取"
    if (!regex.test(clickedCell.textContent)) {
      clickedCell.classList.add("selected");
    }else{
      selectedDateInput="";
    }
    var clickedDate = new Date(currentYear, currentMonth, parseInt(clickedCell.textContent));
    
   //將選擇的日期格長化後輸出至textbox，格式為2023/08/23
    var year = clickedDate.getFullYear();
   //注意月份數值需要加1，並且數值個位數需補0
    var month = String(clickedDate.getMonth() + 1).padStart(2, '0');
    var day = String(clickedDate.getDate()).padStart(2, '0');
    if (clickedCell.tagName === "TD" && clickedCell.textContent !== "" && !regex.test(clickedCell.textContent)) {
      /*===============當選取日期後到後端取出 房型資訊================  */
      var selectDay = year + "-" + month + "-" + day;    	
       //依擇的日期找出當日所有房型資訊
         getSingleForDay(selectDay); 
        /*===============================  */
    }
  }
});

var currentDate = new Date();
var currentDay = currentDate.getDate() - 1;
var currentMonth = currentDate.getMonth();
var currentYear = currentDate.getFullYear(); 	
//透過 Fetch API 獲取 (政府資料開放平台上的中華民國政府行政機關辦公日曆表)JSON 數據 -一開始就要先取得假日資料之後才能填充至行事曆
 holidayData(currentMonth, currentYear); 
//產生行事曆
function renderCalendar(month, year) {
//執行前先刷新頁面  	 
  calendarBody.innerHTML = "";
  currentMonthYear.innerHTML = getMonthName(month) + " " + year;
  var firstDayOfMonth = new Date(year, month, 1).getDay();
  var daysInMonth = new Date(year, month + 1, 0).getDate();
  var day = 1;
  for (var i = 0; i < 6; i++) {
    var row = document.createElement("tr");
    for (var j = 0; j < 7; j++) {
      var cell = document.createElement("td");
      if (i === 0 && j < firstDayOfMonth) {
        cell.textContent = "";
      } else if (day <= daysInMonth) {
         //超過當天之前的日期不顯示
        if (day > currentDay || currentMonth > currentDate.getMonth() || currentYear > currentDate.getFullYear()) {				
      //==========將行事曆綁定假日為紅字顯示========
            //月份在個位數的前方要補0，例1月份= 01
            var dday = String("" + day).padStart(2, '0');
            //綁定label的id
              var labelId = year + "-" + String(month + 1).padStart(2, '0') + "-" + dday;
              var spanId = year + "-" + String(month + 1).padStart(2, '0') + "-" + dday;
              //建立label元素
            var labelElement = document.createElement("label");
            //labelElement.className = "calstatus";
            labelElement.name = "calstatus";
            labelElement.id = labelId;  
            labelElement.className = "cal-date";
          //	console.log("labelId:==========>",labelId);   
            // 判斷日期是否為假日，如果是，則添加相應的標記
            var holidayData = holidays.find(h => h.date === (year + String(month + 1).padStart(2, '0') + dday));  
      //console.log("holidayData:======"+(year + String(month + 1).padStart(2, '0') + dday));  
      //若有透過fetch取到holidayData的資料時則進行假日的綁定，將是假日的日期標記紅字  				
      if (labelElement && holidayData) {	
        //若是假日則將日期標示紅字				
        if (holidayData.isHoliday) {
          
          labelElement.innerHTML = `&nbsp;&nbsp;<span id =${spanId} class="holiday">${day}</span>`;
          labelElement.querySelector('.holiday').style.color = 'red';
        } else {
          //平日則不改變
          labelElement.innerHTML = `&nbsp;&nbsp;${day}`;
        }
        //計算假日及連續假日
         //console.log(holidayMapping);
        getPriceBasedOnContinuousHolidays(holidays, holidayData);
      } else {
        labelElement.innerHTML = `&nbsp;&nbsp;${day}`;
      }
      cell.appendChild(labelElement);
            //========================
        } else {
          cell.innerHTML += "--";
        }
        day++;
      }
      row.appendChild(cell);
    }
    calendarBody.appendChild(row);
  }
  //執行房間狀態的填充將○、△、X填充在行事曆上面
  updateCalendarDate()
}

function getMonthName(month) {
  var months = [
    "一月", "二月", "三月",
    "四月", "五月", "六月",
    "七月", "八月", "九月",
    "十月", "十一月", "十二月"
  ];
  return months[month];
}
//上個月按鈕
prevMonthButton.addEventListener("click", function() {
//上個月的按鈕不能超過目前月份
  if (currentMonth > currentDate.getMonth() || currentYear > currentDate.getFullYear()) {
    currentMonth--;
    if (currentMonth < 0) {
      currentMonth = 11;
      currentYear--;    
      //★★★★★當年份有變更時才重新使用fetch去取得假日資訊，若是假日會將日期標記成紅字
      holidayData(currentMonth, currentYear);       
    }     
  if(currentMonth!=11){
      //行事曆重新填充日期
      renderCalendar(currentMonth, currentYear);   
   }    
  }
});
//下個月按鈕
  nextMonthButton.addEventListener("click", function() {
    currentMonth++;
    if(currentMonth > 11){
      currentMonth = 0;
      currentYear++;          
    } 
    //若是12月時要去多取得下年度的假日資料，否則跨年的連續假日會法判斷
    if(currentMonth==11){ 
	//★★★★★當年份有變更時才重新使用fetch去取得假日資訊，若是假日會將日期標記成紅字	
    holidayData(currentMonth, currentYear);
    }     
     //行事曆重新填充日期
    if(currentMonth!=11){
    renderCalendar(currentMonth, currentYear);   
    }   
  });

// 使用 Fetch API 獲取 (政府資料開放平台上的中華民國政府行政機關辦公日曆表)JSON 數據，取得假日資料，再將假日的資料綁定在行事曆上
function holidayData(currentMonth, currentYear){

fetch(`https://cdn.jsdelivr.net/gh/ruyut/TaiwanCalendar/data/${currentYear}.json`)	
.then(response => response.json())
.then(data => {
  // 將取得的假日資料存儲在holidays
  holidays = data;
    //console.log("取得連續假日資料：", holidays);
   // 判斷是否為12月，如果是，取得下一年度的假日資料
  // console.log("判斷月份：=====",currentMonth);
          if (currentMonth === 11) {
              fetch(`https://cdn.jsdelivr.net/gh/ruyut/TaiwanCalendar/data/${currentYear + 1}.json`)
                  .then(response => response.json())
                  .then(nextYearData => {
                      // 合併下一年度的假日資料到今年的假日資料，為了解決跨年度無法計算連續假日問題
                      holidays = holidays.concat(nextYearData);                      
                  	  renderCalendar(currentMonth, currentYear); 
                  })
                  .catch(error => console.error('獲取下一年度假日數據時發生錯誤:', error));
          } else {
              // 不是12月，直接渲染日曆              
              renderCalendar(currentMonth, currentYear);
          }          
      })
.catch(error => console.error('獲取假日數據時發生錯誤:', error));

}

//============================== 

//從redis讀取每日所有房型資料，將行事曆標記○、△、X等記號
function updateCalendarDate() {
  //取得檔案所在路徑/cha103g2/front-end/roomcalendar/calAll.jsp <---為了去取得照片所以使用動態取得專案名稱

let pathName = window.document.location.pathname;
      //字串分割後取得專案名稱/cha103g2  <---為了去取得照片所以使用動態取得專案名稱
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);
    //	console.log("檔案路徑："pathName, "=專案路徑", projectName);
  $.ajax({
    url: `${projectName}/front-end/roomcalendar/getRedisCalAll.jsp`,
    type: "GET",
    //取得伺服器回傳的資料轉成json
    success: function(response) {
      var jsonData = JSON.parse(response);
    //  var el = document.getElementsByName('calstatus');
      //json取值
      jsonData.forEach(function(item) {
        
        var vdate = item.vdate;
        var aStatus = item.aStatus;
        var labelId = vdate; 
             
        var labelElement = document.getElementById(labelId);
       // console.log("測試:==labelElement:",labelElement,"aStatus:",aStatus,"vdate:",vdate);
       //尋找行事曆上原的日期若有找到則填入狀態○、△、X
       
        if (labelElement) {
     
          labelElement.innerHTML +=`&nbsp;&nbsp;` + aStatus;
        }
      });
    },
    error: function(error) {}
  });
}
//===================================
// 在房型資料動態生成下拉選單，可以選取可下訂的房間數
function generateOptions(start, end, selectedValue, roomTypeNo, vDate) {
let options = '';
for (let i = start; i <= end; i++) {
  options += `<option value="${i}">${i}</option>`;
}
return options;
}
//===================================
//依選擇的日期到後端取得資料房型資訊，顯示在行事曆下方
function getSingleForDay(selectDay) {
console.log("取得日期資料：", selectDay);
const data = { selectDay: selectDay };
//取得檔案所在路徑/cha103g2/front-end/roomcalendar/calAll.jsp <---為了去取得照片所以使用動態取得專案名稱
let pathName = window.document.location.pathname;
//字串分割後取得專案名稱/cha103g2  <---為了去取得照片所以使用動態取得專案名稱
let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);
//	console.log("檔案路徑："pathName, "=專案路徑", projectName);
//roominfo.do -->roomcalendar/getCalendarInfoServlet.java
fetch(`${projectName}/roominfo.do/firstGet`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  //將日期送到後端查詢當天房型
  body: JSON.stringify(data)
})
  // response.text()是從servlet取得的資料
  .then(response => response.json())
  .then(jsonData => {
    // ★★★★★動態生成下拉選單generateOptions()透過這個方法將roomTypeNo, vDate順傳一起傳================
    function generateOptions(start, end, selectedValue, roomTypeNo, vDate) {
          let options = '';
            for (let i = start; i <= end; i++) {
              options += `<option value="${i}">${i}</option>`;
            }
          return options;
    }
    //★★★★★===============================================
    
    const roomInfoContainer = document.getElementById('roomInformation');
    roomInfoContainer.innerHTML = "";
    console.log(jsonData);
    jsonData.forEach(item => {
      //取得檔案所在路徑/cha103g2/front-end/roomcalendar/calAll.jsp <---為了去取得照片所以使用動態取得專案名稱
      let pathName = window.document.location.pathname;
      //字串分割後取得專案名稱/cha103g2  <---為了去取得照片所以使用動態取得專案名稱
      let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);
      //	console.log("檔案路徑："pathName, "=專案路徑", projectName);
      //可下訂數量（將房型的總數量減掉已下訂的數量＝可下訂數量）
      let booking = item.roomTotal - item.rbooking;
      let rTotal = item.roomTotal;
      
      //可下訂數量不等於0的房型才顯示
      if (booking != 0) {
       // 動態生成下拉選單的 HTML
          let optionsHtml = generateOptions(1, booking, 1, item.roomTypeNo, item.vDate);
      //計算平日、假日、連續假日房價
      const priceType = holidayMapping[item.vDate];
      
      //切換平日價格、假日價格、連假價格
      let priceStr ;
      // 根據價格類型設定價格
      let selectedPrice;
      if (priceType === 1) {
        selectedPrice = item.price; // 平日價格
        priceStr ="平日價格";
      } else if (priceType === 2) {
        selectedPrice = item.holiDayPrice; // 假日價格
        priceStr ="假日價格";
      } else if (priceType === 3) {
        selectedPrice = item.bridgeHolidayPrice; // 連假價格（原賈）
        priceStr ="連假價格"
      } else {
      // 如果沒有對應的價格類型，可以設定一個預設值或者處理邏輯
        selectedPrice = item.price;
      }
      
      
        let html = `
          <div class="container" style="border: 1px solid black; padding: 10px; margin-bottom:10px; border-radius: 10px;box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.1);">
              <div class="row">
                 <div class="col-md-4">
                       <img src=${projectName}/DBGifReader2?picno=${item.roomTypeNo} width="300x">
                </div>
                <div class="col-md-8 ">
                    <h2 class="roomName">${item.roomName}</h2>
                    <br>
                      <ul class="ul_container text-left" style="list-style-position: block;">
                       <div class="row">
                          <div class="col-md-6">
                            <!--<li>房型編號： ${item.roomTypeNo}</li>-->
                            <li>房型：${item.rType}</li>                             	   
                               <li>設施：${item.notice}</li>
                               <!--<li>原價：${item.price}元</li>-->
                               <li>原價：${item.bridgeHolidayPrice}</li>
                           <li>總間數：${item.roomTotal}間</li>                       		
                            <!--<li>假日：${item.holiDayPrice}</li>-->
                            <!--<li>連假：${item.bridgeHolidayPrice}</li>-->                           	
                            <!-- 將預訂數量改成下拉選單 -->
                            <li>
                            <!--★★★★★===========動態生成下拉選單=========== -->
                            <label for="bookingSelect_${item.roomTypeNo}_${item.vDate}">下訂間數：</label>
                    <select id="bookingSelect_${item.roomTypeNo}_${item.vDate}" name="bookingSelect" data-roomTypeNo="${item.roomTypeNo}" data-vDate="${item.vDate}">
                      ${optionsHtml}	
                    </select>間
                      <!--★★★★★===========動態生成下拉選單=========== -->
                          </li>
                          
                      </div>
                      <div class="col-md-6">
                             <li>日期：${item.vDate}</li>                           	 
                             <li>設施：${item.facility}</li>
                             <li>${priceStr}：${selectedPrice}元</li>  <!--售價 -->                            	   
                             <li>剩餘間數：${booking}間</li>                         	                           	  
                            <li>
                             <a href="#" class="btn btn-primary fs-5" onclick="showDetail(${item.roomTypeNo}, '${item.vDate}', '${item.roomName}', '${item.rType}', ${item.holiDayPrice}, ${item.bridgeHolidayPrice}, ${item.price}, '${item.notice}', '${item.facility}', ${rTotal},document.getElementById('bookingSelect_${item.roomTypeNo}_${item.vDate}').value)">立即訂購</a>
                            </li>
                         </div>
                        </div>
                      </ul>
             </div>         
            </div>
        </div>
      `;	
      
    //	console.log("=====vDate:", item.vDate);
      roomInfoContainer.innerHTML += html;
      console.log(holidayMapping);
      //====================下拉選單取得可以下訂的房間數=====================================

      // ★★★★★為生成的下拉選單添加事件監聽器
      const bookingSelect = document.getElementById(`bookingSelect_${item.roomTypeNo}_${item.vDate}`);
      bookingSelect.addEventListener('change', function() {
        // 獲取選中的值
        const selectedBooking = bookingSelect.value;
        // 調用 showDetail 函數，將選中的值傳遞給它
        showDetail(item.roomTypeNo, item.vDate, item.roomName, item.rType, item.holiDayPrice, item.bridgeHolidayPrice, item.price, item.notice, item.facility, selectedBooking);
      
      });
      } //對映if的括號
    });

  })
}
//判斷假日還是連續假日，若是假日則在label的標籤將class標示holiday0表示平日，holiday1表示假日，holiday2表示超過3天的連續假日============================================
function getPriceBasedOnContinuousHolidays(holidays, currentHoliday) {	
  var continuousDays = getContinuousHolidaysCount(holidays, currentHoliday);
  //取出日期來判斷，該日期的前後是否有放假
  var dayMarkHolidayStatus=parseDateFromString(currentHoliday.date);
  //console.log("測試",dayMarkHolidayStatus);
   console.log("測試====continuousDays======",continuousDays.date);
  if (continuousDays === 2) {       
    holidayMapping[dayMarkHolidayStatus]=2;     //假日(放假2天以內)
  } else if (continuousDays >= 3) {      
    holidayMapping[dayMarkHolidayStatus]=3;     //連續假日(放假3天以上)
  } else {      
 
    holidayMapping[dayMarkHolidayStatus]=1;     //平日
  }
}
//檢查今天之前跟今天之後的日期是否為假日
function getContinuousHolidaysCount(holidays, currentHoliday) {
  var count = 1;
  var currentIndex = holidays.indexOf(currentHoliday);
/*console.log("currentHoliday:=====",currentIndex);
console.log("currentHoliday:=====",currentHoliday);*/
  // 檢查今天之前的日期是否為假日
  for (let i = currentIndex -1; i >= 0; i--) {		 
    if (holidays[i].isHoliday && isConsecutiveDay(holidays[i], holidays[i + 1])) {	
      count++;
    } else {
     
      break;
    }
  }	
  
  // 檢查今天之後的日期是否為假日
  for (let i = currentIndex +1; i < holidays.length; i++) {	 
    if (holidays[i].isHoliday && isConsecutiveDay(holidays[i-1], holidays[i])) {	 
      count++;
    } else {
      
      break;
    }
  }

  return count;
}
//檢查2個日期是否相鄰，用來判斷是否為連續假日date1、跟date2為json物件日期格式為20231123
function isConsecutiveDay(date1, date2) {
  var day1 = parseDateFromObject(date1);
    var day2 = parseDateFromObject(date2);     
   // 檢查2天是否相鄰	
  if (Math.abs(day2 - day1) / (1000 * 60 * 60 * 24) === 1) {
      // 如果2天是連鄰的假日則傳回true
      return date1.isHoliday && date2.isHoliday;
  }

  return false;
}
//把json物件裡面的日期轉成Date的格式(將20231123轉成2023-11-23)
function parseDateFromObject(obj) {
// 從物件中取得日期字串
const dateString = obj.date;

// 使用正規表達式提取年、月和日
const year = dateString.slice(0, 4);
const month = dateString.slice(4, 6);
const day = dateString.slice(6, 8);

// 使用Date物件建立日期
const dateObject = new Date(`${year}-${month}-${day}`);

// 回傳日期物件
return dateObject;
}

function parseDateFromString(dateString) {
 // 使用正規表達式提取年、月和日
  const year = dateString.slice(0, 4);
  const month = dateString.slice(4, 6);
  const day = dateString.slice(6, 8);
  // 使用Date物件建立日期
  const dateObject = new Date(`${year}-${month}-${day}`);
  // 將日期物件轉換為日期字串
  const str = dateObject.toISOString().split('T')[0];
  // 回傳日期字串
  return str;
}
//==============================================

//將按下立即訂房 取出資料顯示在燈箱上面
function showDetail(roomTypeNo, vDate, roomName, rType, holiDayPrice, bridgeHolidayPrice, price, notice, facility,roomtotal,rbooking) {
// 填充燈箱內容
let lightboxContent = document.getElementById('lightboxContent');
//以平日、假日、連續假日不同日期計算價錢===================================
// 獲取日期對應的價格類型
const priceType = holidayMapping[vDate];
console.log(priceType);
// 根據價格類型設定價格
let selectedPrice;
if (priceType === 1) {
  selectedPrice = price; // 原價
} else if (priceType === 2) {
  selectedPrice = holiDayPrice; // 假日價格
} else if (priceType === 3) {
  selectedPrice = bridgeHolidayPrice; // 連假價格
} else {
  // 如果沒有對應的價格類型，可以設定一個預設值或者處理邏輯
  selectedPrice = price;
}
//===================================
let pricetotal = selectedPrice * rbooking;
let html = "";
html = `
              <h3>房型編號：${roomTypeNo}</h3>
              <p>日期：${vDate}</p>
              <p>房間名稱：${roomName}</p>
              <p>房型：${rType}</p>
              <p>假日價格：${holiDayPrice}</p>
              <p>連假價格：${bridgeHolidayPrice}</p>
              <p>平日價格：${price}</p>
              <p>注意事項：${notice}</p>
              <p>設施：${facility}</p>
              <p>預訂數量：${rbooking}</p>
              <p>總共：${pricetotal}元</p>
          `;

lightboxContent.innerHTML = html;

// 顯示燈箱
$('#lightbox').modal('show');
//士傑跳轉
let originalDate = new Date(vDate);
  let nextDay = new Date(originalDate.getTime() + 24 * 60 * 60 * 1000);
  let formattedNextDay = `${nextDay.getFullYear()}-${(nextDay.getMonth() + 1).toString().padStart(2, '0')}-${nextDay.getDate().toString().padStart(2, '0')}`;


console.log(roomtotal);
// 創建一個包含所有資訊的物件

  let roomInfo = {
      roomTypeNo: roomTypeNo,
      vDate: vDate,
      formattedNextDay: formattedNextDay,
      roomName: roomName,
      rType: rType,
      holiDayPrice: holiDayPrice,
      bridgeHolidayPrice: bridgeHolidayPrice,
      price: price,
      notice: notice,
      facility: facility,
      rbooking: rbooking,
      roomtotal: roomtotal,
  };
 console.log("roomInfo",roomInfo);
  // 將資料轉為 JSON 字串，並存儲到 localStorage 中
  localStorage.setItem('roomInfo', JSON.stringify(roomInfo));
  window.location.href = '/Paradisiac/back-end/roomorder/orderbuy.jsp';

}