package openid4java.sample.rp.servlet;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import openid4java.sample.rp.helper.ConsumerManagerProvider;

import org.openid4java.consumer.ConsumerManager;
import org.openid4java.discovery.DiscoveryInformation;
import org.openid4java.message.AuthRequest;

@WebServlet(name="auth", displayName="auth", urlPatterns={"/auth"}, loadOnStartup=1)
public class OpenIDAuthServlet extends HttpServlet {

	private static final long serialVersionUID = -6951091489143426313L;
	private ConsumerManager cm = ConsumerManagerProvider.getConsumerManager();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		// auth request info
		Map<Object, Object> ri = new LinkedHashMap<Object, Object>();

		// view info
		req.setAttribute("info", ri);

		try {
			// input validation
			String id = req.getParameter("id");
			if (id == null || "".equals(id)){
				throw new RuntimeException("OpenID Provider (OP) id is required");
			}

			// discovery
			DiscoveryInformation di = cm.associate(cm.discover(req.getParameter("id")));

			// auth request
			AuthRequest ar = cm.authenticate(di, req.getRequestURL().toString().replaceFirst("/auth", "/return"));
			String ru = ar.getDestinationUrl(true);
			Map<Object, Object> meta = new LinkedHashMap<Object, Object>();
			ri.put("post_url", ar.getDestinationUrl(false));
			ri.put("post_parameters", ar.getParameterMap());
			ri.put("redirect_url", ru);
			ri.put("meta", meta);
			meta.put("openid_version", di.isVersion2() ? 2 : 1);
			meta.put("post_support", di.isVersion2());
			meta.put("post_required", ru.length() > 2048);
			meta.put("redirect_size", ru.length());

			// storing session
			req.getSession().setAttribute("openid4java-rp-sample.discovery", di);

		} catch (Throwable t) {
			// view error
			req.setAttribute("error", t.getMessage());
		}

		// show view
		req.getRequestDispatcher("WEB-INF/auth.jsp").forward(req, res);
	}
}
