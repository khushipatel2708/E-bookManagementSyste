function deleteAccount() {
    Swal.fire({
        title: 'Are you sure?',
        text: "This action will permanently delete your account!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "<%= request.getContextPath() %>/DeleteAccountServlet",
                method: "POST",
                success: function(data) {
                    data = data.trim();
                    if (data === "done") {
                        Swal.fire('Deleted!', 'Your account has been deleted.', 'success')
                            .then(() => {
                                // Redirect to login page after deletion
                                window.location.href = "<%= request.getContextPath() %>/Authentication/login.jsp";
                            });
                    } else if (data === "no-session") {
                        Swal.fire('Error!', 'Session expired. Please login again.', 'error')
                            .then(() => {
                                window.location.href = "<%= request.getContextPath() %>/Authentication/login.jsp";
                            });
                    } else {
                        Swal.fire('Error!', 'Something went wrong while deleting your account.', 'error');
                    }
                },
                error: function() {
                    Swal.fire('Error!', 'Something went wrong with the request!', 'error');
                }
            });
        }
    });
}
