<%@ page import="org.motus.Account" %>

<style type="text/css">
label{
	margin-right:10px;
	text-align:right;
}
</style>





<div class="form-group">
	<label for="name" class="col-sm-3 control-label">
		<g:message code="account.name.label" default="Name" />
	</label>
	<g:textField name="name" value="${accountInstance?.name}" class="form-control" style="width:250px"/>
</div>



<div class="form-group">
	<label for="age" class="col-sm-3 control-label">
		<g:message code="account.age.label" default="Age" />
	</label>
	<g:field name="age" type="number" value="${accountInstance.age}" class="form-control" style="width:60px;"/>
</div>



<div class="form-group">
	<label for="location" class="col-sm-3 control-label">
		<g:message code="account.location.label" default="Location" />
	</label>
	<g:field type="location" name="location" value="${accountInstance?.location}" class="form-control" style="width:250px" placeholder="eg: Fairbanks, AK"/>
</div>



<div class="form-group">
	<label for="email" class="col-sm-3 control-label">
		<g:message code="account.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${accountInstance?.email}" class="form-control" style="width:250px"/>
</div>


<div class="form-group">
	<label for="phone" class="col-sm-3 control-label">
		Phone <span style="font-size:11px; color:#777; font-weight:normal;">(optional)</span>
	</label>
	<g:field type="phone" name="phone" value="${accountInstance?.phone}" class="form-control" style="width:225px" placeholder="(000) 000000"/>
</div>


<table style="margin:10px auto;">
	<tr>
		<td style="text-align:right">
			<label>Competition Emails</label> 
		</td>
		<td style="text-align:left">
			<div class="btn-group">
			  <button type="button" data-value="true" class="btn btn-default btn-sm motivate-email-btn">On</button>
			  <button type="button" data-value="false" class="btn btn-default btn-sm motivate-email-btn">Off</button>
			</div>
			<input type="hidden" name="motivateEmail" id="motivateEmail" value="${accountInstance.motivateEmail}" />
		</td>
	</tr>
	<tr><td colspan="2" style="height:10px"></td></tr>
	<tr>
		<td style="text-align:right">
			<label for="name">Competition Texts</label>
		</td>
		<td style="text-align:left">
			<div class="btn-group">
			  <button type="button" data-value="true" class="btn btn-default btn-sm motivate-text-btn">On</button>
			  <button type="button" data-value="false" class="btn btn-default btn-sm motivate-text-btn">Off</button>
			</div>
			<input type="hidden" name="motivateText" id="motivateText" value="${accountInstance.motivateText}" />	
		</td>
	</tr>
</table>
<br/>


<!--
<div class="form-group">
	<label for="name" class="col-sm-3 control-label">
		<g:message code="account.name.label" default="Private Profile" />
	</label>
	<g:checkBox name="privateProfile" value="${accountInstance.privateProfile}" />
</div>
-->


	
<script type="text/javascript">	
$(document).ready(function(){
	
	var $motivateEmailBtn = $('.motivate-email-btn'),
		$motivateTextBtn = $('.motivate-text-btn');
		
	var $motivateEmailInput = $('#motivateEmail'),
		$motivateTextInput = $('#motivateText');
		
	
	$motivateEmailBtn.click(toggleMotivateEmail)
	$motivateTextBtn.click(toggleMotivateText)
	checkSetMotivateText();
	checkSetMotivateEmail();
	
	
	
	function toggleMotivateText(event){
		var $target = $(event.target)
		if(!$target.hasClass('active')){
			$motivateTextBtn.removeClass('active')
			$target.addClass('active');
			var value = $target.data('value')
			$motivateTextInput.val(value);
			updateBtnClass($($motivateTextBtn[0]), $($motivateTextBtn[1]))
		}
	}
	
	function toggleMotivateEmail(event){
		var $target = $(event.target)
		if(!$target.hasClass('active')){
			$motivateEmailBtn.removeClass('active')
			$target.addClass('active')
			var value = $target.data('value')
			$motivateEmailInput.val(value);
			updateBtnClass($($motivateEmailBtn[0]), $($motivateEmailBtn[1]))
		}
	}
	
	
	
	function checkSetMotivateText(){
		$motivateTextBtn.removeClass('active')
		var value = $motivateTextInput.val()
		if(value == "true"){
			$($motivateTextBtn[0]).addClass('active')
		}else{
			$($motivateTextBtn[1]).addClass('active')
		}
		updateBtnClass($($motivateTextBtn[0]), $($motivateTextBtn[1]))
	}
	
	function checkSetMotivateEmail(){
		$motivateEmailBtn.removeClass('active')
		var value = $motivateEmailInput.val()
		if(value == "true"){
			$($motivateEmailBtn[0]).addClass('active')
		}else{
			$($motivateEmailBtn[1]).addClass('active')
		}
		updateBtnClass($($motivateEmailBtn[0]), $($motivateEmailBtn[1]))
	}	
	
	
	function updateBtnClass($on, $off){

		$off.removeClass('btn-default').removeClass('btn-danger')
		$on.removeClass('btn-default').removeClass('btn-success');
		
		if($on.hasClass('active')){
			$off.addClass('btn-default');
			$on.addClass('btn-success');
		}
		
		if($off.hasClass('active')){
			$on.addClass('btn-default')
			$off.addClass('btn-danger');
		}
	}
		

});
</script>	


