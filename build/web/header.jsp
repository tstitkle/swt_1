<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EventTick - Hệ Thống Bán Vé</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --primary-dark: #4f46e5;
                    --secondary: #64748b;
                    --background: #f8fafc;
                    --text-dark: #0f172a;
                    --white: #ffffff;
                    --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
                    --radius: 12px;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background: var(--background);
                    color: var(--text-dark);
                }

                .navbar {
                    background: var(--white);
                    padding: 1rem 5%;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    box-shadow: var(--shadow);
                    position: sticky;
                    top: 0;
                    z-index: 100;
                }

                .logo {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--primary);
                    text-decoration: none;
                }

                .nav-links {
                    display: flex;
                    gap: 0.5rem;
                    align-items: center;
                }

                .auth-box {
                    display: flex;
                    align-items: center;
                }

                .user-name {
                    color: var(--secondary);
                    font-weight: 600;
                    margin-right: 0.5rem;
                }

                .dropdown {
                    position: relative;
                    display: inline-block;
                }

                .dropdown-content {
                    display: none;
                    position: absolute;
                    right: 0;
                    background: white;
                    min-width: 220px;
                    box-shadow: var(--shadow);
                    border-radius: var(--radius);
                    overflow: hidden;
                    z-index: 120;
                }

                .dropdown:hover .dropdown-content {
                    display: block;
                }

                .dropdown-content a {
                    display: block;
                    padding: 10px 15px;
                    color: var(--text-dark);
                    border-bottom: 1px solid #f1f5f9;
                    text-decoration: none;
                }

                .dropdown-content a:hover {
                    background: #f8fafc;
                    color: var(--primary);
                }

                .nav-links a {
                    text-decoration: none;
                    color: var(--secondary);
                    font-weight: 500;
                }

                .btn {
                    padding: 0.6rem 1.2rem;
                    border-radius: var(--radius);
                    font-weight: 600;
                    text-decoration: none;
                    border: none;
                    cursor: pointer;
                }

                .btn-primary {
                    background: var(--primary);
                    color: white;
                }

                .btn-outline {
                    border: 2px solid var(--primary);
                    color: var(--primary);
                }

                .container {
                    max-width: 1200px;
                    margin: 2rem auto;
                    padding: 0 1rem;
                }

                @media (max-width: 768px) {
                    .navbar {
                        gap: 0.5rem;
                        padding: 1rem;
                    }

                    .nav-links {
                        gap: 0.5rem;
                    }

                    .auth-box {
                        margin-left: auto;
                    }
                }
            </style>
        </head>

        <body>
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/home" class="logo">🎟️ EventTick</a>
                <div class="nav-links">
                    <div class="auth-box">
                        <c:choose>
                            <c:when test="${sessionScope.user == null}">
                                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">Đăng Nhập</a>
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline"
                                    style="margin-left: 0.5rem;">Đăng Ký</a>
                            </c:when>
                            <c:otherwise>
                                <div class="dropdown">
                                    <button class="btn btn-outline">👤 ${sessionScope.user.fullName} ▾</button>
                                    <div class="dropdown-content">
                                        <c:if test="${sessionScope.user.roleId == 1}">
                                            <a href="${pageContext.request.contextPath}/admin/dashboard"
                                                style="font-weight: 700; color: var(--primary);">Admin Panel</a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/profile">Thay đổi thông tin cá nhân</a>
                                        <a href="${pageContext.request.contextPath}/my-bookings">Vé đã đặt</a>
                                        <a href="${pageContext.request.contextPath}/logout" style="color: #ef4444;">Đăng xuất</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav>