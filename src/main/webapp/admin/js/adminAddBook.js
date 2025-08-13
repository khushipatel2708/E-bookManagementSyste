//$(document).ready(function () {
//    $("#addBook").on("submit", function (event) {
//        event.preventDefault();
//        var form = $("#addBook")[0];
//        var formData = new FormData(form);
//
//        $.ajax({
//            url: "../AdminBookAddServlet",
//            type: "POST",
//            data: formData,
//            contentType: false,
//            processData: false,
//            success: function (data) {
//                if (data.trim() === "done") {
//                    showToast("Book Details added successfully!", "success");
//
//                    // Optional: Reset form
//                    $("#bookName").val("");
//                    $("#authorName").val("");
//                    $("#price").val("");
//                    $("#totalBook").val("");
//                    $("#category").val("new");
//                    $("#photo").val("");
//                    $("#previewImage").hide();
//
//                    // Redirect to adminPanel.jsp after 2 seconds
//                    setTimeout(function () {
//                        window.location.href = "http://localhost:8080/E-bookManagementSyste/admin/adminPanel.jsp";
//                    }, 3000);
//
//                } else {
//                    showToast("Something went wrong.", "error");
//                }
//            },
//            error: function () {
//                showToast("Something went wrong, please try again later.", "error");
//            }
//        });
//    });
//
//    // Preview uploaded image
//    $("#photo").on("change", function () {
//        const [file] = this.files;
//        if (file) {
//            $("#previewImage").attr("src", URL.createObjectURL(file)).show();
//        }
//    });
//
//    // Toast function
//    function showToast(message, type) {
//        const toastEl = document.getElementById("liveToast");
//        const toastBody = document.getElementById("toastBody");
//
//        if (type === "success") {
//            toastEl.classList.remove("bg-danger");
//            toastEl.classList.add("bg-success");
//        } else {
//            toastEl.classList.remove("bg-success");
//            toastEl.classList.add("bg-danger");
//        }
//
//        toastBody.innerHTML = message;
//        const toast = new bootstrap.Toast(toastEl);
//        toast.show();
//    }
//});

$(document).ready(function () {
    $("#addBook").on("submit", function (event) {
        event.preventDefault();
        var form = $("#addBook")[0];
        var formData = new FormData(form);

        $.ajax({
            url: "../AdminBookAddServlet",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.trim() === "done") {
                    showToast("Book Details added successfully!", "success");

                    // Reset form
                    $("#addBook")[0].reset();
                    $("#previewImage").hide();

                    // Redirect after 2 seconds
                    setTimeout(function () {
                        window.location.href = "http://localhost:8080/E-bookManagementSyste/admin/adminAllBook.jsp";
                    }, 4000);
                } else {
                    showToast("Something went wrong while saving.", "danger");
                }
            },
            error: function () {
                showToast("Something went wrong, please try again later.", "danger");
            }
        });
    });

    // Preview image
    $("#photo").on("change", function () {
        const [file] = this.files;
        if (file) {
            $("#previewImage").attr("src", URL.createObjectURL(file)).show();
        }
    });

    // Toast function
    function showToast(message, type) {
        const toastEl = document.getElementById("liveToast");
        const toastBody = document.getElementById("toastBody");

        toastBody.innerText = message;

        // Adjust background based on type
        toastEl.classList.remove("bg-success", "bg-danger");
        toastEl.classList.add(type === "success" ? "bg-success" : "bg-danger");

        const toast = new bootstrap.Toast(toastEl);
        toast.show();
    }
});
