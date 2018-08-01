<html>
<head>
<title>Terraform example project: LAMP Stack in AWS</title>
</head>

<body style="background-color: gray">
<div id="container">
<div style="margin:0 auto; text-align:center; width:1200px; height: 650px; background: white; border: 2px solid black">
<h1 style="font-size: 4em">Terraform example project</h1>
<h2 style="font-size: 2em">LAMP Stack in AWS</h2>
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

$conn = new mysqli($servername, $username, $password, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "CREATE TABLE lamp (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sometext VARCHAR(50),
    reg_date TIMESTAMP
)";
if ($conn->query($sql) === TRUE) {
    echo "Table created successfully!";
}

print '<form action="index.php" method="post">
<input type="text" name="sometext" placeholder="Add some text ...">
<input class="button" type="submit">
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

print "<table>
  <tr>
    <th>Some text</th>
  </tr>";

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row["sometext"] . "</td></tr>";
    }
} else {
    echo "0 results";
}

print "</table>";

$conn->close();
?>

<br><br>
</div>
</div>
</body>

<style>
table {
    border-collapse: collapse;
    margin: 0 auto;
}

table, th, td {
    border: 1px solid black;
    padding: 10px;
}

th {
    background-color: lightgray; /* Green */
}

.button {
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 12px 30px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 4px;
}

input[type=text], select {
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

#container {
    position: absolute;
    top: 50%;
    margin-top: -325px;
    /* half of #content height*/
    left: 0;
    width: 100%;
}

</style>
</html>
