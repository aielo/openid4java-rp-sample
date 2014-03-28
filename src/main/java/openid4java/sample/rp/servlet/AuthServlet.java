package openid4java.sample.rp.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.openid4java.consumer.ConsumerManager;
import org.openid4java.discovery.DiscoveryInformation;
import org.openid4java.message.AuthRequest;

import com.google.gson.Gson;

@WebServlet(name="auth", displayName="auth", urlPatterns={"/auth"}, loadOnStartup=1)
public class AuthServlet extends HttpServlet {

	private static final long serialVersionUID = -6951091489143426313L;
	private ConsumerManager cm = new ConsumerManager();
	private Gson gson = new Gson();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Map<Object, Object> output = new HashMap<Object, Object>();
		try {
			// input validation
			String id = req.getParameter("id");
			if (id == null){
				throw new RuntimeException("OpenID Provider (OP) id is required");
			}

			// discovery
			DiscoveryInformation di = cm.associate(cm.discover(req.getParameter("id")));
			req.getSession().setAttribute("discovery_information", di);

			// auth request
			AuthRequest ar = cm.authenticate(di, "http://ava.universidade.uol.com.br:8080/openid4java-rp-sample/return");
			String redirect = ar.getDestinationUrl(true);
			output.put("destination", ar.getDestinationUrl(false));
			output.put("parameters", ar.getParameterMap());
			output.put("redirect", redirect);
			output.put("redirect_size", redirect.length());
			output.put("post_support", false);
			output.put("post_required", redirect.length() > 2048);
			if (di.isVersion2()) {
				output.put("post_support", true);
			}

		} catch (Throwable t) {
			output.put("error", t.getMessage());
		}

		res.getWriter().write(gson.toJson(output));
	}
}
