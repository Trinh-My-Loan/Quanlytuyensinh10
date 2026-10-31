<?php
$host = 'localhost';
$dbname = 'ql_tuyensinh10';
$username = 'root';
$password = ''; // Mật khẩu XAMPP/WAMP mặc định thường trống

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Kết nối cơ sở dữ liệu thất bại: " . $e->getMessage());
}
?>