package authServlets;

import authDAO.UserDAO;
import auth.User;
import com.javaclass.PasswordEncrypt;
import com.javaclass.Email;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        int roleId = Integer.parseInt(req.getParameter("role"));

        String hashedPwd = PasswordEncrypt.hashPassword(password);

        User u = new User();
        u.setFullname(fullname);
        u.setUsername(username.trim());
        u.setEmail(email.trim());
        u.setPassword(hashedPwd);
        u.setPhone(phone);
        u.setRoleId(roleId);

        // ✅ Set status: admin ACTIVE, normal users PENDING
        if (roleId == 1) {
            u.setStatus("ACTIVE");
        } else {
            u.setStatus("PENDING");
        }

        UserDAO dao = new UserDAO();
        String result = dao.register(u);

        if ("ok".equals(result)) {
            if (roleId == 2) {
                // send verification email only for normal users
                int token = new Random().nextInt(999999);
                dao.saveVerificationToken(email, token);

                String verifyLink = req.getScheme() + "://" + req.getServerName() + ":" +
                        req.getServerPort() + req.getContextPath() +
                        "/VerifyAccountServlet?email=" + email + "&token=" + token;

                String subject = "Verify Your Account";
                String body = "Hello " + fullname + ",\n\nClick the link below to verify your account:\n"
                        + verifyLink + "\n\nThank you!";

                new Thread(new Email(email, subject, body)).start();

                resp.sendRedirect(req.getContextPath() +
                        "/Authentication/login.jsp?msg=Registered! Check your email to verify.");
            } else {
                // ✅ Admin goes straight to login
                resp.sendRedirect(req.getContextPath() +
                        "/Authentication/login.jsp?msg=Admin Registered Successfully! Please login.");
            }
        } else if ("duplicate-username".equals(result)) {
            resp.sendRedirect(req.getContextPath() +
                    "/Authentication/register.jsp?msg=Username already exists");
        } else if ("duplicate-email".equals(result)) {
            resp.sendRedirect(req.getContextPath() +
                    "/Authentication/register.jsp?msg=Email already exists");
        } else {
            resp.sendRedirect(req.getContextPath() +
                    "/Authentication/register.jsp?msg=Registration failed");
        }
    }
}
