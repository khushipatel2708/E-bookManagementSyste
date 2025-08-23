package authServlets;

import authDAO.UserDAO;
import auth.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/VerifyAccountServlet")
public class VerifyAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String tokenStr = request.getParameter("token");

        if (email != null && tokenStr != null) {
            try {
                int token = Integer.parseInt(tokenStr);

                UserDAO dao = new UserDAO();
                boolean verified = dao.verifyUser(email, token);

                if (verified) {
                    // fetch updated user
                    User u = dao.getUserByEmail(email);

                    if (u != null) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("userObj", u);

                        // ✅ Save display name in session
                        session.setAttribute("userName",
                            (u.getFullname() != null && !u.getFullname().trim().isEmpty())
                                ? u.getFullname()
                                : u.getUsername()
                        );

                        response.sendRedirect(request.getContextPath() +
                                "/index.jsp?msg=Account Verified! Welcome " + session.getAttribute("userName"));
                        return;
                    }
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/index.jsp?msg=Invalid verification link!");
    }
}
