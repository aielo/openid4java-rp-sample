<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/includes/head.jsp">
	<c:param name="title" value="Home"/>
</c:import>
<body>
	<c:import url="/WEB-INF/includes/header.jsp" />
	<div class="container" role="main">
		<div class="jumbotron">
			<h2>An <a href="http://openid.net/">OpenID</a> RP example, build with <a href="https://code.google.com/p/openid4java/">openid4java</a></h2>
			<p>This sample intends to demonstrate a basic OpenID authentication from Relying Party (RP) point of view. It uses openid4java libraries on top of pure JEE Servlet 3, focusing simplicity.</p>
			<p><a id="start" class="btn btn-primary btn-lg" role="button">Try it out!</a></p>
		</div>
	</div>
	<c:import url="/WEB-INF/includes/footer.jsp" />
</body>
</html>
