<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.custom-button {
    background-color: rgba(051, 51, 102, 1);
    font-weight: bolder;
    color: #fff;
    border: none;
}

#updateRow:hover, #updateDetail:hover, #search_btn:hover,#InsertBtn:hover,#InsertBtn2:hover {
  background-color: rgba(051, 102, 204, 1);
  opacity: 0.8;
}

#deleteRowBtn:hover, #resetRow:hover, #deleteDetail:hover{
  background-color: rgba(204, 000, 051, 1);
  opacity: 0.8;
}

  #add-button2:hover ,#add-button:hover, #updateStatus:hover {
  background-color: rgba(80, 201, 141);
  opacity: 0.8;
}


    #add-button ,#add-button2 {
        position: absolute;
        right:50px;
    }
    #deleteDetail{
    position: absolute;
        right:20px;
     }
    #InsertBtn2{
        position: absolute;
        right:200px;
    }
    #updateDetail{
    position: absolute;
        right:85px;}
        
  	.form-title{
		width : 100px;
		height: 30px;
		color:black;
		font-weight:bold;
 		background-color: #e2e2e2;
		border:1px solid #e2e2e2;
		text-align:center;
		line-height : 30px;
		border-radius:3px;
		display:inline-block;
		}
		
			.form-data{
		width : 200px;
		height: 30px;
		line-height : 30px;
		border-radius:3px;
		border:1px solid #e2e2e2;
		display:inline-block;
		}
		
</style>

</head>



<body>
<button type="button" id="search_btn"  class="custom-button"><i class="fa fa-search"></i> 조회</button>
<button type="button" id="InsertBtn" class="custom-button"><i class="fa fa-pencil"></i> 등록</button>
<button type="button" id="updateRow" class="custom-button" ><i class="fa fa-pencil-square-o"></i> 수정</button>
<button type="button" id="deleteRowBtn" class="custom-button" ><i class="fa fa-trash"></i> 삭제</button>
<button type="button" id="resetRow"  class="custom-button"><i class="fa fa-power-off"></i> 초기화</button>
<button type="button" id="updateStatus" class="custom-button"><i class="fa fa-refresh"></i> 수주 상태변경</button>
<form>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="수주번호" disabled/><input type="text" class="form-data" id ="order_number" name="order_number" readonly style="background-color: lightgray;"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="수주상태" disabled/><input type="text" class="form-data" id ="order_status" name="order_status" readonly style="background-color: lightgray;"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="수주유형" disabled/><input type="text" class="form-data" id ="order_type" name="order_type" readonly style="background-color: lightgray;"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="거래처코드" disabled/><input type="text" class="form-data" id ="client_code" name="client_code" readonly style="background-color: lightgray;"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="수주일자" disabled/><input type="date" class="form-data" id ="order_date" name="order_date"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="납기일" disabled/><input type="date" class="form-data" id ="due_date" name="due_date"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="수주담당자" disabled/><input type="text" class="form-data" id ="order_empid" name="order_empid"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="등록일" disabled/><input type="date" class="form-data" id ="create_date" name="create_date"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="등록자" disabled/><input type="text" class="form-data" id ="create_user" name="create_user"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="date" class="form-title" value="수정일" disabled/><input type="date" class="form-data" id ="update_date" name="update_date"/></div>
    <div style="display:inline-block; margin:5px; font-size:13px; color:black;"><input type="text" class="form-title" value="수정자" disabled/><input type="text" class="form-data" id ="update_user" name="update_user"/></div>
</form>
      <br>
   <button id="add-button"  class="custom-button"><i class="fa fa-plus" aria-hidden="true" ></i></button>
  <h4>수주서</h4>
  <div id="grid" ></div>
  <br>
  <button type="button" id="InsertBtn2"  class="custom-button" ><i class="fa fa-pencil"></i> 세부 등록</button>
  <button type="button" id="updateDetail"  class="custom-button"><i class="fa fa-pencil-square-o"></i> 세부 수정</button>
  <button id="add-button2" class="custom-button"><i class="fa fa-plus" aria-hidden="true"  ></i></button>
  <button id="deleteDetail" class="custom-button"><i class="fa fa-minus" aria-hidden="true"  ></i></button>
  <h4>세부항목</h4>
  <div id="grid2"></div>
<script type="text/javascript" >
var contextPath = '<%= request.getContextPath() %>';

$(document).ready(function(){
var gridData = [];
    var grid = new tui.Grid({
	    el: document.getElementById('grid'),
	    data: gridData,
		scrollX: true,
		scrollY: true,
		bodyHeight: 180,
		useFit:true,
		rowHeaders: ['rowNum','checkbox'],
		    columns: [
		         {header: '회사코드',name: 'company_code',sortingType: 'asc',sortable: true,align: 'center',hidden:true},
		         {header: '거래처코드',name: 'client_code',sortingType: 'asc',sortable: true,align: 'center'},
				 {header: '상태',name: 'order_status', sortingType: 'asc',sortable: true,align: 'center'},
				 {header: '수주번호', name: 'order_number',	sortingType: 'asc',sortable: true,width:90,align: 'center'},
				 {header: '수주유형',name: 'order_type',	 sortingType: 'asc',sortable: true,editor:'text',align: 'center',defaultValue:'자체생산'},
				 {header: '수주일자',name: 'order_date',sortingType: 'asc',sortable: true,editor:{type: "datePicker",options: {format: "yyyy-MM-dd"}},align: 'center'},
				 {header: '납품처',name: 'customer_code',	 sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
				 {header: '납기일',name: 'due_date',sortingType: 'asc',sortable: true,editor:{type: "datePicker",options: {format: "yyyy-MM-dd"}},align: 'center'},
				 {header: '수주담당자',name: 'order_empid',sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
				 {header: '비고',name: 'memo', sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
				 {header: '등록일',name: 'create_date',	 sortingType: 'asc',sortable: true,width:'auto',align: 'center'},
				 {header: '등록자',name: 'create_user',	 sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
				 {header: '수정일',name: 'update_date',sortingType: 'asc',sortable: true,width:'auto',align: 'center'},
				 {header: '수정자',name: 'update_user',	 sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
				 {header: '총액',name: 'amount', sortingType: 'asc',sortable: true,editor:'text',align: 'center' },
				 {header: '제목',name: 'title', sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
				 {header: '삭제여부',name: 'delete_yes_no',align: 'center'}
		    ]
		});
	
    
    var gridData2 = [];
    var grid2 = new tui.Grid({
	    el: document.getElementById('grid2'),
	    data: gridData2,
		scrollX: false,
		scrollY: true,
		useFit :true,
		bodyHeight: 180,
		rowHeaders: ['rowNum','checkbox'],
		    columns: [
		        {header: 'oddNo',name: 'oddNo',sortingType: 'asc',sortable: true,hidden:true},
		        {header: '수주번호',name: 'order_number',sortingType: 'asc',sortable: true},
		        {header: 'ITEM코드',name: 'item_code',sortingType: 'asc',sortable: true,align: 'center'},
		        {header: '단가',name: 'price',sortingType: 'asc', sortable: true ,align: 'center',defaultValue:0},
		        {header: '재고단위',name: 'item_st_unit',sortingType: 'asc', sortable: true ,align: 'center'},
		        {header: '수량', name: 'quantity', sortingType: 'asc',sortable: true,editor:'text',align: 'center',defaultValue:0},
		        {header: '총액',name: 'amount',sortingType: 'asc',sortable: true,align: 'center'},
		        {header: '비고', name: 'memo', sortingType: 'asc',sortable: true,editor:'text',align: 'center'},
		        {header: '삭제여부',name: 'delete_yes_no',hidden:true,align: 'center'}
		    ]
    });
  /////////////////////////////////////////////  
  //총액 자동 계산 
 grid2.on('afterChange', function(ev) {
  var changes = ev.changes;
  
  changes.forEach(function(change) {
    var rowKey = change.rowKey;
    var column = change.columnName;
    var value = change.value;
    
    if (column === 'price' || column === 'quantity') {
      var rowData = grid2.getRow(rowKey);
      var price = rowData.price || 0;
      var quantity = rowData.quantity || 0;
      var amount = price * quantity;
      
      grid2.setValue(rowKey, 'amount', amount);
    }
  });
});
  /////////////////////////////////////////////  
  
//초기화 버튼
	var resetRow = document.getElementById('resetRow');
		 resetRow.addEventListener('click', function() {
	      var confirmMsg = `초기화 하시겠습니까?`;
	      if(confirm(confirmMsg))
		  grid.clear();
		  grid2.clear();
	 });  
 /////////////////////////////////////////////////////   
//전체조회
	$.ajax({
	    url: '<%=request.getContextPath()%>/so/orderList',
	    method: 'GET',
	    dataType: 'JSON',
	    success: function(data) {
	    	console.log(data);
	        gridData = data;
	        grid.resetData(gridData);
	    },
	    error: function(xhr, status, error) {
	        console.log(error);
	    }
	});
///////////////////////////////////////////////////////		 
// 조회버튼 눌러야지만 데이터 나옴
	$('#search_btn').on('click', function() {
	    $.ajax({
	        url: '<%=request.getContextPath()%>/so/orderList',
	        method: 'GET',
	        dataType: 'JSON',
	        success: function(data) {
	            console.log(data);
	            gridData = data;
	            grid.resetData(gridData);
	        },
	        error: function(xhr, status, error) {
	            console.log(error);
	        }
	    });
	}); 
///////////////////////////////////////////////////
// 수주서 행 추가 버튼
	 var addButton = document.querySelector('#add-button');
	addButton.addEventListener('click', function() {
	  var rowData = {}; // 빈 행 데이터
	  grid.appendRow(rowData);
	});
//아이템 행 추가 버튼
	var addButton2 = document.querySelector('#add-button2');
	addButton2.addEventListener('click', function() {
	  var selectedRow = grid.getCheckedRows()[0]; // 그리드1에서 선택된 행
	  var rowData = {
	    order_number: selectedRow.order_number // 그리드1에서 선택된 행의 order_number 값을 추가
	  };
	  grid2.appendRow(rowData);
	});
////////////////////////////////////////////////////	 
	
	
///////////////////////////////////////////////////////
//행 삭제
// 삭제실행
   $("#deleteRowBtn").click(function() {
      let d = confirm('삭제하시겠습니까?');
      if(d) {
    	  deleteRow();
      }else {
         return false;
      }
   });
// 삭제함수
   function deleteRow() {
      
      var rowKeys = grid.getCheckedRowKeys();  // 선택한 row의 key
      var jsonRowKeys = JSON.stringify(rowKeys);  // 실제값으로 가공 --> 선택한 row의 key(index)를  JSON 문자배열로 반환
      
      var rowDatas = grid.getCheckedRows();   // 선택한 row에 해당하는 객체값
      var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환

      grid.removeCheckedRows([jsonRowKeys]);

      $.ajax({
         url : "<%=request.getContextPath()%>/orderDelete",
         method : "post",
         data : jsonRowDatas,
         contentType : "application/json; charset=utf-8",  // 전송 데이터타입.  application/json로 설정해야 JSON을 처리할수있는 HTTP메세지컨버터가 실행된다
         dataType: "json",         // 서버에서 받을 데이터타입
         success : function (result) {
            alert('성공');
         },
         error: function() {
              console.log("실패");
          }
      });
   }
   
//상세 삭제 실행
   $("#deleteDetail").click(function() {
      let d = confirm('삭제하시겠습니까?');
      if(d) {
    	  deleteDetail();
      }else {
         return false;
      }
   });
// 상세 삭제 함수
   function deleteDetail() {
      
      var rowKeys = grid2.getCheckedRowKeys();  // 선택한 row의 key
      var jsonRowKeys = JSON.stringify(rowKeys);  // 실제값으로 가공 --> 선택한 row의 key(index)를  JSON 문자배열로 반환
      
      var rowDatas = grid2.getCheckedRows();   // 선택한 row에 해당하는 객체값
      var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환

      grid2.removeCheckedRows([jsonRowKeys]);

      $.ajax({
         url : "<%=request.getContextPath()%>/orderDelete2",
         method : "post",
         data : jsonRowDatas,
         contentType : "application/json; charset=utf-8",  // 전송 데이터타입.  application/json로 설정해야 JSON을 처리할수있는 HTTP메세지컨버터가 실행된다
         dataType: "json",         // 서버에서 받을 데이터타입
         success : function (result) {
            alert('성공');
         },
         error: function() {
              console.log("실패");
          }
      });
   }
///////////////////////////////////////////////////////////////
	//상태수정실행
	$("#updateStatus").click(function() {
		let a = confirm('수주 상태를 변경 하시겠습니까?');
		if(a) {
			UpdateRow();
		}else {
			return false;
		}
	});

// 상태수정함수
   function UpdateRow() {
      
      var rowKeys = grid.getCheckedRowKeys();  // 선택한 row의 key
      var jsonRowKeys = JSON.stringify(rowKeys);  // 실제값으로 가공 --> 선택한 row의 key(index)를  JSON 문자배열로 반환
      
      var rowDatas = grid.getCheckedRows();   // 선택한 row에 해당하는 객체값
      var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환


      $.ajax({
         url : "<%=request.getContextPath()%>/orderUpdateStatus",
         method : "post",
         data : jsonRowDatas,
         contentType : "application/json; charset=utf-8",  // 전송 데이터타입.  application/json로 설정해야 JSON을 처리할수있는 HTTP메세지컨버터가 실행된다
         dataType: "json",         // 서버에서 받을 데이터타입
         success : function (result) {
            alert('성공');
         },
         error: function() {
              console.log("실패");
          }
      });
   }
/////////////////////////////////////////////////////////	

	
///////////////////////////////////////////////////////////////////////////////////////
   // 등록 
   $("#InsertBtn").click(function() {
      let i = confirm('등록하시겠습니까?');
      if(i) {
         addBtn();
      }else {
         return false;
      }
   });
  

	
   // 등록 진행
   function addBtn() {

      var rowDatas = grid.getCheckedRows();   // 선택한 row에 해당하는 객체값
      var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환
      
      $.ajax({
         url : "<%=request.getContextPath()%>/orderInsert",
         method : "POST",
         data : jsonRowDatas,
         contentType : "application/json; charset=utf-8",  // 전송 데이터타입.  application/json로 설정해야 JSON을 처리할수있는 HTTP메세지컨버터가 실행된다
         dataType: "json",         // 서버에서 받을 데이터타입
         success : function (response) {
            alert('성공');
         },
         error: function() {
              console.log("실패");
          }
      });
   }
   
   $("#InsertBtn2").on("click", function() {
	   var selectedRows = grid2.getCheckedRows();
	   if (selectedRows.length === 0) {
	     alert("등록할 데이터를 선택해주세요.");
	     return;
	   }
	   var rowData = grid2.getCheckedRows(selectedRows[0]);
	   var jsonData = JSON.stringify(rowData);
	    
	   $.ajax({
	     url: "<%=request.getContextPath()%>/orderInsert2",
	     method: "POST",
	     data: jsonData,
	     contentType: "application/json; charset=utf-8",
	     dataType: "json",
	     success: function(response) {
	       alert("성공");
	     },
	     error: function() {
	       console.log("실패");
	     }
	   });
	 });
  
///////////////////////////////////////////////////////   
   //수정진행
   	// 데이터 수정
	$("#updateRow").click(function() {
		let a = confirm('수정 하시겠습니까?');
		if(a) {
			updateFunction();
		}else {
			return false;
		}
	});
	
	// 데이터 수정함수
	function updateFunction() {

		var rowDatas = grid.getCheckedRows();	// 선택한 row에 해당하는 객체값
		var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환

		$.ajax({
			url : "<%=request.getContextPath()%>/orderUpdate",
			method : "patch",
			data : jsonRowDatas,
			contentType : "application/json; charset=utf-8",  // 전송 데이터타입.  application/json로 설정해야 JSON을 처리할수있는 HTTP메세지컨버터가 실행된다
			dataType: "json",			// 서버에서 받을 데이터타입
			success : function (result) {
				alert('데이터 수정성공');
			},
			error: function() {
		        console.log("실패");
		    }
		});
	}
	
	//상세 데이터 수정 실행
	$("#updateDetail").click(function() {
		let a = confirm('수정 하시겠습니까?');
		if(a) {
			updateDetail();
		}else {
			return false;
		}
	});
	
	
	
	//상세 데이터 수정함수
	function updateDetail() {

		var rowDatas = grid2.getCheckedRows();	// 선택한 row에 해당하는 객체값
		var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환
		$.ajax({
			url : "<%=request.getContextPath()%>/orderUpdate2",
			method : "patch",
			data : jsonRowDatas,
			contentType : "application/json; charset=utf-8",  // 전송 데이터타입.  application/json로 설정해야 JSON을 처리할수있는 HTTP메세지컨버터가 실행된다
			dataType: "json",			// 서버에서 받을 데이터타입
			success : function (result) {
				alert('데이터 수정성공');
			},
			error: function() {
		        console.log("실패");
		    }
		});
	}
////////////////////////////////////////////////////////////////////////////////////////
// 체크박스 클릭시 검색창에 PK, FK값 출력
   grid.on('check', function(ev) {
      
      const rowKey = ev.rowKey;
      const columnName = ev.columnName;
      var updatedData = {};
      const rowData = grid.getRow(rowKey);
      console.log('Row data: ', rowData);
      
		var order_number = document.getElementById("order_number");   // 수주번호
		var order_type = document.getElementById("order_type");   // 수주유형
		var client_code = document.getElementById("client_code");   	// 거래처코드
		var order_status = document.getElementById("order_status");   		// 수주상태
      
      var rowDatas = grid.getCheckedRows();   // 선택한 row에 해당하는 객체값
      var jsonRowDatas = JSON.stringify(rowDatas);   // 선택한 row에 해당하는 객체를 JSON 문자배열로 반환
      
      $.ajax({
          url : "<%=request.getContextPath()%>/orderDetail",
          method : "post",
          data : jsonRowDatas,
          dataType : "json",
          contentType : "application/json; charset=utf-8",
          success : function (result) {
             console.dir('result : ' + result);
             console.log(result);
             grid2.resetData(result);  // result를 배열로 받는다
          }
       });
      
      if(rowDatas.length==1){

    	  order_number.value=rowData.order_number;
    	  order_number.readOnly=true;
			

    	  client_code.value=rowData.client_code;
    	  client_code.readOnly=true;
			
    	  order_type.value=rowData.order_type;
    	  order_type.readOnly=true;
			
    	  order_status.value=rowData.order_status;
    	  order_status.readOnly=true;
      }
    });
    
    //체크박스 해제시 실행
   grid.on('uncheck', function(ev) {
	   const rowKey = ev.rowKey;
	   const rowData = grid.getRow(rowKey);

	   // 그리드2에서 체크된 행들 중에서, 현재 해제된 행의 키 값에 해당하는 행만 삭제함
	   grid2.removeRow(rowKey);

	   // 그리드에서 체크된 행들의 키 값을 가져옴
	   var checkedRowKeys = grid.getCheckedRowKeys();

	   // 현재 해제된 행의 키 값을 제외하고 남은 행들만 모아서 배열로 만듦
	   var remainingRowKeys = checkedRowKeys.filter(function(key) {
	     return key !== rowKey;
	   });

	   // 그리드2에서 체크된 행들 중에서, 현재 해제된 행의 키 값에 해당하지 않는 행들만 남김
	   var remainingRows = grid2.getData().filter(function(row) {
	     return remainingRowKeys.includes(row.rowKey);
	   });

	   // 그리드2에서 남은 행들만 보여주도록 함
	   grid2.resetData(remainingRows);
	 });
///////////////////////////////////////////////////////////////////////////////	
		//아이템코드를 더블클릭해서 정보조회하기
		var contextPath = '<%= request.getContextPath() %>';
    grid2.on('dblclick', function(ev) {
        if (ev.columnName === 'item_code') {
            window.open(contextPath + '/orderForm', 'childWindow', 'width=500,height=500');
        }
    });
    grid.on('dblclick', function(ev) {
        if (ev.columnName === 'client_code') {
            window.open(contextPath + '/orderForm2', 'childWindow', 'width=500,height=500');
        }
    });
	
	//아이템 관련 정보창에서 전달한 값을 컬럼에 넣기
    window.addEventListener('message', function(ev) {
        const selectedRow = ev.data;
        const focusedCell = grid2.getFocusedCell();
        grid2.setValue(focusedCell.rowKey, 'item_code', selectedRow.item_code);
        grid2.setValue(focusedCell.rowKey, 'price', selectedRow.sales_price);
        grid2.setValue(focusedCell.rowKey, 'item_st_unit', selectedRow.item_stock_unit); 
       });
	
	//거래처 관련 정보창에서 전달한 값을 컬럼에 넣기
	window.addEventListener('message', function(ev) {
        const selectedRow = ev.data;
        if(selectedRow.type=="REQUEST"){
        const focusedCell = grid.getFocusedCell();
        grid.setValue(focusedCell.rowKey, 'client_code', selectedRow.client_code);
        }
    });
});


//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
</script>

<script>


</script>

</body>
</html>
