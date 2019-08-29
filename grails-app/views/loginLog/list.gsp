
<%@ page import="org.motus.log.LoginLog" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loginLog.label', default: 'LoginLog')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-loginLog" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-loginLog" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="loginLog.account.label" default="Account" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'loginLog.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="ipAddress" title="${message(code: 'loginLog.ipAddress.label', default: 'Ip Address')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${loginLogInstanceList}" status="i" var="loginLogInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${loginLogInstance.id}">${fieldValue(bean: loginLogInstance, field: "account")}</g:link></td>
					
						<td><g:formatDate date="${loginLogInstance.date}" /></td>
					
						<td>${fieldValue(bean: loginLogInstance, field: "ipAddress")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${loginLogInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
