<html>
<head>
<title>
Macintosh Garden FTP Search
</title>
</head>
<body>
<h1>Macintosh Garden FTP Search</h1>
<a href="about.php">Learn bout this service.</a>
<hr>
<p><form>
<b>Search for </b><input type="text" name="search">
<input type="submit" value=" Search ">
</form>
<?php

if (!isset($_GET["search"])) {
    echo "</body>\n</html>\n";
    exit();
}

$searchfor = $_GET["search"];

$file = 'garden.txt';
$contents = file_get_contents($file);

// escape special characters in the query
$pattern = preg_quote($searchfor, '/');
$pattern = str_replace(' ', '.', $pattern);

// finalise the regular expression, matching the whole line
$pattern = "/^.*$pattern.*\$/im";

if (preg_match_all($pattern, $contents, $matches))
{
   echo "<h2>Found " . count($matches[0]) . " matches for \"" . $searchfor . "\"</h2>\n";
	foreach ($matches[0] as $file) {
		echo '<a href="ftp://macgarden:publicdl@repo1.macintoshgarden.org';
		echo $file . '">'. $file . "</a><br>\n";
	}
}
else
{
   echo "<h2>No matches for \"" . $searchfor . "\"</h2>\n";
}
?>
</body>
</html>

