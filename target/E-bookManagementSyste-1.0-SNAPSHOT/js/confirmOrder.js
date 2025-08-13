/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function paymentMethod() {
    $("#tableInfo").hide();
    $("#paymentMethod").show();
}

function confirmOrder() {
    var paymentMethod = $("#pMethod").val();

//    if (paymentMethod === "online") {
//       window.location.href = "payment.jsp?pMethod=online";
//    } 
if (paymentMethod === "online") {
        // ✅ Pass total price and user data to the payment.jsp page
        window.location.href = `payment.jsp?pMethod=online&amount=${totalOrderPrice}&name=${encodeURIComponent(userName)}&email=${encodeURIComponent(userEmail)}`;
    $.ajax({
            url: "UserConfirmOrderServlet?pMethod=" + paymentMethod,
            method: "post",
            success: function (data) {
                if (data.trim() === "done") {
                    $("#tableInfo").hide();
                    $("#paymentMethod").hide();

                    $.ajax({
                        url: "UserTotalCartServlet",
                        method: "get",
                        success: function (data) {
                            $("#navbarTotalCart").html(data.trim());
                        },
                        error: function () {
                            alert("Something went wrong!");
                        }
                    });
                } else if (data.trim() === "verify") {
                    alert("Please verify your email...");
                } else {
                    alert("Something went wrong!");
                }
            },
            error: function () {
                alert("Something went wrong!");
            }
        });
    }
    else {
        $.ajax({
            url: "UserConfirmOrderServlet?pMethod=" + paymentMethod,
            method: "post",
            success: function (data) {
                if (data.trim() === "done") {
                    $("#tableInfo").hide();
                    $("#paymentMethod").hide();
                    $("#thanksForOrder").show();

                    $.ajax({
                        url: "UserTotalCartServlet",
                        method: "get",
                        success: function (data) {
                            $("#navbarTotalCart").html(data.trim());
                        },
                        error: function () {
                            alert("Something went wrong!");
                        }
                    });
                } else if (data.trim() === "verify") {
                    alert("Please verify your email...");
                } else {
                    alert("Something went wrong!");
                }
            },
            error: function () {
                alert("Something went wrong!");
            }
        });
    }
}

