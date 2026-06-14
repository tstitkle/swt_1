<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
    .table-scroll { overflow-x: auto; }
    .detail-table { width: 100%; border-collapse: collapse; min-width: 760px; }
    .summary-card { background: white; border-radius: var(--radius); box-shadow: var(--shadow); padding: 1.25rem; margin-bottom: 1rem; }
    .summary-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 1rem; }
</style>
<div class="container">
    <a href="${pageContext.request.contextPath}/my-bookings" style="color: var(--primary); text-decoration: none;">← Quay lại danh sách đơn</a>

    <c:choose>
        <c:when test="${booking == null}">
            <div class="summary-card" style="margin-top: 1rem;">
                <p style="color: #ef4444;">Không tìm thấy đơn hàng hoặc bạn không có quyền xem đơn này.</p>
            </div>
        </c:when>
        <c:otherwise>
            <h2 style="margin: 1rem 0;">Chi tiết đơn #${booking.bookingId}</h2>
            <div class="summary-card">
                <div class="summary-grid">
                    <div>
                        <div style="color: var(--secondary); font-size: 0.9rem;">Ngày đặt</div>
                        <div style="font-weight: 600;">${booking.bookingDate}</div>
                    </div>
                    <div>
                        <div style="color: var(--secondary); font-size: 0.9rem;">Trạng thái</div>
                        <div style="font-weight: 600;">${booking.status}</div>
                    </div>
                    <div>
                        <div style="color: var(--secondary); font-size: 0.9rem;">Tổng tiền</div>
                        <div style="font-weight: 700; color: var(--primary);">${booking.totalAmount}đ</div>
                    </div>
                </div>
            </div>

            <div style="background: white; border-radius: var(--radius); box-shadow: var(--shadow); overflow: hidden;">
                <div class="table-scroll">
                    <table class="detail-table">
                        <thead style="background: #f8fafc; border-bottom: 1px solid #e2e8f0;">
                            <tr>
                                <th style="padding: 1rem 1.25rem;">Sự kiện</th>
                                <th style="padding: 1rem 1.25rem;">Ngày diễn ra</th>
                                <th style="padding: 1rem 1.25rem;">Số lượng</th>
                                <th style="padding: 1rem 1.25rem;">Đơn giá</th>
                                <th style="padding: 1rem 1.25rem;">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${items}" var="item">
                                <tr style="border-bottom: 1px solid #f1f5f9;">
                                    <td style="padding: 1rem 1.25rem; font-weight: 600;">${item.eventTitle}</td>
                                    <td style="padding: 1rem 1.25rem;">${item.eventDate}</td>
                                    <td style="padding: 1rem 1.25rem;">${item.quantity}</td>
                                    <td style="padding: 1rem 1.25rem;">${item.unitPrice}đ</td>
                                    <td style="padding: 1rem 1.25rem; color: var(--primary); font-weight: 700;">${item.unitPrice * item.quantity}đ</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty items}">
                                <tr>
                                    <td colspan="5" style="padding: 2rem; text-align: center; color: var(--secondary);">Đơn này chưa có dòng vé chi tiết.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
