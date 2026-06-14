<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<style>
    .hero { background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%); color: white; padding: 5rem 2rem; text-align: center; border-radius: var(--radius); margin-bottom: 3rem; }
    .event-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 2rem; }
    .hero-search { max-width: 600px; margin: 2rem auto; display: flex; gap: 0.5rem; }
    .hero-search input { flex: 1; padding: 1rem; border-radius: var(--radius); border: none; font-size: 1rem; }
    .hero-search .btn { padding: 1rem 2rem; }
    .card-footer { display: flex; justify-content: space-between; align-items: center; gap: 0.75rem; flex-wrap: wrap; }
    .card { background: white; border-radius: var(--radius); overflow: hidden; box-shadow: var(--shadow); transition: 0.3s; }
    .card:hover { transform: translateY(-5px); }
    .card-img {
        height: 200px;
        background-image: url('https://images.unsplash.com/photo-1492684223066-81342ee5ff30?auto=format&fit=crop&w=1200&q=80');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
    }
    .card-body { padding: 1.5rem; }
    .price { color: var(--primary); font-weight: 700; font-size: 1.2rem; }
    @media (max-width: 768px) {
        .hero { padding: 3rem 1rem; }
        .hero-search { flex-direction: column; }
        .hero-search .btn { width: 100%; }
        .event-grid { grid-template-columns: 1fr; }
    }
</style>

    <!-- Hero Section -->
    <header class="hero">
        <div class="container">
            <h1>Khám Phá Sự Kiện Tuyệt Vời</h1>
            <p>Tìm và đặt vé cho các buổi hòa nhạc, hội thảo và triển lãm hàng đầu.</p>
            <form action="home" method="GET" class="hero-search">
                <input type="text" name="search" placeholder="Tìm kiếm sự kiện...">
                <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            </form>
        </div>
    </header>

<div class="container">
        <!-- Category Filter -->
        <div style="margin: 2rem 0; display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center;">
            <a href="home" class="btn ${param.categoryId == null ? 'btn-primary' : 'btn-outline'}">Tất cả</a>
            <c:forEach items="${categories}" var="c">
                <a href="home?categoryId=${c.categoryId}" class="btn ${param.categoryId == c.categoryId ? 'btn-primary' : 'btn-outline'}">${c.categoryName}</a>
            </c:forEach>
        </div>

    <h2 style="margin-bottom: 2rem;">Sự Kiện Nổi Bật</h2>
    <div class="event-grid">
        <c:forEach items="${events}" var="e">
            <div class="card">
                <div class="card-img"></div>
                <div class="card-body">
                    <h3 style="margin-bottom: 0.5rem;">${e.title}</h3>
                    <p style="color: var(--secondary); margin-bottom: 1rem;">${e.eventDate}</p>
                    <div class="card-footer">
                        <span class="price">${e.price}đ</span>
                        <a href="${pageContext.request.contextPath}/event-detail?id=${e.eventId}" class="btn btn-primary">Mua Vé</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
