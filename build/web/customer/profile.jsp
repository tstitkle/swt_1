<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<div class="container">
    <div style="max-width: 600px; margin: 0 auto; background: white; padding: 2.5rem; border-radius: var(--radius); box-shadow: var(--shadow);">
        <h2 style="margin-bottom: 2rem;">Thông Tin Cá Nhân</h2>
        <c:if test="${not empty msg}">
            <p style="color: #10b981; margin-bottom: 1rem;">${msg}</p>
        </c:if>
        <form action="profile" method="POST">
            <div style="margin-bottom: 1.5rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Tên đăng nhập</label>
                <input type="text" value="${sessionScope.user.username}" disabled style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1; background: #f1f5f9;">
            </div>
            <div style="margin-bottom: 1.5rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Họ và tên</label>
                <input type="text" name="fullName" value="${sessionScope.user.fullName}" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
            </div>
            <div style="margin-bottom: 2rem;">
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 600;">Email</label>
                <input type="email" name="email" value="${sessionScope.user.email}" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.8rem;">Cập Nhật Thông Tin</button>
        </form>
    </div>
</div>
</body>
</html>
