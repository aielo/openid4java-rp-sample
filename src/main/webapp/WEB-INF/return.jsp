<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/includes/head.jsp">
	<c:param name="title" value="Auth Request"/>
</c:import>
<body>
	<c:import url="/WEB-INF/includes/header.jsp" />
	<div class="container" role="main">
		<c:if test="${not empty error}">
			<h1>Error</h1>
			<c:out value="${error}" />
			<h3>Return URL</h3>
			<c:out value="${info.return_url}" />
			<br />
			<h3>Return parameters</h3>
			<c:forEach var="p" items="${info.return_parameters}">
				<c:out value="${p.key}" />: <c:out value="${p.value}" />
				<br />
			</c:forEach>

		</c:if>

		<c:if test="${empty error}">
			<h1>Auth Response</h1>
			<h3>id:</h3> <c:out value="${info.id}" />
			<br />
			<h3>verified:</h3> <c:out value="${info.verified}" />
			<br />
			<h3>Return parameters</h3>
			<c:forEach var="p" items="${info.return_parameters}">
				<c:out value="${p.key}" />: <c:out value="${p.value}" />
				<br />
			</c:forEach>
		</c:if>
	</div>
	<c:import url="/WEB-INF/includes/footer.jsp" />
</body>
</html>
