<%@ page import="org.motus.log.LoginLog" %>



<div class="fieldcontain ${hasErrors(bean: loginLogInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="loginLog.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${org.motus.Account.list()}" optionKey="id" required="" value="${loginLogInstance?.account?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loginLogInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="loginLog.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${loginLogInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loginLogInstance, field: 'ipAddress', 'error')} ">
	<label for="ipAddress">
		<g:message code="loginLog.ipAddress.label" default="Ip Address" />
		
	</label>
	<g:textField name="ipAddress" value="${loginLogInstance?.ipAddress}"/>
</div>

