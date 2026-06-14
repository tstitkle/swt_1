<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
    <div style="background: white; padding: 2.5rem; border-radius: var(--radius); box-shadow: var(--shadow); width: 100%; max-width: 450px;">
        <h2 style="text-align: center; margin-bottom: 2rem;">Đăng Ký Tài Khoản</h2>
        <form action="register" method="POST">
            <c:if test="${not empty error}">
                <p style="color: #ef4444; margin-bottom: 1rem; text-align: center; font-size: 0.9rem;">${error}</p>
            </c:if>
            <div style="margin-bottom: 1.25rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Tên đăng nhập</label>
                <input type="text" name="username" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
            </div>
            <div style="margin-bottom: 1.25rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Mật khẩu</label>
                <input type="password" name="password" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
            </div>
            <div style="margin-bottom: 1.25rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Họ và tên</label>
                <input type="text" name="fullName" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
            </div>
            <div style="margin-bottom: 1.5rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Email</label>
                <input type="email" name="email" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.8rem; margin-bottom: 1rem;">Đăng Ký</button>
            <p style="text-align: center; font-size: 0.9rem;">Đã có tài khoản? <a href="login.jsp" style="color: var(--primary); text-decoration: none; font-weight: 600;">Đăng nhập ngay</a></p>
        </form>
    </div>
</div>
</body>
</html>
