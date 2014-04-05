<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/includes/head.jsp">
	<c:param name="title" value="Auth Request"/>
</c:import>
<body>
	<c:import url="/WEB-INF/includes/header.jsp" />
	<div class="container hidden" role="main">
		<div id="openid-auth-request" class="row">
			<div class="page-header hidden">
				<h1>OpenID Request</h1>
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
						<form id="form-oar" class="form-horizontal" action="/openid4java-rp-sample/auth" method="POST">
							<fieldset>
								<legend>Make the OpenID Request</legend>
								<div class="form-group">
									<label for="inputURL" class="col-xs-2 control-label">Path</label>
									<div class="col-xs-10">
										<input name="path" type="text" class="form-control" id="inputPath" value="${info.path}" />
									</div>
								</div>
								<c:forEach var="p" items="${info.parameters}" varStatus = "st">
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
									<div style="border-bottom: 1px solid #e5e5e5;"></div>
								</div>
								<div class="form-group">
									<div class="col-xs-10 col-xs-offset-2">
										<input name="auto_submit" type="hidden" value="${info.meta.auto_submit}" />
										<a id="btn-oar-request-cancel" href="/openid4java-rp-sample/" class="btn btn-default">Cancel</a>
										<button id="btn-oar-request-submit" type="submit" class="btn btn-primary">Submit form</button>
										<button id="btn-oar-request-redirect" type="submit" class="btn btn-primary">Redirect</button>
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
									<div style="border-bottom: 1px solid #e5e5e5;"></div>
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
			// GET selection
			$('#btn-oar-request-redirect').on('click', function() {
				$('#form-oar').attr('method', 'GET');
			});
			// POST selection
			$('#btn-oar-request-submit').on('click', function() {
				$('#form-oar').attr('method', 'POST');
			});
			// Validation and submission/redirect
			$('#form-oar').on('submit', function() {
				event.preventDefault();
			}).validate({
				rules: {
					path: {
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
					var method = $('#form-oar').attr('method');
					form.action = $('#form-oar [name="path"]').val();
					$('#form-oar input').each(function () {
						// rename value fields and remove key fields
						if ($(this).attr('name') && $(this).attr('name').indexOf('value_') == 0) {
							var name = $(this).attr('name').substr(6);
							$(this).attr('name', $('#form-oar input[name="key_' + name + '"]').val());
							// "removing fields" (keeping inputs avoid layout effects)
							$('#form-oar input[name="key_' + name + '"]').removeAttr('name');
						}
					});
					// "remove" path and auto_submit parameters, it should not be submitted
					$('#form-oar input[name="path"]').removeAttr('name');
					$('#form-oar input[name="auto_submit"]').removeAttr('name');
					if (method === 'POST') {
						// POST form
						form.submit();
					} else {
						// send redirect
						var parameters = [];
						$('#form-oar input').each(function () {
							// ignore "removed" fields
							if ($(this).attr('name')) {
								parameters.push($(this).attr('name') + '=' + $(this).val());
							}
						});
						window.location = form.action + '?' + parameters.join('&');
					}
				}
			});
			if ($('#form-oar input[name="auto_submit"]').val() === 'true'){
				$('#form-oar').submit();
			} else {
				$(".container").removeClass('hidden');
			}
		});
	</script>
</body>
</html>
