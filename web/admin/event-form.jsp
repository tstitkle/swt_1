<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${event == null ? 'Thêm Sự Kiện' : 'Sửa Sự Kiện'} - EventTick</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #6366f1; --secondary: #64748b; --background: #f1f5f9; --radius: 12px; }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Outfit', sans-serif; background: var(--background); display: flex; min-height: 100vh; flex-wrap: wrap; }
        .main-content { flex: 1; min-width: 0; padding: 3rem; display: flex; justify-content: center; }
        .form-container { background: white; padding: 2.5rem; border-radius: var(--radius); box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1); width: 100%; max-width: 700px; }
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; font-weight: 600; color: #1e293b; }
        input, textarea, select { width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px; font-family: inherit; }
        .btn-submit { background: var(--primary); color: white; border: none; padding: 1rem; width: 100%; border-radius: 8px; font-weight: 700; cursor: pointer; margin-top: 1rem; }
        .btn-back { display: block; text-align: center; margin-top: 1.5rem; color: var(--secondary); text-decoration: none; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; }
        @media (max-width: 992px) {
            .main-content { width: 100%; flex: 0 0 100%; padding: 1.25rem; }
            .form-container { padding: 1.25rem; }
            .form-row { grid-template-columns: 1fr; gap: 0.5rem; }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="events" />
    </jsp:include>
    <div class="main-content">
        <div class="form-container">
        <h1>${event == null ? 'Thêm Sự Kiện Mới' : 'Cập Nhật Sự Kiện'}</h1>
        <form action="events" method="POST">
            <input type="hidden" name="action" value="${event == null ? 'add' : 'edit'}">
            <c:if test="${event != null}">
                <input type="hidden" name="id" value="${event.eventId}">
            </c:if>
            
            <div class="form-group">
                <label>Tiêu đề sự kiện</label>
                <input type="text" name="title" value="${event.title}" required>
            </div>
            
            <div class="form-group">
                <label>Mô tả</label>
                <textarea name="description" rows="4" required>${event.description}</textarea>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Ngày & Giờ</label>
                    <input type="datetime-local" name="eventDate" value="${event.eventDate.toString().replace(' ', 'T').substring(0, 16)}" required>
                </div>
                <div class="form-group">
                    <label>Giá vé (VNĐ)</label>
                    <input type="number" name="price" value="${event.price}" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Danh mục</label>
                    <select name="categoryId" required>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.categoryId}" ${event.categoryId == c.categoryId ? 'selected' : ''}>${c.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Địa điểm</label>
                    <select name="venueId" required>
                        <c:forEach items="${venues}" var="v">
                            <option value="${v.venueId}" ${event.venueId == v.venueId ? 'selected' : ''}>${v.venueName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <button type="submit" class="btn-submit">${event == null ? 'Tạo Sự Kiện' : 'Lưu Thay Đổi'}</button>
            <a href="events" class="btn-back">← Quay lại danh sách</a>
        </form>
    </div>
    </div>
</body>
</html>
