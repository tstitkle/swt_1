<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
    .success-actions { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
    @media (max-width: 576px) {
        .success-actions .btn { width: 100%; }
    }
</style>
<div class="container" style="text-align: center; padding: 5rem 0;">
    <div style="background: white; max-width: 500px; margin: 0 auto; padding: 3rem; border-radius: var(--radius); box-shadow: var(--shadow);">
        <div style="font-size: 4rem; margin-bottom: 1.5rem;">✅</div>
        <h2 style="margin-bottom: 1rem;">Thanh Toán Thành Công!</h2>
        <p style="color: var(--secondary); margin-bottom: 2.5rem;">Cảm ơn bạn đã tin tưởng dịch vụ của EventTick. Vé của bạn đã được lưu vào hệ thống.</p>
        <div class="success-actions">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline" style="padding: 0.8rem 1.5rem;">Về Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-primary" style="padding: 0.8rem 1.5rem;">Lịch Sử Đặt Vé</a>
        </div>
    </div>
</div>
</body>
</html>
