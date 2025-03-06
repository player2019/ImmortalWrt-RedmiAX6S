{#
 Copyright 2022 Jo-Philipp Wich <jo@mein.io>
 Licensed to the public under the Apache License 2.0.
-#}

{% include('header', { blank_page: true }) %}

<section hidden>
	<form method="post" class="cbi-map">
	<h3 name="machinetype">路由器型号：Xiaomi Redmi Router AX6S</h3>
		<div class="cbi-section">
			<div class="cbi-section-node">
				<div class="cbi-value">
					<label class="cbi-value-title" for="luci_username">{{ _('Username') }}</label>
					<div class="cbi-value-field">
						<input name="luci_username" id="luci_username" type="text" autocomplete="username" value="{{ entityencode(duser, true) }}">
					</div>
				</div>
				<div class="cbi-value">
					<label class="cbi-value-title" for="luci_password">{{ _('Password') }}</label>
					<div class="cbi-value-field">
						<input name="luci_password" id="luci_password" type="password" autocomplete="current-password">
					</div>
				</div>
			</div>
		</div>
	</form>

	<hr>

	{% if (fuser): %}
	<div class="alert-message error">
		{{ _('Invalid username and/or password! Please try again.') }}
	</div>
	{% endif %}

	<button class="btn cbi-button-positive important">{{ _('Log in') }}</button>
</section>

<div id="view">
	<div class="spinning">{{ _('Loading view…') }}</div>
	<script>
		L.require('ui').then(function(ui) {
			ui.instantiateView('bootstrap.sysauth');
		});
	</script>
</div>

{% include('footer', { blank_page: true }) %}
