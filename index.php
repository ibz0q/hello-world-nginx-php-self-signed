<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
</head>
<body>
    <h2>Hello World! (with Request Headers)</h2>

Client Request:
<pre>
<?php
class DumpHTTPRequest {
	public function execute() {
		$data = sprintf(
			$_SERVER['REQUEST_METHOD'],
			$_SERVER['REQUEST_URI'],
			$_SERVER['SERVER_PROTOCOL']
		);

		foreach ($this->getHeaderList() as $name => $value) {
			$data .= $name . ': ' . $value . "\n";
		}

		echo($data);
	}

	private function getHeaderList() {
		$headerList = [];
		foreach ($_SERVER as $name => $value) {
			if (preg_match('/^HTTP_/',$name)) {
				$name = strtr(substr($name,5),'_',' ');
				$name = ucwords(strtolower($name));
				$name = strtr($name,' ','-');
				$headerList[$name] = $value;
			}
		}

		return $headerList;
	}
}

(new DumpHTTPRequest)->execute();
?>
</pre>


Server Vars:
<pre>
<?php

print_r($_SERVER);

?>
</pre>

</body>
</html>