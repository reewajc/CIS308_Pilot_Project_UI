// $('#registrationform').submit(function (event) {
//     event.preventDefault();
// }
function drop(){
 // make a post request to adminDB.jsp to drop users and PRODUCT_REGISTRATION
 $.post("adminDB.jsp",
 {
   adminAction: "drop"
 },
 function(data, status){
     if (status == "success") {
         $('#dropText').text("Tables Dropped!");
     }else {
         $('#dropText').text("Tables Not Dropped!" + status);
     }
 });
}

function create(){
    // create the users and PRODUCT_REGISTRATION tables
    // insert rows into both
    $.post("adminDB.jsp",
    {
      adminAction: "create"
    },
    function(data, status){
        if (status == "success") {
            $('#createText').text("Tables Created!");
        }else {
            $('#createText').text("Tables Not Created!" + status);
        }
    });
}

function getUsers(){
    // select * on USERS
    $.post("adminDB.jsp",
    {
      adminAction: "getUsers"
    },
    function(data, status){
        if (status == "success") {
            $('#usersText').text(data);
        }else {
            $('#usersText').text(status);
        }
    });
}

function getProducts(){
    // select * on PRODUCT_REGISTRATION productsText
    $.post("adminDB.jsp",
    {
      adminAction: "getProducts"
    },
    function(data, status){
        if (status == "success") {
            $('#productsText').text(data);
        }else {
            $('#productsText').text(status);
        }
    });
}

function stolen(){
    var number = $('#stolenNumber').val();

    $.post("http://localhost:7070/CIS308_Pilot_Project_UI/ReportStolen",
    {
      adminAction: "stolen",
      num: number
    },
    function(data, status){
        if (status == "success") {
            $('#stolenText').text(data);
        }else {
            $('#stolenText').text(status);
        }
    });
}

function register(){
    var email1 = $('#email').val();
    var first1 = $('#first_name').val();
    var last1 = $('#last_name').val();
    var item1 = $('#product_name').val();
    var model1 = $('#product_model').val();
    var num1 = $('#serial_number').val();
    var date1 = $('#purchased_date').val();

    $.post("http://localhost:7070/CIS308_Pilot_Project_UI/RegisterProuct",
    {
      adminAction: "register",
      email: email1,
      first: first1,
      last: last1,
      item: item1,
      model: model1,
      num: num1,
      date: date1
    },
    function(data, status){
        if (status == "success") {
            $('#registerText').text(data);
        }else {
            $('#registerText').text(status);
        }
    });

}

function firmware(){
    document.getElementById('my_iframe').src = "http://localhost:7070/CIS308_Pilot_Project_UI/firmware.exe";

}
