<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<div class="container">
    <div style="max-width: 600px; margin: 2rem auto; border: 1px solid #e2e8f0; border-radius: var(--radius); overflow: hidden; background: white; box-shadow: var(--shadow);">
        <div style="background: var(--primary); color: white; padding: 1.5rem; text-align: center;">
            <h2 style="margin: 0;">📦 Hóa Đơn Thanh Toán</h2>
        </div>
        <div style="padding: 2.5rem;">
            <div style="margin-bottom: 2rem; border-bottom: 1px dashed #cbd5e1; padding-bottom: 1.5rem;">
                <h3 style="margin-bottom: 1rem; color: #1e293b;">${event.title}</h3>
                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; color: var(--secondary);">
                    <span>Ngày diễn ra:</span>
                    <span>${event.eventDate}</span>
                </div>
            </div>
            
            <div style="margin-bottom: 2rem;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem;">
                    <span>Đơn giá:</span>
                    <span>${event.price}đ</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem;">
                    <span>Số lượng:</span>
                    <span style="font-weight: 600;">x${quantity}</span>
                </div>
                <div style="display: flex; justify-content: space-between; padding-top: 1rem; border-top: 2px solid #f1f5f9; margin-top: 0.5rem;">
                    <span style="font-size: 1.2rem; font-weight: 700;">Tổng cộng:</span>
                    <span style="font-size: 1.5rem; font-weight: 700; color: var(--primary);">${total}đ</span>
                </div>
            </div>

            <form action="booking" method="POST">
                <input type="hidden" name="eventId" value="${event.eventId}">
                <input type="hidden" name="quantity" value="${quantity}">
                <input type="hidden" name="total" value="${total}">
                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1.25rem; font-size: 1.1rem; border-radius: 8px;">Xác Nhận Thanh Toán</button>
            </form>
            
            <c:if test="${not empty error}">
                <p style="color: #ef4444; margin-top: 1rem; text-align: center;">${error}</p>
            </c:if>
            
            <p style="text-align: center; margin-top: 1.5rem; font-size: 0.85rem; color: var(--secondary);">Bằng việc ấn nút, bạn đồng ý với các điều khoản của chúng tôi.</p>
        </div>
    </div>
</div>
</body>
</html>
