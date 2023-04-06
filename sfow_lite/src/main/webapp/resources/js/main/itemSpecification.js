$(document).ready(window.onload=function() {
   
    const Grid = tui.Grid;
    const grid = new Grid({    
		
        el: document.getElementById('grid'),
        scrollX: true,
        scrollY: true,
       
        rowHeaders: [
	      { type: 'rowNum', align: 'center'},
    	  { type: 'checkbox' }
        ],
        columns: [
          {
            header: '규격',
            name: 'item_specification',
            editor:'text'
          }
        ]
      });
  
      Array.prototype.forEach.call(document.querySelectorAll('#addRow'), el => {
			      el.addEventListener('click', ev => {
			             
 					const rowData = [{}]
					 					
					grid.appendRow(rowData, {
  					at: grid.getRowCount(),
  					focus: true,
  					useViewMode: true,
						});
 					});
    				grid.enable();
    			}); //addRow끝
    			 
     $.ajax({
        url : './item/specificationListAjax',
        method :'GET',
        dataType : 'JSON',
        success : function(result){
            grid.resetData(result);
        
             } //success끝 
          }); //ajax(/item/typeAjax)끝
     
     grid.on('check', function(ev) {	
	      
		const rowKey = ev.rowKey;
     	const columnName = ev.columnName;
     	const rowData = grid.getRow(rowKey);
			//console.log('check!', ev);
			//console.log('check!', rowData);
			
     Array.prototype.forEach.call(document.querySelectorAll('#insertRow'), el => {
		      el.addEventListener('click', ev => {

				$.ajax({
	                 url: './item/specificationInsert',
	                 method :'POST',
	                 dataType: 'JSON',
	                 data: JSON.stringify(rowData),
	                 contentType: 'application/json',
	                 success: function(response) {
	                     console.log('Success:', response);
	                     location.href="javascript:acyncMovePage('./item/specificationList');"
	                 	},
	                 error: function(error) {
	                     console.log('Error:', error);
	                     location.href="javascript:acyncMovePage('./item/specificationList');"
	                 	}
	             }); //ajax(/item/typeInsertAjax)끝
	          }); //addEventListener끝
	    	}); //insertRow 끝
	}); //grid.on('check')끝
     
				grid.on('click', function(ev) {
					
					const rowKey = ev.rowKey;
	            	const columnName = ev.columnName;
	            	const rowData = grid.getRow(rowKey);
	            	
	            	$('input[name=item_specification]').attr('value',rowData.item_specification);
				});
				
				 Array.prototype.forEach.call(document.querySelectorAll('#searchBtn'), el => {   
		           	 el.addEventListener('click', ev => {
		           		 
		           var item_specification = $("#search_area input[name='item_specification']").val();
		           		           
		           console.log('item_specification:', item_specification);
		           
		           $.ajax({
		       		type: 'POST',
		       		dataType: 'JSON',
		       		url: './item/specificationSearchAjax',
		       		contentType: 'application/json',
		       	    data: JSON.stringify({	
		       	    	"item_specification": item_specification
		       	        }),
		       		success: function(data) {
		       			 gridData=data
		       	         grid.resetData(data)      
		               	},
		               error: function(error) {
		                   console.log('Error:', error);
		               	}
		           });	         
		           	 });
		           });			
	
		 
  }); //window.onload끝