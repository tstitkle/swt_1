<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --secondary: #64748b;
            --background: #f1f5f9;
            --white: #ffffff;
            --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --radius: 12px;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 3rem; }
        
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 1.5rem; margin-bottom: 3rem; }
        .stat-card { background: white; padding: 1.5rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .stat-card h3 { color: var(--secondary); font-size: 0.9rem; margin-bottom: 0.5rem; text-transform: uppercase; }
        .stat-card .value { font-size: 2rem; font-weight: 700; color: #1e293b; }
        
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .table-container h3 { margin-bottom: 1.5rem; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        
        .status { padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.8rem; font-weight: 600; }
        .status-completed { background: #dcfce7; color: #166534; }
        .status-pending { background: #fef9c3; color: #854d0e; }
        .table-scroll { overflow-x: auto; }
        .table-scroll table { min-width: 720px; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .header { flex-direction: column; align-items: flex-start; gap: 0.75rem; margin-bottom: 1.5rem; }
            .table-container { padding: 1rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>
    
    <div class="main-content">
        <div class="header">
            <h1>Tổng Quan Hệ Thống</h1>
            <div style="color: var(--secondary);">Chào, Admin! 👋</div>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>Tổng Người Dùng</h3>
                <div class="value">${totalUsers}</div>
            </div>
            <div class="stat-card">
                <h3>Tổng Sự Kiện</h3>
                <div class="value">${totalEvents}</div>
            </div>
            <div class="stat-card">
                <h3>Tổng Đơn Đặt Vé</h3>
                <div class="value">${totalBookings}</div>
            </div>
        </div>
        
        <div class="table-container">
            <h3>Đơn Đặt Vé Gần Đây</h3>
            <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>Mã Đơn</th>
                        <th>Khách Hàng (ID)</th>
                        <th>Ngày Đặt</th>
                        <th>Tổng Tiền</th>
                        <th>Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recentBookings}" var="b">
                        <tr>
                            <td>#${b.bookingId}</td>
                            <td>User #${b.userId}</td>
                            <td>${b.bookingDate}</td>
                            <td style="font-weight: 600;">${b.totalAmount}đ</td>
                            <td>
                                <span class="status ${b.status == 'COMPLETED' ? 'status-completed' : 'status-pending'}">${b.status}</span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</body>
</html>
