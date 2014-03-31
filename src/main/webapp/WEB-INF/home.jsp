<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/includes/head.jsp">
	<c:param name="title" value="Home"/>
</c:import>
<body>
	<c:import url="/WEB-INF/includes/header.jsp" />
	<div class="container" role="main">
		<div id="welcome" class="row">
			<div class="jumbotron">
				<h2>An <a href="http://openid.net/">OpenID</a> RP example, build with <a href="https://code.google.com/p/openid4java/">openid4java</a></h2>
				<p>This sample intends to demonstrate a basic OpenID authentication from Relying Party (RP) point of view. It uses openid4java libraries on top of pure JEE Servlet 3, focusing simplicity.</p>
				<p><a id="btn-welcome-ack" class="btn btn-primary btn-lg" role="button">Try it out!</a></p>
			</div>
		</div>
		<div id="openid-provider" class="row hidden">
			<div class="page-header">
				<h1>OpenID Provider <small>(OP)</small></h1>
			</div>
			<div class="jumbotron">
				<form class="form-horizontal" action="/openid4java-rp-sample/auth" method="POST">
					<fieldset>
						<legend>Identification</legend>
						<div class="form-group">
							<label for="inputIdentifier" class="col-xs-2 control-label">Identifier</label>
							<div class="col-xs-10">
								<input name="id" type="text" class="form-control" id="inputIdentifier" placeholder="https://www.google.com/accounts/o8/id">
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-2 control-label">Immediate action</label>
							<div class="col-xs-10">
								<div class="radio">
									<label>
										<input type="radio" name="action"  value="none" checked>
										None (choose later)
									</label>
								</div>
								<div class="radio">
									<label>
										<input type="radio" name="action" value="redirect">
										Server-side redirect
									</label>
								</div>
								<div class="radio">
									<label>
										<input type="radio" name="action" value="form">
										Client-side form submission
									</label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-10 col-xs-offset-2">
								<a id="btn-op-cancel" href="/openid4java-rp-sample/" class="btn btn-default">Cancel</a>
								<button type="submit" class="btn btn-primary">Submit</button>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/includes/footer.jsp" />
	<script type="text/javascript">
		$(document).ready(function () {
			$('#btn-welcome-ack').click(function () {
				$('#welcome').addClass('hidden');
				$('#openid-provider').removeClass('hidden');
			});
			$('#btn-op-cancel').click(function () {
				$('#welcome').removeClass('hidden');
				$('#openid-provider').addClass('hidden');
			});
			$('#openid-provider form').validate({
				rules: {
					id: {
						required: true,
						url: true
					},
					action: {
						required: true
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
				}
			});
		});
	</script>
</body>
</html>
