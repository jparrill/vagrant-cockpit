node default {
	if $virtual == "virtualbox" and $fqdn == '' {
  		$fqdn = 'localhost'
	}

	Package { allow_virtual => true }

	include vagrant_cockpit
}
