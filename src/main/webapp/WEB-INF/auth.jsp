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
			<c:if test="${!empty error}">
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<strong>Error:</strong> Unable to locate OpenID Provider
				</div>
			</c:if>
			<c:if test="${empty error}">
				<div class="col-xs-12">
					<div class="jumbotron">
						<form id="form-oar-info" class="form-horizontal" action="#">
							<fieldset>
								<legend>OP Information</legend>
								<div class="form-group">
									<label class="col-xs-2 control-label">OpenID Version</label>
									<div class="col-xs-10">
										<input type="text" class="form-control" disabled value="${info.meta.openid_version}">
									</div>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="jumbotron">
						<form id="form-oar-redirect" class="form-horizontal" action="/openid4java-rp-sample/auth" method="GET">
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
										<a id="btn-oar-redirect-cancel" href="/openid4java-rp-sample/" class="btn btn-default">Cancel</a>
										<button type="submit" class="btn btn-primary">Redirect</button>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="jumbotron">
						<form id="form-oar-post" class="form-horizontal" action="${info.post_url}" method="POST">
							<fieldset>
								<legend>Form submission <small>(POST)</small></legend>
								<div class="form-group">
									<label for="inputURL" class="col-xs-2 control-label">URL</label>
									<div class="col-xs-10">
										<input name="post_url" type="text" class="form-control" id="inputURL" value="${info.post_url}" />
									</div>
								</div>
								<c:forEach var="p" items="${info.post_parameters}" varStatus = "st">
									<div class="form-group">
										<c:if test="${st.first }">
											<label for="inputParams" class="col-xs-2 control-label">Parameters</label>
											<div class="col-xs-5">
												<input name="key_${p.key}" type="text" class="form-control" value="${p.key}" />
											</div>
										</c:if>
										<c:if test="${!st.first }">
											<div class="col-xs-5 col-xs-offset-2">
												<input name="key_${p.key}" type="text" class="form-control" value="${p.key}" />
											</div>
										</c:if>
										<div class="col-xs-5">
											<input name="value_${p.key}" type="text" class="form-control" value="${p.value}" />
										</div>
									</div>
								</c:forEach>
								<div class="form-group">
									<div class="col-xs-10 col-xs-offset-2">
										<a id="btn-oar-post-cancel" href="/openid4java-rp-sample/" class="btn btn-default">Cancel</a>
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty error}">
				<div class="col-xs-12">
					<div class="jumbotron">
						<form id="form-oar-error" class="form-horizontal" action="#">
							<fieldset>
								<legend>Error summary</legend>
								<div class="form-group">
									<div class="col-xs-12">
										<c:out value="${error}" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-xs-12">
										<a id="btn-oar-error-back" href="/openid4java-rp-sample/" class="btn btn-primary">Back</a>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<c:import url="/WEB-INF/includes/footer.jsp" />
	<script type="text/javascript">
		$(document).ready(function () {
			$('#form-oar-redirect').submit(function(event) {
				event.preventDefault();
			}).validate({
				rules: {
					redirect_url: {
						required: true,
						url: true
					}
				},
				submitHandler: function(form) {
					window.location = $('#form-oar-redirect [name="redirect_url"]').val();
				}
			});
			$('#form-oar-post').submit(function(event) {
				event.preventDefault();
			}).validate({
				rules: {
					post_url: {
						required: true,
						url: true
					}
				},
				highlight: function(element) {
					$(element).closest('.form-group').addClass('has-error');
				},
				unhighlight: function(element) {
					$(element).closest('.form-group').removeClass('has-error');
				},
				errorPlacement: function(err, element) {
					return true;
				},
				submitHandler: function(form) {
					form.action = $('#form-oar-post [name="post_url"]').val();
					$('#form-oar-post input').each(function () {
						// rename value fields and remove key fields
						if ($(this).attr('name') && $(this).attr('name').indexOf('value_') == 0) {
							var name = $(this).attr('name').substr(6);
							$(this).attr('name', $('#form-oar-post input[name="key_' + name + '"]').val());
							$('#form-oar-post input[name="key_' + name + '"]').removeAttr('name');
						}
					});
					// change action to post URL
					form.action = $('#form-oar-post [name="post_url"]').val();
					$('#form-oar-post input[name="post_url"]').removeAttr('name');
					form.submit();
				}
			});
		});
	</script>
</body>
</html>
