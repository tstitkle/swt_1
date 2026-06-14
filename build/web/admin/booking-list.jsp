<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đặt vé - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --white: #ffffff; --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .table-scroll { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 780px; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        .status { padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.8rem; font-weight: 600; background: #dcfce7; color: #166534; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .table-container { padding: 1rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="bookings" />
    </jsp:include>

    <div class="main-content">
        <h1 style="margin-bottom: 2rem;">Quản lý Đặt vé</h1>
        <div class="table-container">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>User ID</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="b">
                            <tr>
                                <td>#${b.bookingId}</td>
                                <td>${b.userId}</td>
                                <td>${b.bookingDate}</td>
                                <td style="font-weight: 600; color: var(--primary);">${b.totalAmount}đ</td>
                                <td><span class="status">${b.status}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: var(--secondary); padding: 2rem;">Chưa có dữ liệu đặt vé.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
