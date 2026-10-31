<?php
$conn = new mysqli("localhost", "root", "", "quanlytuyensinh10");

if ($conn->connect_error) {
    die("Lỗi kết nối database: " . $conn->connect_error);
}

$conn->set_charset("utf8");

?>