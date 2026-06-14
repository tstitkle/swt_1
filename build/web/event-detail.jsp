<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<style>
    .event-detail-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 3rem; margin-top: 2rem; }
    .event-cover {
        height: 400px;
        background-image: url('https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=1200&q=80');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        border-radius: var(--radius);
        margin-bottom: 2rem;
    }
    .event-meta { display: flex; gap: 1rem; margin-bottom: 2rem; flex-wrap: wrap; }
    .booking-box { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); position: sticky; top: 100px; }
    @media (max-width: 992px) {
        .event-detail-grid { grid-template-columns: 1fr; gap: 2rem; }
        .event-cover { height: 260px; }
        .booking-box { position: static; }
    }
</style>
<div class="container">
    <div class="event-detail-grid">
        <div>
            <div class="event-cover"></div>
            <h1 style="margin-bottom: 1rem;">${event.title}</h1>
            <div class="event-meta">
                <span style="padding: 0.5rem 1rem; background: #e0e7ff; color: var(--primary); border-radius: 8px; font-weight: 600;">📅 ${event.eventDate}</span>
                <span style="padding: 0.5rem 1rem; background: #fef3c7; color: #92400e; border-radius: 8px; font-weight: 600;">📍 ${venue.venueName}</span>
            </div>
            <div style="line-height: 1.8; color: var(--secondary);">
                <h3>Mô tả sự kiện</h3>
                <p style="margin-top: 1rem;">${event.description}</p>
            </div>
        </div>
        
        <div>
            <div class="booking-box">
                <h3 style="margin-bottom: 1.5rem;">Đặt Vé Ngay</h3>
                <c:if test="${not empty error}">
                    <p style="color: #ef4444; margin-bottom: 1rem; font-size: 0.92rem;">${error}</p>
                </c:if>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem;">
                    <span>Giá vé:</span>
                    <span style="font-weight: 700; color: var(--primary); font-size: 1.5rem;">${event.price}đ</span>
                </div>
                <form action="booking" method="GET">
                    <input type="hidden" name="id" value="${event.eventId}">
                    <div style="margin-bottom: 2rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-size: 0.9rem;">Số lượng</label>
                        <input type="number" name="quantity" value="1" min="1" style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #cbd5e1;">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; font-size: 1.1rem;">Mua Vé</button>
                </form>
                <p style="margin-top: 1.5rem; font-size: 0.85rem; color: var(--secondary); text-align: center;">📍 ${venue.address}</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
