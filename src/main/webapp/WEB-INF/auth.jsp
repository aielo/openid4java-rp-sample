<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/includes/head.jsp">
	<c:param name="title" value="Auth Request"/>
</c:import>
<body>
	<c:import url="/WEB-INF/includes/header.jsp" />
	<div class="container" role="main">
		<div id="openid-auth-request" class="row">
			<div class="page-header">
				<h1>Authorization Request</h1>
			</div>
			<div class="col-xs-6">
				<div class="jumbotron">
					<form class="form-horizontal" action="/openid4java-rp-sample/auth" method="GET">
						<fieldset>
							<legend>Redirect <small>(URL redirect)</small></legend>
							<div class="form-group">
								<label for="textAreaRedirectURL" class="col-xs-2 control-label">URL</label>
								<div class="col-xs-10">
									<textarea id="textAreaRedirectURL" name="redirect_url" class="form-control" rows="10" style="resize: none;"><c:out value="${info.redirect_url}" /></textarea>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-10 col-xs-offset-2">
									<a id="openid-provider-cancel" href="/openid4java-rp-sample/" class="btn btn-default">Cancel</a>
									<button id="btn-oar-redirect" type="button" class="btn btn-primary">Redirect</button>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="jumbotron">
					<form class="form-horizontal" action="${info.post_url}" method="POST">
						<fieldset>
							<legend>Form submission <small>(POST)</small></legend>
							<div class="form-group">
								<label for="inputURL" class="col-xs-2 control-label">URL</label>
								<div class="col-xs-10">
									<input name="id" type="text" class="form-control" id="inputURL" value="<c:out value="${info.post_url}" />" />
								</div>
							</div>
							<c:forEach var="p" items="${info.post_parameters}" varStatus = "st">
								<div class="form-group">
									<c:if test="${st.first }">
										<label for="inputParams" class="col-xs-2 control-label">Parameters</label>
										<div class="col-xs-5">
											<input name="input_<c:out value="${p.key}" />" type="text" class="form-control" value="<c:out value="${p.key}" />" />
										</div>
									</c:if>
									<c:if test="${!st.first }">
										<div class="col-xs-5 col-xs-offset-2">
											<input name="input_<c:out value="${p.key}" />" type="text" class="form-control" value="<c:out value="${p.key}" />"/>
										</div>
									</c:if>
									<div class="col-xs-5">
										<input name="<c:out value="${p.key}" />" type="text" class="form-control" value="<c:out value="${p.value}" />" />
									</div>
								</div>
							</c:forEach>
							<div class="form-group">
								<div class="col-xs-10 col-xs-offset-2">
									<button id="openid-provider-cancel" type="button" class="btn btn-default">Cancel</button>
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>


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
	</div>
	<c:import url="/WEB-INF/includes/footer.jsp" />
	<script type="text/javascript">
		$(document).ready(function () {
			$('#btn-oar-redirect').click(function () {
				window.location = $('#openid-auth-request [name="redirect_url"]').val();
			});
		});
	</script>
</body>
</html>
