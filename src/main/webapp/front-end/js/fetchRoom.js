  var prevMonthButton = document.getElementById("prevMonth");
  var nextMonthButton = document.getElementById("nextMonth");
  var currentMonthYear = document.getElementById("currentMonthYear");
  var calendarBody = document.getElementById("calendarBody");
  var selectedDateInput = document.getElementById("selectedDate");
  //日期不等於"X跟--，才可以選取 
  var regex = /X|(--)/;
  //點選行事曆日期後顯示在 textbox中
  calendarBody.addEventListener("click", function(event) {
    var clickedCell = event.target;
    // 移除之前已選取的日期的樣式   
    if (clickedCell.tagName === "TD" && clickedCell.textContent !== "") {
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
    	  console.log(selectDay);
      	 /*  selectedDateInput.value =  year + "/" + month + "/" + day; */
       getSingleForDay(selectDay); 
          /*===============================  */
      }
    }
  });

  var currentDate = new Date();
  var currentDay = currentDate.getDate() - 1;
  var currentMonth = currentDate.getMonth();
  var currentYear = currentDate.getFullYear(); 
  //產生行事例
  function renderCalendar(month, year) {
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
            var dday = String("" + day).padStart(2, '0');
            cell.innerHTML += "<label class=\"calstatus\" name=\"calstatus\" id=\"" + year + "-" + String(month + 1).padStart(2, '0') + "-" + dday + "\"pointer-events:none>" + day + "</label>";
          } else {
            cell.innerHTML += "--";
          }
          day++;
        }
        row.appendChild(cell);
      }
      calendarBody.appendChild(row);
    }
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
      }
      renderCalendar(currentMonth, currentYear);
      updateCalendarDate();
    }
  });
  //下個月按鈕
  nextMonthButton.addEventListener("click", function() {
    currentMonth++;
    if (currentMonth > 11) {
      currentMonth = 0;
      currentYear++;
    }
    renderCalendar(currentMonth, currentYear);
    updateCalendarDate();
  });

  renderCalendar(currentMonth, currentYear);

  $(document).ready(function() {
    updateCalendarDate();
  });
  //從redis讀取每日所有房型資料
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
        var el = document.getElementsByName('calstatus');
        //json取值
        jsonData.forEach(function(item) {
          
          var vdate = item.vdate;
          var aStatus = item.aStatus;
          var labelId = vdate; 
               
          var labelElement = document.getElementById(labelId);
          console.log("測試:==labelElement:",labelElement,"aStatus:",aStatus,"vdate:",vdate);
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
// 動態生成下拉選單
function generateOptions(start, end, selectedValue, roomTypeNo, vDate) {
	let options = '';
	for (let i = start; i <= end; i++) {
		options += `<option value="${i}">${i}</option>`;
	}
	return options;
}
//===================================
//依選擇的日期到後端取得資料
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
			// ★★★★★動態生成下拉選單generateOptions()================
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
				//可下訂數量
				let booking = item.roomTotal - item.rbooking;
				
				//可下訂數量不等於0的房型才顯示
				if (booking != 0) {
				 // 動態生成下拉選單的 HTML
    		    let optionsHtml = generateOptions(1, booking, 1, item.roomTypeNo, item.vDate);
				
					let html = `
    				<div class="container" style="border: 1px solid black; padding: 10px;">
      				  <div class="row">
         			    <div class="col-md-4">
               		      <img src=${projectName}/DBGifReader2?picno=${item.roomTypeNo} width="300x">
            			</div>
            			<div class="col-md-8 ">
                			<h2>${item.roomName}</h2>
                			<p>這是我們酒店提供的最豪華的客房。這個房間設計精美，設有舒適的床和優雅的室內裝潢。</p>
               			 	<ul class="ul_container" style="list-style-position: block;">
                   			<div class="row">
                        		<div class="col-md-6">
                            	<li>房型編號： ${item.roomTypeNo}</li>
                            	<li>設施：${item.notice}</li>
                            	<li>假日：${item.holiDayPrice}</li>
                            	<li>連假：${item.bridgeHolidayPrice}</li>
                            	<!-- 將預訂數量改成下拉選單 -->
                            	<li>
                            	<!--★★★★★===========動態生成下拉選單=========== -->
                              <label for="bookingSelect_${item.roomTypeNo}_${item.vDate}">預訂數量：</label>
            				  <select id="bookingSelect_${item.roomTypeNo}_${item.vDate}" name="bookingSelect" data-roomTypeNo="${item.roomTypeNo}" data-vDate="${item.vDate}">
             				   ${optionsHtml}
           					 </select>
           					 	<!--★★★★★===========動態生成下拉選單=========== -->
                            </li>
                        </div>
                        <div class="col-md-6">
                           	  <li>日期：${item.vDate}</li>
                           	  <li>房型：${item.rType}</li>
                              <li>設施：${item.facility}</li>
                          	  <li>原價：${item.price}</li>
                          	  <li>總間數：${item.roomTotal}</li>
                          	  <li>可下訂數量：${booking}</li>
                     		  </div>
                 		  	 </div>
             		   		</ul>
             		   		
              			 <a href="#" class="badge btn-secondary rounded fs-5" onclick="showDetail(${item.roomTypeNo}, '${item.vDate}', '${item.roomName}', '${item.rType}', ${item.holiDayPrice}, ${item.bridgeHolidayPrice}, ${item.price}, '${item.notice}', '${item.facility}', document.getElementById('bookingSelect_${item.roomTypeNo}_${item.vDate}').value)">立即訂購</a>

         		  </div>
         
       			 </div>
    			</div>
				`;
				
				console.log("=====vDate:", item.vDate);
				roomInfoContainer.innerHTML += html;
				
				//=========================================================

				// ★★★★★為生成的下拉選單添加事件監聽器
				const bookingSelect = document.getElementById(`bookingSelect_${item.roomTypeNo}_${item.vDate}`);
				bookingSelect.addEventListener('change', function() {
					// 獲取選中的值
					const selectedBooking = bookingSelect.value;
					// 調用 showDetail 函數，將選中的值傳遞給它
					showDetail(item.roomTypeNo, item.vDate, item.roomName, item.rType, item.holiDayPrice, item.bridgeHolidayPrice, item.price, item.notice, item.facility, selectedBooking);


				//★★★★★============================================================
				});
				} //if的括號
			});

		})
}
	//將按下立即訂房 取出資料顯示在燈箱上面
 function showDetail(roomTypeNo, vDate, roomName, rType, holiDayPrice, bridgeHolidayPrice, price, notice, facility, rbooking) {
            // 填充燈箱內容
            let lightboxContent = document.getElementById('lightboxContent');
          
           
            let html ="";
            html = `
                <h3>房型編號：${roomTypeNo}</h3>
                <p>日期：${vDate}</p>
                <p>房間名稱：${roomName}</p>
                <p>房型：${rType}</p>
                <p>假日價格：${holiDayPrice}</p>
                <p>連假價格：${bridgeHolidayPrice}</p>
                <p>原價：${price}</p>
                <p>注意事項：${notice}</p>
                <p>設施：${facility}</p>
                <p>預訂數量：${rbooking}</p>
                <p>總共：${price*rbooking}元</p>
            `;
		
		lightboxContent.innerHTML =html;
		
            // 顯示燈箱
            $('#lightbox').modal('show');
        }

//=============================燈箱顯示訂房資訊-日期格式化


