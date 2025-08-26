function addCart(bookId){
    $.ajax({
        url: "UserAddCartServlet",
        method: "POST",   // ✅ use POST
        data: { bookId: bookId },
        success: function(data){
            if(data.trim()==="login"){
                alert("Please login...");
            } else if(data.trim()==="done"){
                // Update cart count dynamically
                $.ajax({
                    url: "UserTotalCartServlet",
                    method: "GET",
                    success: function(data) {
                        $("#navbarTotalCart").html(data.trim());
                    },
                    error: function() {
                        alert("Something went wrong while updating cart count!");
                    }
                });
            }
        },
        error: function() {
            alert("Something went wrong!");
        }
    });
}

function addCart2(bookId){
    $.ajax({
        url: "UserAddCartServlet",
        method: "POST",   // ✅ use POST
        data: { bookId: bookId },
        success: function(data){
            if(data.trim()==="login"){
                alert("Please login...");
            } else if(data.trim()==="done"){
                location.href="./myCart.jsp"; // redirect only after success
            }
        },
        error: function() {
            alert("Something went wrong!");
        }
    });
}
