<g:if test="${flash.message}">
	<div class="alert alert-info" role="status">${flash.message}</div>
</g:if>

<g:hasErrors bean="${plannedWorkout}">
	<div class="alert alert-danger" role="alert">
		<ul>
			<g:eachError bean="${plannedWorkout}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
					<g:message error="${error}"/>
				</li>
			</g:eachError>
		</ul>
	</div>
</g:hasErrors>