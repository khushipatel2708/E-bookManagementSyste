<!DOCTYPE html>
<html>
<head>
    <title>PayU Payment</title>
</head>
<body>
    <h2>Online Payment</h2>
    <form action="PayUServlet" method="post">
        <input type="text" name="firstname" placeholder="First Name" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="text" name="phone" placeholder="Phone" required><br>
        <input type="text" name="amount" placeholder="Amount" required><br>
        <input type="submit" value="Pay Now">
    </form>
</body>
</html>
