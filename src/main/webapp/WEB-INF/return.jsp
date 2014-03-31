<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/includes/head.jsp">
	<c:param name="title" value="Auth Request"/>
</c:import>
<body>
	<c:import url="/WEB-INF/includes/header.jsp" />
	<div class="container" role="main">
		<div id="openid-auth-response" class="row">
			<div class="page-header">
				<h1>Authorization Response</h1>
			</div>
			<c:if test="${!empty error}">
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<strong>Error:</strong> <c:out value="${error}" />
				</div>
			</c:if>
			<c:if test="${!info.verified}">
				<div class="alert alert-warning alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<strong>Warning:</strong> OpenID identity verification failed!
				</div>
			</c:if>
			<c:if test="${info.verified}">
				<div class="alert alert-success alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<strong>Success:</strong> OpenID identity verified!
				</div>
			</c:if>
			<div class="col-xs-12">
				<div class="jumbotron">
					<form id="form-oar-summary" class="form-horizontal" action="#">
						<fieldset>
							<legend>Summary</legend>
							<div class="form-group">
								<label class="col-xs-2 control-label">ID</label>
								<div class="col-xs-10">
									<input type="text" class="form-control" disabled value="<c:out value="${info.id ? info.id : 'unable to retrieve'}" />">
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label">Verified</label>
								<div class="col-xs-10">
									<input type="text" class="form-control" disabled value="<c:out value="${info.verified ? true : false}" />">
								</div>
							</div>
							<c:forEach var="p" items="${info.return_parameters}" varStatus = "st">
								<div class="form-group">
									<c:if test="${st.first }">
										<label for="inputParams" class="col-xs-2 control-label">Parameters</label>
										<div class="col-xs-5">
											<input name="key_<c:out value="${p.key}" />" type="text" class="form-control" disabled value="<c:out value="${p.key}" />" />
										</div>
									</c:if>
									<c:if test="${!st.first }">
										<div class="col-xs-5 col-xs-offset-2">
											<input name="key_<c:out value="${p.key}" />" type="text" class="form-control" disabled value="<c:out value="${p.key}" />"/>
										</div>
									</c:if>
									<div class="col-xs-5">
										<input name="value_<c:out value="${p.key}" />" type="text" class="form-control" disabled value="<c:out value="${p.value}" />" />
									</div>
								</div>
							</c:forEach>
							<div class="form-group">
								<div class="col-xs-10 col-xs-offset-2">
									<a id="btn-oar-back" href="/openid4java-rp-sample/" class="btn btn-default">Back</a>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/includes/footer.jsp" />
</body>
</html>
