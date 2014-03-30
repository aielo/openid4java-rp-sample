package openid4java.sample.rp.servlet;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import openid4java.sample.rp.helper.ConsumerManagerProvider;

import org.openid4java.consumer.ConsumerManager;
import org.openid4java.consumer.VerificationResult;
import org.openid4java.discovery.DiscoveryInformation;
import org.openid4java.discovery.Identifier;
import org.openid4java.message.ParameterList;

@WebServlet(name="return", displayName="return", urlPatterns={"/return"}, loadOnStartup=1)
public class OpenIDReturnServlet extends HttpServlet {

	private static final long serialVersionUID = -2886666363853721825L;
	private ConsumerManager cm = ConsumerManagerProvider.getConsumerManager();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		// auth response info
		Map<Object, Object> ri = new HashMap<Object, Object>();

		// requested URL
		String url = req.getRequestURL().toString();

		// parameter map
		Map<String, String> pm = new HashMap<String, String>();
		for (String p : req.getParameterMap().keySet()) {
			if (req.getParameterMap().get(p).length == 1) {
				pm.put(p, req.getParameterMap().get(p)[0]);
			} else {
				pm.put(p, Arrays.toString(req.getParameterMap().get(p)));
			}
		}

		// view info
		ri.put("return_url", url);
		ri.put("return_parameters", pm);
		req.setAttribute("info", ri);

		try {
			DiscoveryInformation di = (DiscoveryInformation) req.getSession().getAttribute("openid4java-rp-sample.discovery");
			VerificationResult vr = cm.verify(url, new ParameterList(req.getParameterMap()), di);
			Identifier i = vr.getVerifiedId();
			ri.put("verified", i != null);
			if (i != null) {
				ri.put("id", i.getIdentifier());
			}
			ri.put("return_parameters", vr.getAuthResponse().getParameterMap());

			// reseting session
			req.getSession().removeAttribute("openid4java-rp-sample.discovery");

		} catch (Throwable t) {
			// view error
			req.setAttribute("error", t.getMessage());
		}

		// show view
		req.getRequestDispatcher("WEB-INF/return.jsp").forward(req, res);
	}
}
