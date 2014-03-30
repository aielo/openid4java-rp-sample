<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<head>
		<meta charset="utf-8">
		<meta name="author" content="Ricardo Aielo">
		<title>Auth Request Information - OpenID RP Sample</title>
	</head>
	<body>
		<c:if test="${not empty error}">
			<h1>Error</h1>
			<c:out value="${error}" />
		</c:if>

		<c:if test="${empty error}">
			<h1>Auth Request</h1>
			<h3>POST URL:</h3> <c:out value="${info.post_url}" />
			<br />
			<h3>POST parameters</h3>
			<c:forEach var="p" items="${info.post_parameters}">
				<c:out value="${p.key}" />: <c:out value="${p.value}" />
				<br />
			</c:forEach>
			<h3>Redirect URL:</h3> <c:out value="${info.redirect_url}" />
			<br />
			<h3>Meta</h3>
			<c:forEach var="m" items="${info.meta}">
				<c:out value="${m.key}" />: <c:out value="${m.value}" />
				<br />
			</c:forEach>
		</c:if>
	</body>
</html>
