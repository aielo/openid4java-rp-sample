package openid4java.sample.rp.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.openid4java.consumer.ConsumerManager;
import org.openid4java.discovery.DiscoveryInformation;

@WebServlet(name="auth", displayName="auth", urlPatterns={"/auth"}, loadOnStartup=1)
public class AuthRequestServlet extends HttpServlet {

	private static final long serialVersionUID = 1145439673629279324L;
	private ConsumerManager cm = new ConsumerManager();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// Discovery
			DiscoveryInformation discoveryInformation = cm.associate(cm.discover(req.getParameter("identifier")));
			req.getSession().setAttribute("discovery", discoveryInformation);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
}

