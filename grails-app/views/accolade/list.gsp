
<%@ page import="org.motus.Accolade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accolade.label', default: 'Accolade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-accolade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-accolade" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${raw(flash.message)}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="type" title="${message(code: 'accolade.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="points" title="${message(code: 'accolade.points.label', default: 'Points')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'accolade.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'accolade.dateCreated.label', default: 'Date Created')}" />
					
						<th><g:message code="accolade.account.label" default="Account" /></th>
					
						<th><g:message code="accolade.week.label" default="Week" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${accoladeInstanceList}" status="i" var="accoladeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${accoladeInstance.id}">${fieldValue(bean: accoladeInstance, field: "type")}</g:link></td>
					
						<td>${fieldValue(bean: accoladeInstance, field: "points")}</td>
					
						<td>${fieldValue(bean: accoladeInstance, field: "description")}</td>
					
						<td><g:formatDate date="${accoladeInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: accoladeInstance, field: "account")}</td>
					
						<td>${fieldValue(bean: accoladeInstance, field: "week")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${accoladeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
