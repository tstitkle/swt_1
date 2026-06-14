<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
    .table-scroll { overflow-x: auto; }
    .booking-table { width: 100%; border-collapse: collapse; text-align: left; min-width: 760px; }
</style>
<div class="container">
    <h2 style="margin-bottom: 2rem;">Vé Đã Đặt</h2>
    <div style="background: white; border-radius: var(--radius); box-shadow: var(--shadow); overflow: hidden;">
        <div class="table-scroll">
        <table class="booking-table">
            <thead style="background: #f8fafc; border-bottom: 1px solid #e2e8f0;">
                <tr>
                    <th style="padding: 1rem 1.5rem;">Mã Đơn</th>
                    <th style="padding: 1rem 1.5rem;">Ngày Đặt</th>
                    <th style="padding: 1rem 1.5rem;">Tổng Tiền</th>
                    <th style="padding: 1rem 1.5rem;">Trạng Thái</th>
                    <th style="padding: 1rem 1.5rem;">Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${bookings}" var="b">
                    <tr style="border-bottom: 1px solid #f1f5f9;">
                        <td style="padding: 1rem 1.5rem;">#${b.bookingId}</td>
                        <td style="padding: 1rem 1.5rem;">${b.bookingDate}</td>
                        <td style="padding: 1rem 1.5rem; color: var(--primary); font-weight: 600;">${b.totalAmount}đ</td>
                        <td style="padding: 1rem 1.5rem;">
                            <span style="padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.8rem; background: #dcfce7; color: #166534;">${b.status}</span>
                        </td>
                        <td style="padding: 1rem 1.5rem;">
                            <a href="${pageContext.request.contextPath}/my-bookings?id=${b.bookingId}" style="color: var(--primary); text-decoration: none; font-size: 0.9rem;">Chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty bookings}">
                    <tr>
                        <td colspan="5" style="padding: 3rem; text-align: center; color: var(--secondary);">Bạn chưa có đơn đặt vé nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        </div>
    </div>
</div>
</body>
</html>
