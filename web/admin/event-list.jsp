<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sự kiện - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --white: #ffffff; --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        .btn { padding: 0.5rem 1rem; border-radius: 8px; text-decoration: none; font-weight: 600; font-size: 0.9rem; }
        .btn-add { background: var(--primary); color: white; margin-bottom: 1.5rem; display: inline-block; }
        .btn-edit { color: var(--primary); margin-right: 1rem; }
        .btn-delete { color: #ef4444; }
        .table-scroll { overflow-x: auto; }
        .table-scroll table { min-width: 700px; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .table-container { padding: 1rem; }
            .header { flex-direction: column; align-items: flex-start !important; gap: 0.75rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="events" />
    </jsp:include>
    <div class="main-content">
        <div class="header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <h1>Danh Sách Sự Kiện</h1>
            <a href="events?action=add" class="btn btn-add">+ Thêm Sự Kiện Mới</a>
        </div>
        
        <div class="table-container">
            <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Ngày diễn ra</th>
                        <th>Giá vé</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${events}" var="e">
                        <tr>
                            <td>#${e.eventId}</td>
                            <td style="font-weight: 600;">${e.title}</td>
                            <td>${e.eventDate}</td>
                            <td>${e.price}đ</td>
                            <td>
                                <a href="events?action=edit&id=${e.eventId}" class="btn-edit">Sửa</a>
                                <a href="events?action=delete&id=${e.eventId}" class="btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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
