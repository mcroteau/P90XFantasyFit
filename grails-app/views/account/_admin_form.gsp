<%@ page import="org.motus.Account" %>



<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="account.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${accountInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'age', 'error')} required">
	<label for="age">
		<g:message code="account.age.label" default="Age" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="age" type="number" value="${accountInstance.age}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'ipAddress', 'error')} ">
	<label for="ipAddress">
		<g:message code="account.ipAddress.label" default="Ip Address" />
		
	</label>
	<g:textField name="ipAddress" value="${accountInstance?.ipAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="account.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${accountInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="account.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${accountInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="account.password.label" default="Password Hash" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${accountInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'permissions', 'error')} ">
	<label for="permissions">
		<g:message code="account.permissions.label" default="Permissions" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'roles', 'error')} ">
	<label for="roles">
		<g:message code="account.roles.label" default="Roles" />
		
	</label>
	<g:select name="roles" from="${org.motus.Role.list()}" multiple="multiple" optionKey="id" size="5" value="${accountInstance?.roles*.id}" class="many-to-many"/>
</div>

