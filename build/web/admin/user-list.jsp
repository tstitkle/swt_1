<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --white: #ffffff; --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1); --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 2.5rem; }
        .table-container { background: white; padding: 2rem; border-radius: var(--radius); box-shadow: var(--shadow); }
        .form-card { background: white; padding: 1.25rem; border-radius: var(--radius); box-shadow: var(--shadow); margin-bottom: 1rem; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr 1fr 0.8fr 0.8fr auto; gap: 0.75rem; }
        .form-grid input, .form-grid select { width: 100%; padding: 0.7rem; border: 1px solid #cbd5e1; border-radius: 8px; font-family: inherit; }
        .btn { padding: 0.55rem 0.9rem; border-radius: 8px; text-decoration: none; font-weight: 600; border: none; cursor: pointer; display: inline-block; }
        .btn-primary { background: var(--primary); color: white; }
        .btn-outline { border: 1px solid #cbd5e1; color: #334155; background: white; }
        .table-scroll { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 980px; }
        th { text-align: left; padding: 1rem; background: #f8fafc; color: var(--secondary); border-bottom: 1px solid #e2e8f0; }
        td { padding: 1rem; border-bottom: 1px solid #f1f5f9; }
        .role { padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.8rem; font-weight: 600; }
        .role-admin { background: #e0e7ff; color: #3730a3; }
        .role-user { background: #dcfce7; color: #166534; }
        .status-active { color: #166534; font-weight: 700; }
        .status-inactive { color: #b91c1c; font-weight: 700; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .table-container { padding: 1rem; }
            .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="users" />
    </jsp:include>

    <div class="main-content">
        <h1 style="margin-bottom: 2rem;">Quản lý Người dùng</h1>
        <div class="form-card">
            <form action="users" method="POST" class="form-grid">
                <input type="hidden" name="action" value="${editingUser != null ? 'edit' : 'add'}">
                <c:if test="${editingUser != null}">
                    <input type="hidden" name="id" value="${editingUser.userId}">
                </c:if>
                <input type="text" name="username" placeholder="Tên đăng nhập" value="${editingUser.username}" ${editingUser != null ? 'readonly' : ''} required>
                <input type="${editingUser != null ? 'text' : 'password'}" name="password" placeholder="${editingUser != null ? 'Mật khẩu giữ nguyên' : 'Mật khẩu'}" ${editingUser != null ? '' : 'required'}>
                <input type="text" name="fullName" placeholder="Họ và tên" value="${editingUser.fullName}" required>
                <input type="email" name="email" placeholder="Email" value="${editingUser.email}" required>
                <select name="roleId" required>
                    <option value="2" ${editingUser.roleId == 2 ? 'selected' : ''}>CUSTOMER</option>
                    <option value="1" ${editingUser.roleId == 1 ? 'selected' : ''}>ADMIN</option>
                </select>
                <button type="submit" class="btn btn-primary">${editingUser != null ? 'Cập nhật' : 'Thêm mới'}</button>
            </form>
            <c:if test="${editingUser != null}">
                <div style="margin-top: 0.75rem;">
                    <a href="users" class="btn btn-outline">Hủy sửa</a>
                </div>
            </c:if>
        </div>
        <div class="table-container">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên đăng nhập</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="u">
                            <tr>
                                <td>#${u.userId}</td>
                                <td style="font-weight: 600;">${u.username}</td>
                                <td>${u.fullName}</td>
                                <td>${u.email}</td>
                                <td>
                                    <span class="role ${u.roleId == 1 ? 'role-admin' : 'role-user'}">
                                        ${u.roleId == 1 ? 'ADMIN' : 'CUSTOMER'}
                                    </span>
                                </td>
                                <td>
                                    <span class="${u.active ? 'status-active' : 'status-inactive'}">
                                        ${u.active ? 'ACTIVE' : 'DEACTIVE'}
                                    </span>
                                </td>
                                <td>
                                    <a href="users?action=edit&id=${u.userId}" class="btn btn-outline">Sửa</a>
                                    <a href="users?action=toggle&id=${u.userId}&active=${u.active ? 0 : 1}" class="btn btn-outline" style="${u.active ? 'color:#b91c1c;' : 'color:#166534;'}">
                                        ${u.active ? 'Deactive' : 'Active'}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="7" style="text-align: center; color: var(--secondary); padding: 2rem;">Chưa có dữ liệu người dùng.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
