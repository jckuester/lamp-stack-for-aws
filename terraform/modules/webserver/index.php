<html>
<head>
<title>Terraform example project: LAMP Stack in AWS</title>
</head>

<body>
<div style="position: absolute; left: 50%; margin-left: -400px; width:800px; background: white; border: 2px solid black">
<center>
<h2>Terraform example project: LAMP Stack in AWS</h2>

<?php

/*
DISCLAIMER
Don't judge this php code, it's ugly and I know it; but
it does its job for this demo.
*/

$servername = "${db_server_address}";
$username = "lamp";
$password = "lamp1234";
$db = "lamp";

// Create connection
$conn = new mysqli($servername, $username, $password, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
print 'Connected successfully to DB.';

// sql to create table
$sql = "CREATE TABLE lamp (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sometext VARCHAR(50),
    reg_date TIMESTAMP
)";

if ($conn->query($sql) === TRUE) {
    echo "Table  created successfully!";
}

print '<form action="index.php" method="post">
Some text: <input type="text" name="sometext"><br>
<input type="submit">
</form>';

if(isset($_POST['sometext'])) {

    $sql = "INSERT INTO lamp (sometext) VALUES ('" . $_POST['sometext'] . "')";

    if ($conn->query($sql) === TRUE) {
        echo "New record '" . $_POST['sometext'] . "' created successfully! <br><br>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    header("Location: index.php");
    exit();
}

$sql = "SELECT id, sometext FROM lamp";
$result = $conn->query($sql);

print "<table border=1>
  <tr>
    <th>ID</th>
    <th>Some text</th>
  </tr>";

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row["id"]. "</td><td>" . $row["sometext"] . "</td></tr>";
    }
} else {
    echo "0 results";
}

print "</table>";

$conn->close();
?>

<br><br>
</center>
</div>
</body>
</html>
