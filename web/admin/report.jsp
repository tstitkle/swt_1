<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --white: #ffffff; --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
        .stat-card { background: white; padding: 1.25rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .stat-card h3 { color: var(--secondary); font-size: 0.9rem; margin-bottom: 0.4rem; text-transform: uppercase; }
        .stat-card .value { font-size: 1.8rem; font-weight: 700; color: #1e293b; }
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .table-scroll { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 780px; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .table-container { padding: 1rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="reports" />
    </jsp:include>

    <div class="main-content">
        <h1 style="margin-bottom: 1.5rem;">Báo cáo hệ thống</h1>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>Tổng người dùng</h3>
                <div class="value">${totalUsers}</div>
            </div>
            <div class="stat-card">
                <h3>Tổng sự kiện</h3>
                <div class="value">${totalEvents}</div>
            </div>
            <div class="stat-card">
                <h3>Tổng đơn đặt vé</h3>
                <div class="value">${totalBookings}</div>
            </div>
        </div>

        <div class="table-container">
            <h3 style="margin-bottom: 1rem;">10 đơn gần nhất</h3>
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
                        <c:forEach items="${recentBookings}" var="b">
                            <tr>
                                <td>#${b.bookingId}</td>
                                <td>${b.userId}</td>
                                <td>${b.bookingDate}</td>
                                <td style="font-weight: 600; color: var(--primary);">${b.totalAmount}đ</td>
                                <td>${b.status}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentBookings}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: var(--secondary); padding: 2rem;">Chưa có dữ liệu báo cáo.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
