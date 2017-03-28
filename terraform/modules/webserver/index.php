<html>
<head>
<title>LAMP Stack Reloaded: An AWS example</title>
</head>

<body>
<h1>LAMP Stack Reloaded: An AWS example</h1>

<?php
$servername = "${db_server_address}";
$username = "lamp";
$password = "lamp1234";
$db = "lamp";

// Create connection
$conn = new mysqli($servername, $username, $password, $db);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
print "Connected successfully to " . $servername . "!<br>";

// sql to create table
$sql = "CREATE TABLE Lamp2 (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
sometext VARCHAR(50),
reg_date TIMESTAMP
)";

if ($conn->query($sql) === TRUE) {
    echo "Table  created successfully!";
} else {
    //echo "Error creating table: " . $conn->error . "<br>";
}

$value = "Bla";
$sql = "INSERT INTO Lamp2 (sometext) VALUES ('" . $value . "')";

if ($conn->query($sql) === TRUE) {
    echo "New record '" . $value . "' created successfully! <br><br>";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$sql = "SELECT id, sometext FROM Lamp2";
$result = $conn->query($sql);

print "<table border=1>
  <tr>
    <th>ID</th>
    <th>Some text</th>
  </tr>";

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row["id"]. "</td><td>" . $row["sometext"] . "</td></tr>";
    }
} else {
    echo "0 results";
}

print "</table>";

$conn->close();
?>
</body>

</html>
