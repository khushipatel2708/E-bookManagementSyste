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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        String hashedPwd = PasswordEncrypt.hashPassword(password);
        UserDAO dao = new UserDAO();
        User u = dao.loginAnyStatus(email, hashedPwd);

        String contextPath = req.getContextPath();

        if (u != null) {
            HttpSession session = req.getSession(true);

            // Store full User object
            session.setAttribute("userObj", u);

            // Store display name for navbar
            session.setAttribute("email",
                (u.getFullname() != null && !u.getFullname().trim().isEmpty())
                    ? u.getFullname()
                    : u.getEmail()
            );

            // Admin role → go to admin panel
            if (u.getRoleId() == 1) {
                resp.sendRedirect(contextPath + "/admin/adminPanel.jsp");
                return;
            }

            // Normal user PENDING → send verification email
            if ("PENDING".equalsIgnoreCase(u.getStatus())) {
                if (!dao.isTokenExists(u.getEmail())) {
                    int token = new Random().nextInt(900000) + 100000;
                    dao.saveVerificationToken(u.getEmail(), token);

                    String verifyLink = req.getScheme() + "://" + req.getServerName() + ":" +
                            req.getServerPort() + contextPath +
                            "/VerifyAccountServlet?email=" + u.getEmail() + "&token=" + token;

                    String subject = "Verify Your Account";
                    String body = "Hello " + session.getAttribute("email") + ",\n\n" +
                            "Click the link below to verify your account:\n" +
                            verifyLink + "\n\nThank you!";

                    new Thread(new Email(u.getEmail(), subject, body)).start();
                }

                resp.sendRedirect(contextPath + "/index.jsp?msg=Account pending! Check your email.");
                return;
            }

            // Normal ACTIVE user → go to homepage
            resp.sendRedirect(contextPath + "/index.jsp");

        } else {
            resp.sendRedirect(contextPath + "/index.jsp?msg=Invalid Email/Password");
        }
    }
}
