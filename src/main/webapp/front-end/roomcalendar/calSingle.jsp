<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style>
        .container {
            text-align: center;
        }

        th {
            text-align: center;
        }

        th.scope {
            background-color: red;
            color: white;
        }

        .selected {
            background-color: #007bff;
            color: white;
        }

        .calstatus {
            padding-right: 20px;
        }
    </style>
</head>
<body>
 <div class="container" margin-bottom: 10px;>
		<form id = "roomTypeno" name = "roomTypeDropdown" action="${pageContext.request.contextPath}/calender.do?action=getSingle" method="post">
			
			<select name="dropdown">
				<option value="1">(1)豪華套房1-單人房</option>
				<option value="2">(2)豪華套房2-單人房</option>
				<option value="3">(3)標準房1-單人房</option>
				<option value="4">(4)標準房2-單人房</option>
				<option value="5">(5)家庭套房2-二人房</option>
				<option value="6">(6)家庭套房2-二人房</option>
				<option value="7">(7)豪華套房3-四人房</option>
				<option value="8">(8)豪華套房3-四人房</option>
				<option value="9">(9)標準房3-八人房</option>
				<option value="10">(10)奢華套房-八人房</option>
			</select>
			<input type="submit" value="提交">
		</form>
		<input type="text" id="selectedDate" readonly> 
	</div>
    <div class="container text-center my-4">
        <button id="prevMonth" class="btn btn-primary">上個月</button>
        <span id="currentMonthYear" class="h4 mx-4">August 2023</span>
        <button id="nextMonth" class="btn btn-primary">下個月</button>
    </div>
    <div class="container">
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th class="scope">星期日</th>
                    <th>星期一</th>
                    <th>星期二</th>
                    <th>星期三</th>
                    <th>星期四</th>
                    <th>星期五</th>
                    <th class="scope">星期六</th>
                </tr>
            </thead>
            <tbody id="calendarBody">
                <!-- Calendar body content here -->
            </tbody>
        </table> 
    </div>
<script>
   
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
        selectedDateInput.value = year + "/" + month + "/" + day;
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
            cell.innerHTML += "<label class=\"calstatus\" name=\"calstatus\" id=\"" + year + "-" + (month + 1) + "-" + dday + "\"pointer-events:none>" + day + "</label>";
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
    $.ajax({
      url: "/cha103g2/front-end/roomcalendar/getRedisCalSingle.jsp",
      type: "GET",
      //取得伺服器回傳的資料轉成json
      success: function(response) {
        var jsonData = JSON.parse(response);
        var el = document.getElementsByName('calstatus');
        //json取值
        jsonData.forEach(function(item) {
          
          var vdate = item.vDate;
          var aStatus = item.aStatus;
          var labelId = vdate;          
          var labelElement = document.getElementById(labelId);
         //尋找行事曆上原的日期若有找到則填入狀態○、△、X	
          if (labelElement) {
            labelElement.innerHTML +=`&nbsp;&nbsp;` + aStatus;
          }
        });
      },
      error: function(error) {}
    });
  }
  /*表單送出  */
   

    // 保存下拉选择
    function saveSelectedOption() {
        let selectedOption = document.getElementById("dropdown").value;
        localStorage.setItem("selectedOption", selectedOption);
    }
</script>
   
</body>
</html>