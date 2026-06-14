<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .sidebar { 
        width: 260px; 
        background: #1e293b; 
        color: white; 
        padding: 2rem 1.5rem; 
        display: flex; 
        flex-direction: column; 
        min-height: 100vh;
        position: sticky;
        top: 0;
    }
    .sidebar h2 { font-size: 1.5rem; margin-bottom: 2.5rem; color: #818cf8; }
    .nav-item { 
        padding: 0.75rem 1rem; 
        color: #cbd5e1; 
        text-decoration: none; 
        border-radius: 8px; 
        margin-bottom: 0.5rem; 
        transition: 0.2s; 
        display: block;
    }
    .nav-item:hover, .nav-item.active { background: #334155; color: white; }
    @media (max-width: 992px) {
        .sidebar {
            width: 100%;
            min-height: auto;
            position: static;
            padding: 1rem;
        }
        .sidebar h2 { margin-bottom: 1rem; }
        .nav-item { margin-bottom: 0.35rem; }
    }
</style>

<div class="sidebar">
    <h2>🎟️ EventTick</h2>
    <a href="dashboard" class="nav-item ${param.activePage == 'dashboard' ? 'active' : ''}">Dashboard</a>
    <a href="events" class="nav-item ${param.activePage == 'events' ? 'active' : ''}">Quản lý Sự kiện</a>
    <a href="categories" class="nav-item ${param.activePage == 'categories' ? 'active' : ''}">Quản lý Danh mục</a>
    <a href="venues" class="nav-item ${param.activePage == 'venues' ? 'active' : ''}">Quản lý Địa điểm</a>
    <a href="users" class="nav-item ${param.activePage == 'users' ? 'active' : ''}">Quản lý Người dùng</a>
    <div style="margin-top: auto;">
        <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color: #ef4444;">Đăng xuất</a>
    </div>
</div>
