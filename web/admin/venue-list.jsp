<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Địa điểm - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --white: #ffffff; --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .form-card { background: white; padding: 1.25rem; border-radius: var(--radius); box-shadow: var(--shadow); margin-bottom: 1rem; }
        .form-grid { display: grid; grid-template-columns: 1.2fr 1.2fr 0.7fr auto; gap: 0.75rem; }
        .form-grid input { width: 100%; padding: 0.7rem; border: 1px solid #cbd5e1; border-radius: 8px; font-family: inherit; }
        .btn { padding: 0.6rem 1rem; border-radius: 8px; text-decoration: none; font-weight: 600; border: none; cursor: pointer; }
        .btn-primary { background: var(--primary); color: white; }
        .btn-outline { border: 1px solid #cbd5e1; color: #334155; background: white; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        .table-scroll { overflow-x: auto; }
        .table-scroll table { min-width: 700px; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .table-container { padding: 1rem; }
            .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="venues" />
    </jsp:include>
    <div class="main-content">
        <h1 style="margin-bottom: 2rem;">Địa Điểm Tổ Chức</h1>
        <div class="form-card">
            <form action="venues" method="POST" class="form-grid">
                <input type="hidden" name="action" value="${editingVenue != null ? 'edit' : 'add'}">
                <c:if test="${editingVenue != null}">
                    <input type="hidden" name="id" value="${editingVenue.venueId}">
                </c:if>
                <input type="text" name="venueName" placeholder="Tên địa điểm" value="${editingVenue.venueName}" required>
                <input type="text" name="address" placeholder="Địa chỉ" value="${editingVenue.address}" required>
                <input type="number" name="capacity" placeholder="Sức chứa" value="${editingVenue.capacity}" min="1" required>
                <button type="submit" class="btn btn-primary">${editingVenue != null ? 'Cập nhật' : 'Thêm mới'}</button>
            </form>
            <c:if test="${editingVenue != null}">
                <div style="margin-top: 0.75rem;">
                    <a href="venues" class="btn btn-outline">Hủy sửa</a>
                </div>
            </c:if>
        </div>
        <div class="table-container">
            <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Địa Điểm</th>
                        <th>Địa Chỉ</th>
                        <th>Sức Chứa</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${venues}" var="v">
                        <tr>
                            <td>#${v.venueId}</td>
                            <td style="font-weight: 600;">${v.venueName}</td>
                            <td>${v.address}</td>
                            <td>${v.capacity}</td>
                            <td>
                                <a href="venues?action=edit&id=${v.venueId}" class="btn btn-outline">Sửa</a>
                                <a href="venues?action=delete&id=${v.venueId}" class="btn btn-outline" style="color:#ef4444;" onclick="return confirm('Bạn có chắc muốn xóa địa điểm này?')">Xóa</a>
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
