<?php
session_start();
// Gọi file kết nối db.php (Do file này nằm ở thư mục HTML/ nên phải lùi ra một cấp bằng ../db.php)
require_once '../db.php';

$error_message = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (empty($username) || empty($password)) {
        $error_message = "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!";
    } else {
        try {
            $stmt = $conn->prepare("SELECT * FROM users WHERE username = :username");
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
                        header("Location: trangchucanbo.html");
                        break;
                    case 'thuky':
                        header("Location: trangchuthuky.html");
                        break;
                    case 'thisinh':
                        header("Location: trangchu.html");
                        break;
                    case 'admin':
                        header("Location: xt.html");
                        break;
                    default:
                        header("Location: dangnhap.php");
                }
                exit();
            } else {
                $error_message = "Tên đăng nhập hoặc mật khẩu không chính xác!";
            }
        } catch (PDOException $e) {
            $error_message = "Lỗi hệ thống: " . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Tuyển sinh Lớp 10</title>
    <!-- Font Awesome & Google Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Đường dẫn CSS liên kết đúng cấu trúc thư mục -->
    <link rel="stylesheet" href="../CSS/dangnhap.css">
</head>
<body>

    <div class="login-container">
        <!-- Logo và Tiêu đề -->
        <div class="login-header">
            <div class="logo-circle">
                <i class="fa-solid fa-graduation-cap"></i>
            </div>
            <h2>Đăng Nhập Hệ Thống</h2>
            <p>Cổng quản lý tuyển sinh lớp 10 THPT</p>
        </div>

        <!-- Hiển thị thông báo lỗi nếu đăng nhập sai -->
        <?php if (!empty($error_message)): ?>
            <div style="background: #fee2e2; color: #991b1b; padding: 10px 14px; border-radius: 8px; font-size: 13px; margin-bottom: 15px; text-align: center; font-weight: 600;">
                <i class="fa-solid fa-circle-exclamation"></i> <?php echo $error_message; ?>
            </div>
        <?php endif; ?>

        <!-- Form Đăng nhập: Gửi dữ liệu trực tiếp về chính file này (để trống hoặc điền dangnhap.php) -->
        <form action="" method="POST">
            <!-- Tên đăng nhập / Số CCCD -->
            <div class="form-group">
                <label class="form-label" for="username">Tên đăng nhập / Số CCCD</label>
                <div class="input-wrap">
                    <i class="fa-regular fa-user input-icon"></i>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên đăng nhập của bạn" required>
                </div>
            </div>

            <!-- Mật khẩu -->
            <div class="form-group">
                <label class="form-label" for="password">Mật khẩu</label>
                <div class="input-wrap">
                    <i class="fa-regular fa-lock input-icon"></i>
                    <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                    <button type="button" class="toggle-password" onclick="togglePassword()">
                        <i class="fa-regular fa-eye" id="eye-icon"></i>
                    </button>
                </div>
            </div>

            <!-- Tùy chọn nhớ tài khoản & quên mật khẩu -->
            <div class="form-options">
                <label class="remember-me">
                    <input type="checkbox"> Ghi nhớ đăng nhập
                </label>
                <a href="#" class="forgot-pass">Quên mật khẩu?</a>
            </div>

            <!-- Nút bấm đăng nhập -->
            <button type="submit" class="btn-login">Đăng Nhập</button>
        </form>

        <!-- Quay về trang chủ -->
        <div class="back-home">
            <a href="trangchu.html"><i class="fa-solid fa-arrow-left"></i> Quay lại trang chủ tuyển sinh</a>
        </div>
    </div>

    <script>
        // Tính năng ẩn/hiện mật khẩu
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.className = 'fa-regular fa-eye-slash';
            } else {
                passwordInput.type = 'password';
                eyeIcon.className = 'fa-regular fa-eye';
            }
        }
    </script>
</body>
</html>