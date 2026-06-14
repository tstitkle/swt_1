<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --white: #ffffff; --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); max-width: 600px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        .table-scroll { overflow-x: auto; }
        .table-scroll table { min-width: 420px; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .table-container { padding: 1rem; max-width: none; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="categories" />
    </jsp:include>
    <div class="main-content">
        <h1 style="margin-bottom: 2rem;">Danh Mục Sự Kiện</h1>
        <div class="table-container">
            <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Danh Mục</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="c">
                        <tr>
                            <td>#${c.categoryId}</td>
                            <td style="font-weight: 600;">${c.categoryName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    </div>
</body>
</html>
