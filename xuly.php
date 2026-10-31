<?php
session_start();
require_once 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (empty($username) || empty($password)) {
        echo "<script>alert('Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!'); window.history.back();</script>";
        exit();
    }

    try {
        $stmt = $conn->prepare("SELECT * FROM users WHERE username = :username");
        // Dùng array() thay cho [] để tương thích mọi phiên bản PHP và tránh lỗi ký tự ẩn
        $stmt->execute(array('username' => $username));
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        // Kiểm tra tài khoản và mật khẩu
        if ($user && $password === $user['password']) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['hoten'] = $user['hoten'];
            $_SESSION['role'] = $user['role'];

            // Điều hướng phân quyền dựa vào role
            switch ($user['role']) {
                case 'canbo':
                    header("Location: HTML/trangchucanbo.html");
                    break;
                case 'thuky':
                    header("Location: HTML/trangchuthuky.html");
                    break;
                case 'thisinh':
                    header("Location: HTML/trangchu.html");
                    break;
                case 'admin':
                    header("Location: HTML/xt.html");
                    break;
                default:
                    header("Location: HTML/dangnhap.php");
            }
            exit();
        } else {
            echo "<script>alert('Tên đăng nhập hoặc mật khẩu không chính xác!'); window.history.back();</script>";
        }
    } catch (PDOException $e) {
        echo "Lỗi hệ thống: " . $e->getMessage();
    }
}
?>